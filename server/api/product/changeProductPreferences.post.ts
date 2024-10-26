import prisma from "~/lib/prisma";

export default defineEventHandler(async (event) => {
    const body = await readBody(event)

    const organization_ = await prisma.organization.findUnique({
        where: {
            userId: event.context.user.id,
        },
    })

    await prisma.interestedProduct.deleteMany({
        where: {
            organizationId: organization_!.id,
        },
    })

    await prisma.watchedProduct.deleteMany({
        where: {
            organizationId: organization_!.id,
        },
    })

    await prisma.interestedProduct.createMany({
        data: body.interestedProductIds.map((e: number)=>{return  {organizationId: organization_?.id, productId: e}})
    })

    await prisma.watchedProduct.createMany({
        data: body.watchedProductIds.map((e: number)=>{return  {organizationId: organization_?.id, productId: e}})
    })


    return new Response("Bad request", {status:400});
});
