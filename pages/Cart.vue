<script setup lang="ts">

import type {Product} from "@prisma/client";
import {$fetch} from "ofetch";

interface CartItem {
  productId: number;
  count: number;
  details: string;
}

const cart = ref<CartItem[]>([])
const withdrawalDate = ref<Date>(new Date())
const products = ref<Record<number, Product>>([])
const pickUpPlace = ref("pestovatelska")
const loading = ref(false)

async function fetchProduct(id: number) {
  const product = await $fetch(`/api/product/${id}`, {})
  products.value[id] = product
}

function deleteProduct(id: number) {
  const idx = cart.value.findIndex(e=>e.productId === id)
  if (idx >= 0) {
    cart.value.splice(idx, 1)
  }
}

onMounted(()=>{
  cart.value = JSON.parse(localStorage.getItem('cart') ?? '[]')

  for(const item of cart.value) {
    fetchProduct(item.productId);
  }
})

onUnmounted(()=>{
  localStorage.setItem('cart', JSON.stringify(cart.value))
})

async function submit() {
  loading.value = true
  const state = await $fetch('/api/admin/orders/makeOrder', {
    method: 'POST',
    body: {
      items: cart.value,
      date: withdrawalDate.value,
      pickupPlace: pickUpPlace.value,
    }
  })
  if(state.status == 'success') {
    cart.value = []

  }
}

</script>

<template>
  <div class="container mx-auto p-3">
    <h1 class="text-3xl text-center mb-3">Your shopping list</h1>
    <p v-if="cart.length == 0">Your shopping list is empty</p>
    <div v-else>
      <Card v-for="item in cart" :key="item.productId" class="m-2">
        <template #header>
          <h4 class="pl-3 pt-3 text-xl">{{ products[item.productId]?.name }}</h4>
        </template>
        <template #content >
          <p><strong>Details: </strong> {{item.details}} </p>
          <div class="flex justify-between items-center my-3">
            <p><strong>{{item.count}}</strong> pieces</p>
            <Button severity="danger" icon="pi pi-trash" @click="()=> deleteProduct(item.productId)" />
          </div>
        </template>
      </Card>
      <Divider />
      <div class="flex justify-between items-center">
        <label for="withdrawal">Withdrawal date: </label>
        <DatePicker showTime hourFormat="24" v-model="withdrawalDate" id="withdrawal" />
      </div>
      <div class="mt-5">
        <h2 class="text-xl mb-3">Choose withdrawal place</h2>
        <div class="py-1">
          <RadioButton inputId="firstPlace" v-model="pickUpPlace" name="pestovatelska" value="pestovatelska" />
          <label for="firstPlace" class="pl-3">Pestovateľská 13, 82104 Bratislava</label>
        </div>
        <div class="py-1">
          <RadioButton inputId="secondPlace" v-model="pickUpPlace" name="jurigovo" value="jurigovo" />
          <label for="secondPlace" class="pl-3">Jurigovo Námestie, 84104 Bratislava</label>
        </div>
      </div>
      <Button class="mt-5" label="Place order" fluid @click="submit" :loading="loading" />
    </div>
  </div>
</template>

<style scoped>

</style>