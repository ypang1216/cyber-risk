// @ts-check
import { defineConfig } from 'astro/config';
import svelte from '@astrojs/svelte';
import tailwind from '@astrojs/tailwind';

// https://astro.build/config
export default defineConfig({
  // Set the base path for GitHub Pages deployment
  // This should match your repository name
  base: '/cyber-risk',
  integrations: [
    svelte(),
    tailwind()
  ]
});