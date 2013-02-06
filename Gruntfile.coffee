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
      single:
        files:
          'test/actual/main.html': 'test/source/main.template'
        options:
          data:
            message: 'Single'
            class: 'foo'
      concat:
        files:
          'test/actual/concat.html': ['test/source/concat1.template', 'test/source/concat2.template']
        options:
          data:
            message: 'Concat'
            class: 'foo'
      wrap:
        files:
          'test/actual/wrapped.html': 'test/source/main.template'
        options:
          data:
            message: 'Wrap'
            class: 'foo'
          wrap:
            banner: '<wrapped>\n'
            footer: '\n</wrapped>'
      advWrap:
        files:
          'test/actual/wrappedAdv.html': 'test/source/main.template'
        options:
          data:
            message: 'Wrap'
            class: 'foo'
          wrap:
            banner: '<wrapped id="#{0}">\n'
            footer: '\n</wrapped>'
            inject: [{
              prop: 'dest'
              rem:  'test/'
            }]


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
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-coffee'

  grunt.registerTask 'mocha', 'run mocha', () ->
    done = grunt.task.current.async()
    require('child_process').exec(
      'mocha --compilers coffee:coffee-script -R nyan'
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