<script setup lang="ts">
definePageMeta({
  auth: false
})

const route = useRoute()
const auth = useAuth()
</script>

<template>
  <div>
    <Button label="signout" @click="auth.signOut()" />
    <Button label="signin" @click="auth.signIn(undefined, {})" />
    <h1>Nuxt Routing set up successfully!</h1>
    {{ auth.data }}
    <p>Current route: {{ route.path }}</p>
    <i class="pi pi-check"></i>
    <i class="pi pi-times"></i>
    <a href="https://nuxt.com/docs/getting-started/routing" target="_blank">Learn more about Nuxt Routing</a>
  </div>
</template>
