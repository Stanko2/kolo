<script setup lang="ts">

import {useFetch} from "#app";
import {$fetch} from "ofetch";

const route = useRoute()

interface OrganizationData {
  name: string
  email: string
  ICO: string
  address: string
}

const organization = ref<OrganizationData>({
  name: "",
  email: "",
  ico: "",
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
  await $fetch("/api/organization/register", {
    method: "POST",
    body: {
      token: route.params.token,
      data: organization.value,
      username: userName.value,
      password: password.value,
    }
  })
  await $fetch("/api/auth/signin", {
    method: "POST",
    body: {
      username: userName.value,
      password: password.value,
    }
  })
}

onMounted(()=>{
  $fetch(`/api/organization/${route.params.token}`).then(res => {
    organization.value = res
  })
})

</script>

<template>
  <div>
    <Fieldset legend="1. Prihlasovacie udaje">
      <FloatLabel variant="on">
        <InputText id="name" />
        <label for="name">Prihlasovacie meno</label>
      </FloatLabel>
      <FloatLabel variant="on">
        <Password id="password" v-model="password" />
        <label for="password">Heslo</label>
      </FloatLabel>
      <FloatLabel variant="on">
        <Password id="passwordCheck" v-model="passCheck" />
        <label for="passwordCheck">Heslo znova</label>
      </FloatLabel>
    </Fieldset>

    <Fieldset legend="2. Informácie o organizácii">
      <p class="mb-2">Skontroluj či sedia</p>
      <FloatLabel variant="on">
        <InputText id="orgName" label="Meno" v-model="organization.name" />
        <label for="orgName">Meno organizácie</label>
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
        <label for="address">Sídlo</label>
      </FloatLabel>
    </Fieldset>
    <Button label="Pokračovať" fluid @click="register"  />
  </div>
</template>

<style scoped>

</style>