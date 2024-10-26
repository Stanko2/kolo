import prisma from "~/lib/prisma";
import bcrypt from "bcrypt";

export default defineEventHandler(async (event)=> {
    if(event.method !== "POST") {
        return Promise.reject("Method not allowed.");
    }
    const body = await readBody(event)

    await prisma.user.create({
        data: {
            name: body.name,
            email: body.email,
            password: await hash_password(body.password),
        }
    })

    return {
        status: "success",
    }
})

async function hash_password(password: string): Promise<string> {
    const saltRounds = 10;
    return new Promise((resolve)=>{
        bcrypt.hash(password, saltRounds, (err, hash: string) => {
            resolve(hash)
        })
    })
}