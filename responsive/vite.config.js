import { defineConfig } from 'vite';
import { fileURLToPath } from 'node:url';
import tailwindcss from '@tailwindcss/vite';

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [tailwindcss()],
  server: {
    host: true,
    port: 8080,
    strictPort: true,
    allowedHosts: [
      'responsive.vm1.test',
      'responsive.vm2.test',
      'responsive.vm3.test',
      'responsive.vm4.test',
      'responsive.vm5.test',
      'responsive.vm6.test',
    ],
    hmr: {
      host: 'responsive.vm1.test',
      clientPort: 80,
    },
    watch: {
      usePolling: true,
    },
  },
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url)),
    },
  },
});
