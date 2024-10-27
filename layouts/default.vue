<script setup lang="ts">

const router = useRouter()
const auth = useAuth()

const items = ref([
  { label: 'Home', icon: 'pi pi-fw pi-home', to: '/' },
  { label: 'Preferences', icon: 'pi pi-fw pi-info', to: '/preferences' },
  { label: 'Products', icon: 'pi pi-fw pi-envelope', to: '/products' },
])

onMounted(() => {
  update()
})

function update() {
  items.value = items.value.map(item=> {
    return {
      ...item,
      command: () => router.push(item.to)
    }
  })

}

$fetch('/api/token').then(res=> {
  if (res?.admin) {
    items.value.push({ label: 'Admin', icon: 'pi pi-fw pi-cog', to: '/admin'})
    update()
  }
})

const search = ref('')

</script>

<template>
  <div class="p-0">
<!--     style="background: #fcb731" -->
    <Menubar :model="items">
      <template #start>
        <img class="h-8 rounded-md" src="/logo.png"/>
      </template>
      <template #end>
        <div class="flex items-center">
<!--            <IconField>-->
<!--                <InputIcon class="pi pi-search" />-->
<!--                <InputText v-model="search" placeholder="Search" />-->
<!--            </IconField>-->
            <i class="pi pi-shopping-cart p-2 text-xl" @click="router.push('/cart')"></i>
        </div>
      </template>
    </Menubar>
    <div class="container mx-auto pt-5">
      <slot />
    </div>
  </div>
</template>

<style scoped></style>
