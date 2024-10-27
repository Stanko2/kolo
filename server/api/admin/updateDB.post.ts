import prisma from "~/lib/prisma";
import fs from "fs";
import path from "path";
import {Organization} from "@prisma/client";



export default defineEventHandler(async (event)=>{
    if (!event.context.user.admin){
        return new Response("Not authorized", {
            status: 401,
        });
    }

    const body = (await readBody(event)).text

    const lines = body.split('\n')

    console.log(body)
    console.log(lines)

    const organizations = lines.map((line:string) => line.split(';'))

    console.log(organizations)

    await prisma.organization.createMany({
        data: organizations.map((org: any) => ({
            name: org[2],
            ICO: org[1],
            address: org[5],
            description: org[3] || "", // Example fields, customize as needed
            email: org[0],
            active: true,
        })),
    })



    return new Response("success", {})
})
