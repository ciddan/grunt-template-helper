chai = require 'chai'
grunt = require 'grunt'
fs = require 'fs'

assert = chai.assert

describe 'Task template', ->
  it 'should replace variables with data', ->
    source = grunt.file.read './test/source/main.template'
    actual = grunt.file.read './test/actual/main.html'

    assert.isTrue(source.indexOf('<%= message %>')  > 0)
    assert.isTrue(actual.indexOf('<%= message %>') is -1)

  it 'should create destination file', ->
    assert.isTrue(grunt.file.exists('./test/actual/main.html'), 'file created')

  it 'should correctly format the file', ->
    expected = grunt.file.read './test/expected/main.html'
    actual = grunt.file.read './test/actual/main.html'

    assert.strictEqual actual, expected