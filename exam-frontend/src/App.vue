<template>
    <div class="app-container" v-if="$route.path !== '/login'">
        <Footer />
        <div class="main-content">
            <router-view />
        </div>
    </div>
    <router-view v-else />
</template>

<script setup>
import Footer from '@/components/Footer.vue'
</script>

<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
    background-color: #f0f2f5;
}

.main-content {
    margin-left: 12vw;
    min-height: 100vh;
}
</style>