# grunt-template-helper

**Super simple grunt template processor and wrapper.**

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

#### wrap
Wrap the template with a banner and footer.
Type: `Object`
Default: `{}`

It is possible to inject file-path related data into the banner or footer of the wrapper. This is useful if you're wrapping your template with a script-tag, such as `<script type="text/ng-template" src="path/of/view.html">`. At the moment there are two values that are available to inject: `'src'` and `'dest'`. `'src'` represents the path to the template file, `'dest'` the path to the processed output file. Should you want to remove any part of the `'src'` or `'dest'` paths you can do so by specifying the `rem` property. The injection points are specified using positional markers, as such: `foo #{0} bar #{1}`.

### Usage Examples

```js
template: {
  dev: {
    options: {
      data: {
        env: 'dev',
        message: 'hello'
      }
      wrap: {
        banner: '<script type="text/ng-template" from="#{0}" to="#{1}"></script>',
        footer: '</script>',
        inject: [{
          prop: 'src'
        }, {
          prop: 'dest',
          rem:  '/unwanted/path'
        }]
      }
    },
    files: 
      'path/to/result.html': 'path/to/input.template',
      'path/to/another.html': ['path/to/more/*.template', 'path/to/even/more/*.template'] // concatenates (individually wrapped) files
  }
}
```