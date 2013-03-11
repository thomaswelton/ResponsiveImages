module.exports = (grunt) =>
	grunt.initConfig
		pkg: grunt.file.readJSON 'package.json'
		
		coffee:
			compile:
				files:
	      			'responsiveImages.js': 'responsiveImages.coffee'

		watch:
			coffee:
				files:
					'responsiveImages.coffee'

				tasks: 'coffee'

	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-contrib-watch'

	grunt.registerTask 'default', ['coffee']
