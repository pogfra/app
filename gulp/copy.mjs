import gulp from 'gulp'
import { config } from './config.mjs'

const { src, dest, watch } = gulp

const copy = async () => {
    src(config.copy.glob).pipe(dest(config.copy.to))
}

copy.watch = () => watch(config.copy.glob, copy)

export { copy }
