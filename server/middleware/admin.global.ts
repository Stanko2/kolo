import { getServerSession } from "#auth";
import prisma from "~/lib/prisma";


export default defineEventHandler(async (event)=> {
    const session = await getServerSession(event);
    console.log("New request: ", event.path);
    
    if (event.path.startsWith('/admin')){
        if (!session?.user){
            throw createError({
                statusCode: 401,
                statusMessage: 'Unauthorized',
            });
        } else {
            const isAdmin = (await prisma.user.findFirst({
                where: {
                    name: session.user.name,
                    email: session.user.email ?? undefined,
                },
                select: {
                    admin: true,
                }
            }))?.admin;
            if (!isAdmin){
                throw createError({
                    statusCode: 403,
                    statusMessage: 'Forbidden',
                });
            }
        }
    }
})