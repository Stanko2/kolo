<script setup lang="ts">

const router = useRouter()

const items = ref([
  { label: 'Home', icon: 'pi pi-fw pi-home', to: '/' },
  { label: 'About', icon: 'pi pi-fw pi-info', to: '/about' },
  { label: 'Contact', icon: 'pi pi-fw pi-envelope', to: '/contact' }, 
    { label: 'Admin', icon: 'pi pi-fw pi-cog', to: '/admin' }
])

onMounted(() => {
  items.value = items.value.map(item=> {
    return {
      ...item,
      command: () => router.push(item.to)
    }
  })
})


</script>

<template>
  <div>
    <Menubar>
      <template #start>
        <p class="text-2xl">KOLO | Administrácia</p>
      </template>
      <template #end class="flex">
        <div class="flex items-center">
            <IconField>
              <Button link label="Logout" />
            </IconField>
        </div>
      </template>
    </Menubar>
    <div class="flex">
      <div class="w-52">
        <Menu class="h-screen" :model="items" />
      </div>
      <div class="p-4">
        <slot />
      </div>
    </div>
  </div>
</template>

<style scoped></style>
