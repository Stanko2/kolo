import prisma from "~/lib/prisma";
import bcrypt from "bcrypt";

export default defineEventHandler(async (event)=>{
    const body = await readBody(event)
    const org = body.data

    const user = await prisma.user.create({
        data: {
            name: body.username,
            password: await hash_password(body.password),
            email: org.email,
            organization_id: org.id
        }
    })


    const organization = await prisma.organization.update({
        where: {
            emailToken: body.token
        },
        data: {
            ICO: org.ICO,
            address: org.address,
            description: org.description,
            name: org.name,
            User: {
                connect: {
                    id: user.id
                }
            }
        },
        include: {
            User: true
        }
    })

    return organization;
})

async function hash_password(password: string): Promise<string> {
    const saltRounds = 10;
    return new Promise((resolve)=>{
        bcrypt.hash(password, saltRounds, (err, hash: string) => {
            resolve(hash)
        })
    })
}