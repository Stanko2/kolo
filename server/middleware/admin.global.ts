import { getServerSession } from "#auth";
import prisma from "~/lib/prisma";


export default defineEventHandler(async (event)=> {
    const session = await getServerSession(event);
    if (!session || !session.user) {
        event.context.user = {}
        return
    }

    console.log(session)

    const user = (await prisma.user.findFirst({
        where: {
            name: session.user!.name,
        },
        select: {
            admin: true,
            email: true,
            name: true,
            id: true,
        }
    }));

    event.context.user = user
})