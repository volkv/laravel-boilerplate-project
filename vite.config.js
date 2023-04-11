import { defineConfig } from 'vite';
import laravel from 'laravel-vite-plugin';

export default defineConfig({
    plugins: [
        laravel({
            input: [
                'resources/less/app.less',
                'resources/js/app.js',
            ],
            refresh: true,
        }),
    ],
});
