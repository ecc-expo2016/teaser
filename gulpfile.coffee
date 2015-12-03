gulp = require 'gulp'
browserify = require 'browserify'
watchify = require 'watchify'
source = require 'vinyl-source-stream'
buffer = require 'vinyl-buffer'
runSequence = require 'run-sequence'
browserSync = require 'browser-sync'
{ stream } = browserSync
$ = require('gulp-load-plugins')()

isDev = false

gulp.task 'scripts', ->
  b = browserify Object.assign {}, watchify.args,
    entries: 'src/scripts/index.js'
    debug: isDev

  bundle = ->
    b
      .transform 'babelify'
      .transform 'uglifyify', global: true
      .bundle()
      .on 'error', $.util.log.bind $.util, 'Browserify Error'
      .pipe source 'bundle.js'
      .pipe buffer()
      .pipe $.if isDev, $.sourcemaps.init loadMaps: true
      .pipe $.if isDev, $.sourcemaps.write './'
      .pipe gulp.dest 'dist/assets'
      .pipe $.if isDev, stream()

  if isDev
    w = watchify b
    w.on 'update', bundle
    w.on 'log', $.util.log

  bundle()

gulp.task 'styles', ->
  gulp.src 'src/styles/style.scss'
    .pipe $.if isDev, $.sourcemaps.init()
    .pipe $.sass().on 'error', $.sass.logError
    .pipe $.autoprefixer()
    .pipe $.minifyCss()
    .pipe $.if isDev, $.sourcemaps.write './'
    .pipe gulp.dest 'dist/assets'
    .pipe $.if isDev, stream()

gulp.task 'images', ->
  gulp.src 'src/images/**/*.{gif,jpg,png,svg}'
    .pipe $.imagemin
      progressive: true
      interlaced: true
    .pipe gulp.dest 'dist/assets/img'
    .pipe $.if isDev, stream()

gulp.task 'html', ->
  gulp.src 'src/**/*.html'
    .pipe gulp.dest 'dist'
    .pipe $.if isDev, stream()

gulp.task 'copy', ->
  gulp.src ['src/favicon.ico', 'src/apple-touch-icon.png', 'src/CNAME']
    .pipe gulp.dest 'dist'

gulp.task 'serve', ->
  browserSync.init
    server:
      baseDir: 'dist'

  gulp.watch 'src/styles/**/*.{scss,css}', ['styles']
  gulp.watch 'src/images/**/*.{gif,jpg,png,svg}', ['images']
  gulp.watch 'src/**/*.html', ['html']

gulp.task 'deploy', ->
  gulp.src ['dist/**/*', '!dist/**/*.map']
    .pipe $.ghPages()

gulp.task 'default', ['styles', 'images', 'html', 'copy']

gulp.task 'enable-dev-mode', -> isDev = true
gulp.task 'dev', ->
  runSequence 'enable-dev-mode', ['default', 'scripts', 'serve']

gulp.task 'build', ['default', 'scripts']
