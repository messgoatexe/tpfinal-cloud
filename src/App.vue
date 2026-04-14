<script setup>
const buildId = import.meta.env.VITE_BUILD_ID ?? 'local'
const today = new Date().toLocaleDateString('fr-FR')
</script>
<template>
<header>
<p>Nom : Noe Gomes branche develops</p>
<p>Date : {{ today }}</p>
<p>Build : {{ buildId }}</p>
</header>
</template>
