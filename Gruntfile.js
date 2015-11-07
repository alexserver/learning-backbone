module.exports = function(grunt) {

  // Project configuration.
  grunt.initConfig({
    coffee: {
      compile: {
        files: {
          'app/public/app.js': ['app/source/*.coffee']
        }
      },
      test: {
        expand: true,
        flatten: true,
        cwd: 'spec/app',
        src: ['**/*.coffee'],
        dest: 'spec/app',
        ext: '.js'
      }
    },
    nodemon: {
      dev: {
        script: 'app/index.js',
        options: {
          ignore: ['app/source/**', 'app/public/**', 'node_modules/**']
        }
      }
    },
    watch: {
      scripts: {
        files: 'app/source/*.coffee',
        tasks: ['coffee'],
        options: {
          spawn: false
        }
      }
    },
    concurrent: {
      dev: {
        tasks: ['nodemon', 'watch'],
        options: {
          logConcurrentOutput: true
        }
      }
    }
  });

  grunt.loadNpmTasks('grunt-concurrent');
  grunt.loadNpmTasks('grunt-contrib-coffee');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-nodemon');

  // Default task(s).
  grunt.registerTask('default', ['coffee', 'concurrent']);
  grunt.registerTask('test', ['coffee']);
};
