import Aura from '@primevue/themes/aura'

// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  compatibilityDate: '2024-04-03',
  devtools: { enabled: true },
  modules: [
    '@prisma/nuxt',
    '@primevue/nuxt-module',
    '@sidebase/nuxt-auth',
    '@nuxtjs/tailwindcss'
  ],
  auth: {
    globalAppMiddleware: {
      isEnabled: true,
    },
    baseURL: "http://localhost:3000",
    provider: {
      type: "authjs",
    },
  },
  runtimeConfig: {
    secret: "my-secret",
  },
  prisma: { autoSetupPrisma: true },
  primevue: {
    autoImport: true,
    options: {
      theme: {
        preset: Aura
      }
    }
  }
})
