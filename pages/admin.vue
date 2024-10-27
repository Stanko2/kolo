<script setup lang="ts">
import {$fetch} from "ofetch";

definePageMeta({
  layout: 'admin',
  auth: true
})

const route = useRoute()
const csv = ref("")

async function Invite(){
  $fetch("/api/admin/sendInvitatoinMails")
}

async function send(){
  const text = csv.value;

  $fetch("/api/admin/updateDB", {method: "POST", body: {text:text}})
}
</script>

<template>
  <div>
    <Button label="test" />
    <h1>Nuxt Routing set up successfully!</h1>
    <p>Current route: {{ route.path }}</p>
    <i class="pi pi-check"></i>
    <i class="pi pi-times"></i>
    <a href="https://nuxt.com/docs/getting-started/routing" target="_blank">Learn more about Nuxt Routing</a>
    <button @click="Invite" > SEND INVITATIONS </button>

    <textarea v-model="csv"></textarea>
    <button @click="send"> UPDATE DB </button>

  </div>
</template>
