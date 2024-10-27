import prisma from "~/lib/prisma";
import {context} from "esbuild";

export default defineEventHandler(async (event) => {
    const body = await readBody(event)

    if (!event.context.user) {
        setResponseStatus(event, 403)
        return
    }

    const organization = await prisma.organization.findFirst({
        where: {
            User: {
                id: event.context.user.id,
            }
        }
    })

    console.log(body.items)

    await prisma.order.create({
        data: {
            organizationId: organization?.id,
            state: "sent",
            date: body.date,
            pickupPlace: body.pickupPlace,
            products: {
                createMany: {
                    data: body.items.map((item: any) => {
                        return {
                            count: item.count,
                            description: item.details,
                            accepted: false,
                            productId: item.productId,
                        }
                    })
                }
            }
        }
    })


    return {
        status: "success",
    };
});
