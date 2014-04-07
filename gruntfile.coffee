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
	grunt.loadNpmTasks "grunt-replace"

	###
	## Grunt Configuration ##
	###
	grunt.initConfig
		path:
			src  : "src"
			dist : "dist"

		banner:
			full : """
					/**
					 * ui-iconpicker
					 *
					 * @version   v<%= pkg.version %>
					 * @author    Justin Lau <justin@tclau.com>
					 * @copyright Copyright (c) 2014 Justin Lau <justin@tclau.com>
					 * @license   The MIT License (MIT)
					 * 
					 * Permission is hereby granted, free of charge, to any person obtaining a copy
					 * of this software and associated documentation files (the 'Software'), to deal
					 * in the Software without restriction, including without limitation the rights
					 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
					 * copies of the Software, and to permit persons to whom the Software is
					 * furnished to do so, subject to the following conditions:
					 * 
					 * The above copyright notice and this permission notice shall be included in all
					 * copies or substantial portions of the Software.
					 * 
					 * THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
					 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
					 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
					 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
					 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
					 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
					 * SOFTWARE.
					 */"""
			min  : """
					/*
					 ui-iconpicker v<%= pkg.version %>
					 (c) 2014 Justin Lau http://justin-lau.github.io/ui-iconpicker/
					 License: MIT
					*/"""
		pkg: grunt.file.readJSON "package.json"

		###
		**Bump**
		###
		bump:
			options:
				filepaths    : [
					'bower.json'
					'package.json'
				]
				syncVersions : true
				commit       : false
				tag          : false

		###
		**Clean**
		###
		clean: [
			"<%= path.src %>/scripts/**/*.js"
			"<%= path.src %>/scripts/**/*.js.map"
			"<%= path.dist %>"
		]

		###
		**CoffeeScript**
		###
		coffee:
			debug:
				cwd     : "<%= path.src %>"
				dest    : "<%= path.src %>"
				expand  : true
				ext     : ".js"
				options :
					sourceMap : true
				src     : ["**/*.coffee"]

			dist:
				cwd    : "<%= path.src %>"
				dest   : "<%= path.src %>"
				expand : true
				ext    : ".js"
				src    : ["**/*.coffee"]

		###
		**Compass**
		###
		compass:
			options:
				cssDir  : "<%= path.dist %>/styles"
				sassDir : "<%= path.src %>/styles"
				specify : "<%= path.src %>/styles/ui-iconpicker.scss"
			debug:
				options:
					environment : "development"
					outputStyle : "expanded"
			dist:
				options:
					environment    : "production"
					noLineComments : true
					outputStyle    : "expanded"
		###
		**CssMin**
		###
		cssmin:
			dist:
				options:
					banner: "<%= banner.min %>"
				expand: true,
				cwd: "<%= path.dist %>",
				src: [
					'**/*.css'
					'**/!*.min.css'
				],
				dest: "<%= path.dist %>",
				ext: '.min.css'

		###
		**Replace**
		###
		replace:
			css_banner:
				options :
					patterns: [{
						match       : /^(\/\*\*[\S\s]*^ \*\/)?$/m
						replacement : "<%= banner.full %>"
					}]
				files   : [{
					expand : true
					cwd    : "<%= path.dist %>/styles"
					src    : [
						"**/*.css"
						"!**/*.min.css"
					]
					dest   : "<%= path.dist %>/styles"
				}]
			js_banner:
				options :
					patterns: [{
						match       : /^([\S\s]*?)$/
						replacement : "<%= banner.full %>\n$1"
					}]
				files   : [{
					expand : true
					cwd    : "<%= path.dist %>/scripts"
					src    : [
						"**/*.js"
						"!**/*.min.js"
					]
					dest   : "<%= path.dist %>/scripts"
				}]
			js_banner_min:
				options :
					patterns: [{
						match       : /^([\S\s]*?)$/
						replacement : "<%= banner.min %>\n$1"
					}]
				files   : [{
					expand : true
					cwd    : "<%= path.dist %>/scripts"
					src    : ["**/*.min.js"]
					dest   : "<%= path.dist %>/scripts"
				}]

		###
		**RequireJS**
		###
		requirejs:
			options:
				baseUrl        : "<%= path.src %>/scripts"
				mainConfigFile : "<%= path.src %>/scripts/config.js"
				name           : "ui-iconpicker"
			debug:
				options:
					generateSourceMaps : true
					optimize           : "none"
					out                : "<%= path.dist %>/scripts/ui-iconpicker.js"
			dist:
				options:
					optimize : "none"
					out      : "<%= path.dist %>/scripts/ui-iconpicker.js"
			dist_min:
				options:
					optimize : "uglify2"
					out      : "<%= path.dist %>/scripts/ui-iconpicker.min.js"

		###
		**Watch**
		###
		watch:
			options : 
				livereload : true
				spawn      : false

			# compiles changed coffeescripts
			coffeescripts:
				files : ["<%= path.src %>/scripts/**/*.coffee"]
				tasks : [
					"coffee:debug"
					"requirejs:debug"
				]

			# compiles changed sass files
			sass:
				files : ["<%= path.src %>/styles/**/*.scss"]
				tasks : [
					"compass:debug"
				]


	###
	## Tasks ##
	###

	grunt.registerTask "replace:dist", [
		"replace:css_banner"
		"replace:js_banner"
		"replace:js_banner_min"
	]

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
		"replace:dist"
	]

	###
	**dev**
	###
	grunt.registerTask "dev", [
		"debug"
		"watch"
	]