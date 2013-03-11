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

		uglify:
			all:
				files:
					'responsiveImages.min.js': ['responsiveImages.js']

				options:
					banner: "/*!\nresponsiveImages v<%= pkg.version %>\nAuthor: thomaswelton@me.com\n*/\n",
					beautify:
						ascii_only: true

	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-contrib-watch'
	grunt.loadNpmTasks 'grunt-contrib-uglify'

	grunt.registerTask 'default', ['coffee', 'uglify']
