<script setup lang="ts">

const router = useRouter()

const items = ref([
  { label: 'Home', icon: 'pi pi-fw pi-home', to: '/admin' },
  { label: 'Orders', icon: 'pi pi-fw pi-info', to: '/admin/about' },
  { label: 'Map', icon: 'pi pi-fw pi-envelope', to: '/admin/map' },
  { label: 'Warehouse', icon: 'pi pi-fw pi-cog', to: '/admin' },
  { label: 'Organizations', icon: 'pi pi-fw pi-envelope', to: '/admin/organizations' },
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
