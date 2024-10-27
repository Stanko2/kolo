<script setup lang="ts">

import {$fetch} from "ofetch";
import type {Product} from "@prisma/client";

const categories = ref()
const search = ref("")

onMounted(async () => {
  fetch()
})

async function fetch() {
  if (search.value == "") {
    categories.value = await $fetch('/api/product/all')
  } else {
    categories.value = await $fetch(`/api/product/all?search=${search.value}`)
  }
}

function AddToCart(product: Product) {
  const currCart = JSON.parse(localStorage.getItem('cart') ?? '[]')
  currCart.push({
    productId: product.id,
    count: currentCount.value,
    details: details.value
  })
  localStorage.setItem('cart', JSON.stringify(currCart))
  hide()
}

const currentProduct = ref<Product | null>(null)
const currentCount = ref<number>(1)
const details = ref("")


function hide() {
  currentCount.value = 0
  currentProduct.value = null
  details.value = ''
}

</script>

<template>

  <div>
    <div class="flex items-center justify-between">
      <h1 class="text-6xl mb-4">Products</h1>
      <IconField>
        <InputText v-model="search" placeholder="Search"/>
        <InputIcon class="pi pi-search" @click="()=>fetch()"/>
      </IconField>
    </div>
    <Accordion value="0">
      <AccordionPanel v-for="(category, i) in categories" :key="category.name" :value="i">
        <AccordionHeader>
          <div class="flex justify-start items-center w-full pr-3">
            <img
                :alt="category.name"
                class="w-32"
                :src="'/categories/' + category.name.toLowerCase().split(',')[0].replace(' ', '-') + '.svg'"
            />
            <p class="text-left pl-16 text-3xl">{{ category.name }}</p>

          </div>
        </AccordionHeader>
        <AccordionContent>
          <Card v-for="product in category.products" :key="product.id">
            <template #title>{{ product.name }}</template>
            <template #content>
              <p>{{ product.description }}</p>
              <div class="flex justify-between items-center my-3">
                <p>{{ product.count }} pcs.</p>
                <Button @click="() => currentProduct = product" label="Add to cart"/>
              </div>
              <Divider/>
            </template>
          </Card>
        </AccordionContent>
      </AccordionPanel>
    </Accordion>
    <Dialog :visible="currentProduct != null" modal>
      <template #header>
        <h3>Add {{ currentProduct?.name }} to your order list</h3>
      </template>
      <div class="flex flex-col">
        <label for="count">Count: </label>
        <InputText :invalid="currentCount > currentProduct!.count" id="count" v-model.number="currentCount"/>
        <label for="details">Details: </label>
        <Textarea v-model="details" id="details"/>
      </div>

      <template #footer>
        <Button label="Cancel" severity="secondary" @click="hide"/>
        <Button label="Add" severity="success" @click="() => AddToCart(currentProduct!)"
                :disabled="currentCount > currentProduct!.count"/>
      </template>
    </Dialog>
  </div>
</template>

<style scoped>

</style>