module.exports = (grunt) =>
	grunt.initConfig
		pkg: grunt.file.readJSON 'package.json'

		## Compile coffeescript
		coffee:
			compile:
				files: [
					expand: true
					cwd: 'src'
					src: ['responsiveImages.coffee']
					dest: 'dist'
					ext: '.js'
				]

		removelogging:
			files:
				expand: true
				cwd: 'dist'
				src: ['responsiveImages.min.js']
				dest: 'dist'
				ext: '.js'

		uglify:
			javascript:
				mangle: false
				compress: false
				banner: """/*!
						<%= pkg.name %> v<%= pkg.version %> 
						<%= pkg.description %>
						Build time: #{(new Date()).getTime()}
						*/\n\n"""
				files: {
					'dist/responsiveImages.min.js': ['dist/responsiveImages.js']
				}

		git:
			javascript:
				options: {
	                command: 'commit'
	                message: 'Grunt build'
	            }

	            files: {
	            	src: ['dist/responsiveImages.js','dist/responsiveImages.min.js']
	            }

		
	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-remove-logging'
	grunt.loadNpmTasks 'grunt-git'
	grunt.loadNpmTasks 'grunt-contrib-uglify'
	
	grunt.registerTask 'default', ['coffee', 'uglify']
	grunt.registerTask 'commit', ['default', 'git']
