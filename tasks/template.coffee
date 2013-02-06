'use strict'

module.exports = (grunt) ->
  path = require 'path'

  grunt.registerMultiTask 'template', 'Process grunt template files', () ->
    done = grunt.task.current.async()
    helpers = require('grunt-lib-contrib').init grunt

    options = helpers.options @, () ->
      data: {},
      delimiters: []

    grunt.verbose.writeflags @.options, 'options'

    grunt.util.async.forEachSeries(@.files, (f, nextFileObj) ->
      destinationFile = f.dest

      files = f.src.filter((filepath) ->
        if grunt.file.exists filepath
          return true
        else
          grunt.log.warn "Can't find source file #{filepath}."
          return false
      )

      nextFileObj() if files.length is 0

      processed = []
      grunt.util.async.concatSeries(files, (file, next) ->
        processTemplate(file, options, (success, out, err) ->
          if success
            processed.push out
            next null
          else
            nextFileObj false
        )
      , () ->
        if not processed.length > 1
          grunt.log.warn 'Nothing to do.'
        else
          grunt.file.write(
            destinationFile,
            processed.join(grunt.util.normalizelf, grunt.util.linefeed)
          )

          grunt.log.writeln 'File ' + destinationFile.cyan + ' created.'
      )
      nextFileObj()
    , done)

  processTemplate = (file, options, callback) ->
    processed = ''
    try
      src = grunt.file.read file, {encoding: grunt.file.defaultEncoding }
      processed = grunt.template.process src, options
    catch e
      callback false, null, e
    callback true, processed, null