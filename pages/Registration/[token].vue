<script setup lang="ts">
definePageMeta({
  auth: false
})

import {useFetch} from "#app";
import {$fetch} from "ofetch";

const route = useRoute()
const router = useRouter()

interface OrganizationData {
  id: number
  name: string
  email: string
  ICO: string
  address: string
}

const organization = ref<OrganizationData>({
  id: -1,
  name: "",
  email: "",
  ICO: "",
  address: "",
})

const password = ref("")
const passCheck = ref("")
const userName = ref("")
const auth = useAuth()
const loading = ref(true)

async function register() {
  if (password.value != passCheck.value){
    return
  }
  const org = await $fetch("/api/organization/register", {
    method: "POST",
    body: {
      token: route.params.token,
      data: organization.value,
      username: userName.value,
      password: password.value,
    }
  })
  const a = await auth.signIn(undefined)
  console.log(a)
  await router.push('/preferences')
}

onMounted(()=>{
  console.log(auth.status.value)
  if(auth.status.value == 'authenticated') {
    router.push('/preferences')
  }

  $fetch(`/api/organization/${route.params.token}`).then(res => {
    organization.value = res
  })
})

</script>

<template>
  <div>
    <Fieldset legend="1. Login credentials">
      <FloatLabel variant="on">
        <InputText id="name" v-model="userName" />
        <label for="name">Username</label>
      </FloatLabel>
      <FloatLabel variant="on">
        <Password id="password" v-model="password" />
        <label for="password">Password</label>
      </FloatLabel>
      <FloatLabel variant="on">
        <Password id="passwordCheck" v-model="passCheck" />
        <label for="passwordCheck">Password Again</label>
      </FloatLabel>
    </Fieldset>

    <Fieldset legend="2. Organization information">
      <p class="mb-2">Check if they are correct</p>
      <FloatLabel variant="on">
        <InputText id="orgName" label="Meno" v-model="organization.name" />
        <label for="orgName">Organization name</label>
      </FloatLabel>
      <FloatLabel variant="on">
        <InputText id="ico" v-model="organization.ICO" />
        <label for="ico">IČO</label>
      </FloatLabel>
      <FloatLabel variant="on">
        <InputText id="email" v-model="organization.email" />
        <label for="email">e-mail</label>
      </FloatLabel>
      <FloatLabel variant="on">
        <InputText id="address" fluid v-model="organization.address" />
        <label for="address">Address</label>
      </FloatLabel>
    </Fieldset>
    <Button label="Continue" fluid @click="register"  />
  </div>
</template>

<style scoped>

</style>