import prisma from "~/lib/prisma";

export default defineEventHandler(async (event) => {
  console.log("Hello test", event.context.user);
  
  if (event.method == "POST") {
    return new Response("No data", {
      status: 400,
    });
  }

  return{
    "users": await prisma.user.findMany()
  } ;
});
