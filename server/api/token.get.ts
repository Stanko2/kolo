import { eventHandler } from 'h3'
import { getToken } from '#auth'
import prisma from '~/lib/prisma'

export default defineEventHandler(async (event)=> {
    const token = await getToken({ event })
    if(!token) return null;
    const user = await prisma.user.findUnique({
        where: {
            name: token?.name,
            email: token?.email ?? undefined
        }
    })
    return user;

})