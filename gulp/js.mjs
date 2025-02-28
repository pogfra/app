import gulp from 'gulp'
import { config } from './config.mjs'
import { createGulpEsbuild } from 'gulp-esbuild'

const { src, dest, watch } = gulp
const gulpEsbuild = createGulpEsbuild({ pipe: true })

const js = async () => {
    src(config.js.from)
        .pipe(
            gulpEsbuild({
                bundle: true,
                sourcemap: true,
                minify: true,
                treeShaking: true,
                format: 'esm', // 'iife'|'cjs'|'esm'
            })
        )
        .pipe(dest(config.js.to))
}

js.watch = () => watch(config.js.glob, js)

export { js }
