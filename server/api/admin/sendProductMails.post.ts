import prisma from "~/lib/prisma";
import nodemailer from "nodemailer";
import fs from "fs";
import {Organization} from "@prisma/client";

const emailSender = 'kolo.mailtest@gmail.com';
const emailPassword = 'xheb zmwk rkxv crml';

export default defineEventHandler(async (event)=>{
    const body = await readBody(event)
    const org = body.data

    if (!event.context.user.admin){
        return new Response("Not authorized", {
            status: 401,
        });
    }

    const organizations = await prisma.organization.findMany({
        where: {
            watchedProducts: {
                some: {
                    productId: { in: org.productsIds },
                },
            },
        },
        include: {
            User: true,
            watchedProducts: true,
        }
    })


    sendEmailsToOrganizations(organizations);
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
    return fs.readFileSync("server/api/admin/MailNewProducts.html", "utf8");
}

async function sendEmailsToOrganizations(organizations: Organization[]) {


        // Iterate over each organization and send a personalized email
        for (const org of organizations) {
            // Format the product list into HTML
            const productListHtml = org.watchedProducts.map(
                    (item) => `
          <div style="margin-bottom: 15px; padding: 10px; border: 1px solid #e0e0e0; border-radius: 5px;">
            <h4 style="color: #333333; margin: 0;">${item.Product.name}</h4>
            <p style="margin: 5px 0; color: #555555;">A brief description of ${item.Product.name}.</p>
            <a href="https://www.example.com/item/${item.Product.id}" style="color: #d89a02; text-decoration: none; font-weight: bold;">View Item</a>
          </div>`
                )
                .join("");

            // Load the email template and replace the {{PRODUCTS}} placeholder
            const emailHtml = loadTemplate().replace("{{PRODUCTS}}", productListHtml);

            try {
                // Send the email
                await transporter.sendMail({
                    from: emailSender,
                    to: org.email,
                    subject: "KOLO Recommendations",
                    html: emailHtml,
                });

                console.log(`Email sent to ${org.name} (${org.email})`);
            } catch (error) {
                console.error("Error sending emails:", error);
            }
        }
}


