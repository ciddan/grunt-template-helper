var chai = require('chai'),
    grunt = require('grunt'),
    fs = require('fs'),
    assert = chai.assert;

describe('Task template', function() {
    it('should create destination file', function() {
        assert.isTrue(grunt.file.exists('./test/actual/main.html'));
    });

    it('should replace variables with data', function() {
        var source = grunt.file.read('./test/source/main.template');
        var actual = grunt.file.read('./test/actual/main.html');

        assert.isTrue(source.indexOf('<%= message %>') > 0);
        assert.isTrue(actual.indexOf('<%= message %>') === -1);
    });

    it('should correctly format the file', function() {
        var expected = grunt.file.read('./test/expected/main.html');
        var actual = grunt.file.read('./test/actual/main.html');

        assert.strictEqual(actual, expected);
    });

    it('should manage to concatenate files', function() {
        assert.isTrue(grunt.file.exists('./test/actual/concat.html'));

        var expected = grunt.file.read('./test/expected/concat.html');
        var actual = grunt.file.read('./test/actual/concat.html');

        assert.strictEqual(actual, expected);
    });

    it('should be able to wrap templates', function() {
        assert.isTrue(grunt.file.exists('./test/actual/wrapped.html'));

        var expected = grunt.file.read('./test/expected/wrapped.html');
        var actual = grunt.file.read('./test/actual/wrapped.html');

        assert.strictEqual(actual, expected);
    });

    it('should be able to inject current filepath in wrapping', function() {
        assert.isTrue(grunt.file.exists('./test/actual/wrappedAdv.html'));

        var expected = grunt.file.read('./test/expected/wrappedAdv.html');
        var actual = grunt.file.read('./test/actual/wrappedAdv.html');

        assert.strictEqual(actual, expected);
    });

    it('should wrap fragments individually when concatenating and wrapping', function() {
        assert.isTrue(grunt.file.exists('./test/actual/wrappedConcat.html'));

        var expected = grunt.file.read('./test/expected/wrappedConcat.html');
        var actual = grunt.file.read('./test/actual/wrappedConcat.html');

        assert.strictEqual(actual, expected);
    });

    it('should be able to replace part of an injected value', function() {
        assert.isTrue(grunt.file.exists('./test/actual/wrappedReplace.html'));

        var expected = grunt.file.read('./test/expected/wrappedReplace.html');
        var actual = grunt.file.read('./test/actual/wrappedReplace.html');

        assert.strictEqual(actual, expected);
    });

    it('should be able to minify html output', function() {
        assert.isTrue(grunt.file.exists('./test/actual/min.html'));

        var expected = grunt.file.read('./test/expected/min.html');
        var actual = grunt.file.read('./test/actual/min.html');

        assert.strictEqual(actual, expected);
    });

    it('should be able to minify a css file', function() {
        assert.isTrue(grunt.file.exists('./test/actual/foo.min.css'));

        var expected = grunt.file.read('./test/expected/foo.min.css');
        var actual = grunt.file.read('./test/actual/foo.min.css');

        assert.strictEqual(actual, expected);
    });
});