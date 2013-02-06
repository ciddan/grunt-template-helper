'use strict'

module.exports = (grunt) ->
  grunt.registerMultiTask 'template', 'Process grunt template files', () ->
    helpers = require('grunt-lib-contrib').init grunt

    options = helpers.options @, () ->
      data: {}
      wrap: {}

    grunt.verbose.writeflags @.options, 'options'

    @.files.forEach((f) ->
      grunt.log.writeln "src: #{f.src}, dest: #{f.dest}"
      
      out = f.src.filter((filepath) ->
        grunt.file.exists filepath
      ).map((filepath) ->
        compileTemplate filepath, options, f.dest
      ).join grunt.util.normalizelf grunt.util.linefeed

      if out.length < 1
        grunt.log.warn 'Nothing written because compiled files were empty.'
      else
        grunt.file.write f.dest, out
        grunt.log.writeln "File #{f.dest.cyan} created."
    )

  compileTemplate = (filepath, options, dest) ->
    src = grunt.file.read filepath

    try
      wrap = options.wrap?.banner? and options.wrap?.footer?
      processed = grunt.template.process src, options
      processed = "#{options.wrap.banner}#{processed}#{options.wrap.footer}" if wrap

      if wrap and options.wrap.inject? and options.wrap.inject.length >= 1
        for inj, pos in options.wrap.inject
          inj.rem ?= ''

          switch inj.prop
            when 'src'
              inject = filepath.replace inj.rem, ''
              processed = processed.replace('#{' + pos + '}', inject)
            when 'dest'
              inject = dest.replace inj.rem, ''
              processed = processed.replace('#{' + pos + '}', inject)



      return processed
    catch e
      grunt.log.error e
      grunt.fail.warn 'Template copilation failed.'