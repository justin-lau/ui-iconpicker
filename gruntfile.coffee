# @author    Justin Lau <justin@tclau.com>
# @copyright Copyright (c) 2014 Justin Lau <justin@tclau.com>
# @license   The MIT License (MIT)
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#

SRC_DIR  = "src"
DIST_DIR = "dist"

module.exports = (grunt) ->

	###
	## Loading Grunt Plugins ##
	###
	grunt.loadNpmTasks "grunt-contrib-bump"
	grunt.loadNpmTasks "grunt-contrib-clean"
	grunt.loadNpmTasks "grunt-contrib-coffee"
	grunt.loadNpmTasks "grunt-contrib-compass"
	grunt.loadNpmTasks "grunt-contrib-cssmin"
	grunt.loadNpmTasks "grunt-contrib-requirejs"
	grunt.loadNpmTasks "grunt-contrib-watch"

	###
	## Grunt Configuration ##
	###
	grunt.initConfig
		pkg: grunt.file.readJSON "package.json"

		###
		**Bump**
		###
		bump:
			options:
				filepaths    : [
					'bower.json'
					'composer.json'
					'package.json'
				]
				syncVersions : true
				commit       : true
				tag          : true

		###
		**Clean**
		###
		clean: [
			"#{SRC_DIR}/scripts/**/*.js"
			"#{SRC_DIR}/scripts/**/*.js.map"
			"#{DIST_DIR}"
		]

		###
		**CoffeeScript**
		###
		coffee:
			debug:
				cwd     : SRC_DIR
				dest    : SRC_DIR
				expand  : true
				ext     : ".js"
				options :
					sourceMap : true
				src     : ["**/*.coffee"]

			dist:
				cwd    : SRC_DIR
				dest   : SRC_DIR
				expand : true
				ext    : ".js"
				src    : ["**/*.coffee"]

		###
		**Compass**
		###
		compass:
			options: 
				cssDir  : "#{DIST_DIR}/styles"
				sassDir : "#{SRC_DIR}/styles"
			debug:
				options:
					environment : "development"
					outputStyle : "expanded"
			dist:
				options:
					environment : "production"
					outputStyle : "expanded"

		###
		**CssMin**
		###
		cssmin:
			dist:
				expand: true,
				cwd: DIST_DIR,
				src: [
					'**/*.css'
					'**/!*.min.css'
				],
				dest: DIST_DIR,
				ext: '.min.css'

		###
		**RequireJS**
		###
		requirejs:
			options:
				baseUrl        : "#{SRC_DIR}/scripts"
				mainConfigFile : "#{SRC_DIR}/scripts/config.js"
				name           : "ui-iconpicker"
			debug:
				options:
					generateSourceMaps : true
					optimize           : "none"
					out                : "#{DIST_DIR}/scripts/ui-iconpicker.js"
			dist:
				options:
					optimize : "none"
					out      : "#{DIST_DIR}/scripts/ui-iconpicker.js"
			dist_min:
				options:
					optimize : "uglify2"
					out      : "#{DIST_DIR}/scripts/ui-iconpicker.min.js"

		###
		**Watch**
		###
		watch:
			options : 
				livereload : true
				spawn      : false

			# compiles changed coffeescripts
			coffeescripts:
				files : ["#{SRC_DIR}/scripts/**/*.coffee"]
				tasks : [
					"coffee:debug"
					"requirejs:debug"
				]

			# compiles changed sass files
			sass:
				files : ["#{SRC_DIR}/styles/**/*.scss"]
				tasks : [
					"compass:debug"
				]


	###
	## Tasks ##
	###

	###
	**debug**
	###
	grunt.registerTask "debug", [
		"clean"
		"compass:debug"
		"coffee:debug"
		"requirejs:debug"
	]

	###
	**dist**
	###
	grunt.registerTask "dist", [
		"clean"
		"compass:dist"
		"cssmin:dist"
		"coffee:dist"
		"requirejs:dist"
		"requirejs:dist_min"
	]

	###
	**dev**
	###
	grunt.registerTask "dev", [
		"debug"
		"watch"
	]