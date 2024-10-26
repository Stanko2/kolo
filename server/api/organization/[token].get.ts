import prisma from "~/lib/prisma";

export default defineEventHandler(async (event) => {
    const token = getRouterParam(event, 'token');

    const organization = await prisma.organization.findFirst({
        where: {
            emailToken: token,
        }
    })

    if(!organization) {
        setResponseStatus(event, 404);
        return {}
    }

    return organization
})