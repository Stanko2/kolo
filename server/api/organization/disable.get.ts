import prisma from "~/lib/prisma";

export default defineEventHandler(async (event) => {
    console.log("Hello test", event.context.user);


    await prisma.organization.update({
        where: {
            userId: event.context.user.id,
        }, data: {
            active: false,
        }
    })
    // disable organization
    return{
        "success": true,
    } ;
});
