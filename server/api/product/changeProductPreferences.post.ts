import prisma from "~/lib/prisma";

export default defineEventHandler(async (event) => {
    const body = await readBody(event)

    const organization_ = await prisma.organization.findFirst({
        where: {
            User: {
                id: event.context.user.id,
            }
        },
    })

    if (organization_ == null) {
        setResponseStatus(event, 403)
        return
    }

    if(body.interestedProductIds != undefined){
        await prisma.interestedProduct.deleteMany({
            where: {
                organizationId: organization_!.id,
            },
        })
        await prisma.interestedProduct.createMany({
            data: body.interestedProductIds.map((e: number)=>{return  {organizationId: organization_?.id, productId: e}})
        })
    }

    if (body.watchedProductIds != undefined) {
        await prisma.watchedProduct.deleteMany({
            where: {
                organizationId: organization_!.id,
            },
        })

        await prisma.watchedProduct.createMany({
            data: body.watchedProductIds.map((e: number)=>{return  {organizationId: organization_?.id, productId: e}})
        })
    }


    return {
        status: "success",
    };
});
