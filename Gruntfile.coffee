module.exports = (grunt) =>
	grunt.initConfig
		pkg: grunt.file.readJSON 'package.json'

		bower:
			install:
				options:
					targetDir: 'scripts/components'

	grunt.loadNpmTasks 'grunt-contrib-watch'
	grunt.loadNpmTasks 'grunt-bower-task'

	grunt.registerTask 'default', []
