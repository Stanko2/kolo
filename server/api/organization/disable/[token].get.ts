import prisma from "~/lib/prisma";

export default defineEventHandler(async (event) => {
    console.log("Hello test", event.context.user);
    const token = getRouterParam(event, 'token');


    await prisma.organization.update({
        where: {
            emailToken: token,
        }, data: {
            active: false,
        }
    })
    // disable organization
    return{
        "success": true,
    } ;
});
