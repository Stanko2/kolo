import prisma from "~/lib/prisma";
import nodemailer from "nodemailer";
import fs from "fs";
import path from "path";
import {Organization} from "@prisma/client";

const emailSender = 'kolo.mailtest@gmail.com';
const emailPassword = 'xheb zmwk rkxv crml';

export default defineEventHandler(async (event)=>{

    if (!event.context.user.admin){
        return new Response("Not authorized", {
            status: 401,
        });
    }

    const organizations = await prisma.organization.findMany({
        where: {
            invited: false,
        },
    })


    sendEmailsToOrganizations(organizations);

    return new Response("success", {})
})

// Configure Nodemailer
const transporter = nodemailer.createTransport({
    service: "gmail",
    auth: {
        user: emailSender,
        pass: emailPassword,
    },
});

function loadTemplate(): string {
    return fs.readFileSync("server/api/admin/MailInvitation.html", "utf8");
}

async function sendEmailsToOrganizations(organizations: Organization[]) {


        // Iterate over each organization and send a personalized email
        for (const org of organizations) {
            // Format the product list into HTML


            // Load the email template and replace the {{PRODUCTS}} placeholder
            const emailHtml = loadTemplate().replace("{{TOKEN}}", org.emailToken);

            try {
                // Send the email
                await transporter.sendMail({
                    from: emailSender,
                    to: org.email,
                    subject: "KOLO Recommendations",
                    html: emailHtml,
                });

                await prisma.organization.update({
                    where:{
                        id: org.id,
                    },data: {
                        invited: true,
                    }
                })

               console.log(`Email sent to ${org.name} (${org.email})`);
            } catch (error) {
                console.error("Error sending emails:", error);
            }
        }
}


