<script setup lang="ts">
definePageMeta({
  layout: 'admin',
  auth: true
})

const route = useRoute()
</script>

<template>
  <div>
    <Button label="test" />
    <h1>Nuxt Routing set up successfully!</h1>
    <p>Current route: {{ route.path }}</p>
    <i class="pi pi-check"></i>
    <i class="pi pi-times"></i>
    <a href="https://nuxt.com/docs/getting-started/routing" target="_blank">Learn more about Nuxt Routing</a>
  </div>
</template>
