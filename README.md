# grunt-template-helper

**Super simple grunt template processor.**

## Installation

Install npm package, next to your projects `Grunfile`:

    npm install grunt-template-helper

Add this line to your project's `Gruntfile`:

    grunt.loadNpmTasks('grunt-template-helper');


## Template task
_Run this task with the `grunt template` command._

_This task is a [multi task][] so any targets, files and options should be specified according to the [multi task][] documentation._
[multi task]: https://github.com/gruntjs/grunt/wiki/Configuring-tasks

_This plugin is only compatible with Grunt `0.4.x`._

### Options

#### data
Data to pass in to the template
Type: `Object`
Default: `{}`

### Usage Examples

```js
template: {
  dev: {
    options: {
      data: {
        env: 'dev',
        message: 'hello'
      }
    },
    files: [
      expand: true
      cwd:    './templates'
      src:    ['**/*.template']
      dest:   './public'
      ext:    'html'
    ]
  }
}
```