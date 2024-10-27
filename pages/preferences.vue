<script setup lang="ts">

import {$fetch} from "ofetch";

interface Category {
  name: string;
  products: Product[];
}

interface Product {
  id: number;
  name: string;
  watching: boolean;
  interested: boolean;
}

const data = ref<Category[]>([])
const interested = ref<Record<number, boolean>> ({})
const watchlist = ref<Record<number, boolean>>({})

onMounted(async() => {
  data.value = await $fetch('/api/product/preferences') as Category[]
  for(const c of data.value){
    for(const p of c.products){
      interested.value[p.id] = p.interested
      watchlist.value[p.id] = p.watching
    }
  }
  console.log(data.value)
})

function toggle(product: Product) {
  console.log(interested.value[product.id])
  interested.value[product.id] = !interested.value[product.id]
}

function toggleWatchlist(product: Product) {
  watchlist.value[product.id] = !watchlist.value[product.id]
  if(watchlist.value[product.id]){
    interested.value[product.id] = true
  }
}

function toggleCategory(e: Event, category: Category) {
  e.stopPropagation()
  console.log("toggle category", e)
}

async function submit () {
  const body = {
    interestedProductIds: Object.keys(interested.value).map(e=>parseInt(e)).filter(e=>
        interested.value[e]),
    watchedProductsIds: Object.keys(watchlist.value).map(e=>parseInt(e)).filter(e=>
    watchlist.value[e])
  }
  await $fetch('/api/product/changeProductPreferences', {
    method: 'POST',
    body: body
  })
}

</script>

<template>
  <div>
    <h1 class="text-4xl mb-3 text-center">Preferred products</h1>
    <p>Select all products you are potentially interested in.</p>
    <p>Ring the bell <i class="pi" :class="{
              'pi-bell':true}"></i> on products you want to receive email notifications.</p>
    <Divider />
    <Accordion>
      <AccordionPanel v-for="category in data" :value="category.name" :key="category.name">
        <AccordionHeader>
          <div class="flex justify-between w-full pr-3">
            {{ category.name }}
            <Checkbox @input.prevent="toggleCategory" />
          </div>
          </AccordionHeader>
        <AccordionContent>
          <Chip class="cursor-pointer m-2 select-none" :class="{
            'bg-green-500': interested[product.id] == true,
            'bg-gray-500': interested[product.id] == false
          }" v-for="product in category.products" :key="product.id">
            <p @click="() => toggle(product)">{{product.name}}</p>
            <i class="pi" :class="{
              'pi-bell': watchlist[product.id] == true,
              'pi-bell-slash': watchlist[product.id] == false
            }" @click.prevent="() => toggleWatchlist(product)"></i>
          </Chip>
        </AccordionContent>
      </AccordionPanel>
    </Accordion>
    <Button label="Update" class="mt-4" fluid @click="submit"/>
  </div>
</template>

<style scoped>

</style>