import gulp from 'gulp'
import { config } from './config.mjs'
import dartSass from 'sass'
import gulpSass from 'gulp-sass'
import sourcemaps from 'gulp-sourcemaps'
import sassGlob from 'gulp-sass-glob'
import autoprefixer from 'gulp-autoprefixer'

const { src, dest, watch } = gulp
const sass = gulpSass(dartSass)

const process = async (file) => {
    src(file)
        .pipe(sourcemaps.init())
        .pipe(sassGlob())
        .pipe(
            sass({
                includePaths: config.include,
                outputStyle: 'compressed',
            }).on('error', sass.logError)
        )
        .pipe(autoprefixer())
        .pipe(sourcemaps.write('.'))
        .pipe(dest(config.css.to))
}

const css = async () => {
    const from = config.css.from
    const arr = typeof from === 'string' ? [from] : from
    arr.forEach(process)
}

css.watch = () => watch(config.css.glob, css)

export { css }
