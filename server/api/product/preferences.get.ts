import prisma from "~/lib/prisma";

export default defineEventHandler(async (event) => {
    const org = await prisma.organization.findFirst({
        where: {
            User: {
                id: event.context.user?.id ?? -1
            }
        },
        select: {
            id: true
        }
    })

    if (!org) {
        setResponseStatus(event, 403)
        return
    }

    const categories = await prisma.category.findMany({
        include: {
            products: true
        }
    });

    const interested_items = await prisma.interestedProduct.findMany({
        where: {
            organizationId: org.id
        },
        select: {
            Product: {
                select: {
                    id: true,
                    name: true,
                    Category: {
                        select: {
                            name: true
                        }
                    }
                }
            }
        }
    })

    const watched_items = await prisma.watchedProduct.findMany({
        where: {
            organizationId: org.id
        },
        select: {
            Product: {
                select: {
                    id: true,
                    name: true,
                    Category: {
                        select: {
                            name: true
                        }
                    }
                }
            }
        }
    })

    for (const category of categories) {
        for (const product of category.products) {
            if(interested_items.find(e=> e.Product.id == product.id)) {
                //@ts-ignore
                product.interested = true
            } else {
                //@ts-ignore
                product.interested = false
            }
            if (watched_items.find(e=>e.Product.id == product.id)) {
                //@ts-ignore
                product.watching = true
            } else {
                //@ts-ignore
                product.watching = false
            }
        }
    }

    return categories
})