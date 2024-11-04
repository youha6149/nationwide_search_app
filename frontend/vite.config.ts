import { defineConfig } from 'vitest/config';
import vue from '@vitejs/plugin-vue';
import path from 'path';

export default defineConfig({
    plugins: [vue()],
    resolve: {
        alias: {
            '@': path.resolve(__dirname, './src'),
        },
    },
    test: {
        globals: true,
        environment: 'jsdom',
        include: ['tests/unit/**/*.spec.{js,ts}'],
        exclude: ['node_modules', 'dist'],
        root: '.',
        testTransformMode: {
            web: ['**/*.jsx', '**/*.tsx'],
        },
        deps: {
            inline: ['@vue', '@vueuse', 'vue-demi']
        }
    }
});
