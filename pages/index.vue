<script setup lang="ts">
definePageMeta({
  auth: false
})

const route = useRoute()
const auth = useAuth()

const router = useRouter()

function register() {
  router.push('/registration/87cd56a6-21bf-4eb4-a58a-07f0fd27a189')
}
</script>

<template>
  <div class="text-center mt-24">

    <h1 class="text-6xl font-bold mb-6">Welcome!</h1>
    <p class="text-xl font-bold mb-6">This is the registration page of KOLO, the Bratislava reuse center.</p>
    <div>
      <Button label="Register" @click="register" />
    </div>
  </div>
</template>
