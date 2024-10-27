import prisma from "~/lib/prisma";

export default defineEventHandler(async (event) => {
    if (!event.context.user?.admin) {
        setResponseStatus(event, 403)
        return
    }

    const orders = await prisma.order.findMany({
        where: {
            NOT: {
                state: "done"
            }
        },
        orderBy: {
            date: 'desc'
        },
        select: {

        }
    })
})