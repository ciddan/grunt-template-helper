'use strict'

module.exports = (grunt) ->
  # Project configuration.
  grunt.initConfig
    clean:
      test:
        src: ['./test/actual/']
      task:
        src: ['./tasks/template.js']

    template:
      files:
        expand: true
        cwd:  './test/source'
        src:  '*.template'
        ext:  '.html'
        dest: './test/actual'
      options:
        data:
          message: 'Hello'
          class: 'foo'

    coffeelintOptions:
      no_trailing_whitespace:
        level: 'error'
      no_tabs:
        level: 'error'
      indentation:
        value: 2
        level: 'error'
      line_endings:
        value: 'unix'
        level: 'error'
      max_line_length:
        value: 80
        level: 'warn'

    coffeelint:
      grunt: 'Gruntfile.coffee'
      tasks: './tasks/*.coffee'
      tests: './test/*.coffee'

  # Load local tasks.
  grunt.loadTasks 'tasks'

  # Load plugin tasks
  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-simple-mocha'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'

  grunt.registerTask 'mocha', 'run mocha', () ->
    done = grunt.task.current.async()
    require('child_process').exec(
      'mocha --compilers coffee:coffee-script -R list'
      , (err, stdout) ->
        grunt.log.write stdout
        done err
    )

  # Default task.
  grunt.registerTask 'default', [
    'coffeelint'
    'template'
    'mocha'
    'clean'
  ]