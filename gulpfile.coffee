gulp = require 'gulp'
clean = require 'gulp-clean'
plumber = require 'gulp-plumber'
gutil = require 'gulp-util'
coffee = require 'gulp-coffee'
concat = require 'gulp-concat'
rename = require 'gulp-rename'
jade = require 'gulp-jade'
ngHtml2Js = require "gulp-ng-html2js"
minifyHtml = require "gulp-minify-html"
stylus = require 'gulp-stylus'
runSequence = require 'gulp-run-sequence'
livereload = require 'gulp-livereload'

exec = require('child_process').exec;
fs = require 'fs'
streamqueue = require 'streamqueue'
nodeStatic = require 'node-static'
nib = require 'nib'
args = require('yargs').argv

jadeLocals = 
  devMode : true
  jsLibs : [
    "lodash/dist/lodash.js"
    "angular/angular.js"
    "angular-animate/angular-animate.js"
    "angular-touch/angular-touch.js"
    "angular-bootstrap/ui-bootstrap-tpls.js"
    "angular-ui-router/release/angular-ui-router.js"
  ]

devPath = './.dist/dev'
buildPath = './.dist/build'

coffeeSrc = [
  './app/**/*.coffee' 
  './config/dev/*.coffee' 
]

if args.release
  coffeeSrc[1] = './config/release/*.coffee' 

gutil.log "Configuration file: '", gutil.colors.red("#{if args.release then 'release' else 'dev'} file"), "'"

gulp.task 'clean-dev', () -> 
  gulp.src devPath, {read: false}
  .pipe clean()

gulp.task 'coffee-dev', () ->
  gulp.src coffeeSrc
  .pipe plumber()
  .pipe coffee 
    bare: true
  .pipe gulp.dest devPath
  .pipe gutil.buffer (err, files) ->
    jadeLocals.jsfiles = for file in files
      file.path.substr file.base.length + 1

gulp.task 'stylus-dev', () ->
  gulp.src './app/style/index.styl' 
  .pipe stylus 
    use: [nib()]
    set: ['include css']
  .on 'error', (err) ->
    gutil.log err.stack
  .pipe gulp.dest devPath
  return

gulp.task 'jade-dev', () ->
  gulp.src './app/**/*.jade'
  .pipe plumber()
  .pipe jade 
    pretty : true
    locals : jadeLocals
  .pipe rename 
    ## make all template in one path
    dirname: ''
  .pipe gulp.dest devPath

gulp.task 'livereload', (cb) ->
  livereloadServer = livereload()
  gulp.watch "#{devPath}/**/*" , (evt) ->
    livereloadServer.changed evt.path

gulp.task 'dev', (cb) ->
  runSequence 'clean-dev', ['coffee-dev', 'stylus-dev'], 'jade-dev', 'livereload', cb


gulp.task 'clean-build', () ->
  gulp.src buildPath, {read: false}
  .pipe clean()

#jsLibs and script and template
#jsLibs + template + script