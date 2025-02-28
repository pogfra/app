import gulp from 'gulp'
import { copy } from './gulp/copy.mjs'
import { css } from './gulp/css.mjs'
import { js } from './gulp/js.mjs'
import { svgstore } from './gulp/svgstore.mjs'

const { series, parallel } = gulp

const watchers = async () => {
    copy.watch()
    css.watch()
    js.watch()
    svgstore.watch()
}

const build = series(svgstore, parallel(copy, css, js))
const doWatch = series(build, watchers)

export { copy, css, js, svgstore, build, doWatch as watch, doWatch as default }
