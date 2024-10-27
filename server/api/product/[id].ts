import prisma from "~/lib/prisma";

export default defineEventHandler(async (event) => {

    const productId: number = parseInt(getRouterParam(event, 'id')?? '-1')

    const product = await prisma.product.findFirst({
        where: {
            id: productId,
        },
    })

    return product;
})