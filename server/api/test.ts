import prisma from "~/lib/prisma";

export default defineEventHandler(async (event) => {
  await new Promise((resolve) => setTimeout(resolve, 1000));
  console.log("Hello test", event.context.auth);
  
  if (event.method == "POST") {
    return new Response("No data", {
      status: 400,
    });
  }

  return{
    "users": await prisma.user.findMany()
  } ;
});
