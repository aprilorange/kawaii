gulp = require 'gulp'
swig = require 'gulp-swig'
stylus = require 'gulp-stylus'
nib = require 'nib'
cssmin = require 'gulp-cssmin'
rename = require 'gulp-rename'
browserSync = require('browser-sync').create()

paths = 
	stylus: './src/styl/kawaii.styl'
	stylusAll: './src/styl/*.styl'
	css: './dist/css'
	html: './'
	swig: './src/swig/index.html'
	swigAll: './src/swig/*.html'

gulp.task 'browser-sync', ->
	browserSync.init
		server: 
			baseDir: "./"

	gulp.watch paths.stylusAll, ['stylus']
	gulp.watch './dist/css/kawaii.min.css'
		.on 'change', browserSync.reload

	gulp.watch paths.swigAll, ['swig']
	gulp.watch './index.html'
		.on 'change', browserSync.reload

gulp.task 'stylus', ->
	gulp.src paths.stylus
		.pipe stylus 
			use: nib()
			import: ['nib']
		.pipe gulp.dest paths.css
		.pipe cssmin()
		.pipe rename
			suffix: '.min'
		.pipe gulp.dest paths.css
		.pipe browserSync.stream()

gulp.task 'swig', ->
	gulp.src paths.swig
		.pipe swig
      cache: false
			defaults:
				locals:
					time: new Date().getTime()
		.pipe gulp.dest paths.html
		.pipe browserSync.stream()


gulp.task 'build', ['stylus', 'swig']

gulp.task 'default', ['build', 'browser-sync']