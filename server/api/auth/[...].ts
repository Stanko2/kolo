import { NuxtAuthHandler } from "#auth";
//@ts-ignore
import CredentialsProvider from "next-auth/providers/credentials";
import prisma from "~/lib/prisma";
import bcrypt from 'bcrypt'

export default NuxtAuthHandler({
  providers: [
    // @ts-ignore
    CredentialsProvider.default({
      name: "Credentials",
      credentials: {
        username: {
          label: "Username",
          type: "text",
          placeholder: "Používateľské meno",
        },
        password: {
          label: "Password",
          type: "password",
          placeholder: "heslo",
        },
      },
      async authorize(credentials: any) {
        console.log("credentials", credentials)
        const user = await prisma.user.findFirst({
          where: {
            name: credentials?.username,
         }
        })


        if (user && await compare(credentials.password, user.password)) {
          // Any object returned will be saved in `user` property of the JWT
          return user;
        } else {
          // If you return null then an error will be displayed advising the user to check their details.
          // throw new Error("Zlé meno, alebo heslo");
          return null;
          // You can also Reject this callback with an Error thus the user will be sent to the error page with the error message as a query parameter
        }
      },
    }),
  ],
  secret: useRuntimeConfig().secret,
});

async function compare(password: string, hashedPassword: string): Promise<boolean> {
  return new Promise(resolve=>{
    bcrypt.compare(password, hashedPassword, (err, same)=>{
      resolve(same)
    })
  })
}