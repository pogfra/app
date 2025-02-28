import gulp from 'gulp'
import { config } from './config.mjs'
import svgmin from 'gulp-svgmin'
import store from 'gulp-svgstore'

const { src, dest, watch } = gulp

const svgstore = async () => {
    src(config.svgstore.glob)
        .pipe(svgmin())
        .pipe(store({ inlineSvg: true }))
        .pipe(dest(config.svgstore.to))
}

svgstore.watch = () => watch(config.svgstore.glob, svgstore)

export { svgstore }
