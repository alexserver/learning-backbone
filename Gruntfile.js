module.exports = function(grunt) {

  // Project configuration.
  grunt.initConfig({
    coffee: {
      compile: {
        files: {
          'app/public/app.js': ['app/frontend/*.coffee']
        }
      }
    },
    nodemon: {
      dev: {
        script: 'app/index.js',
        options: {
          ignore: ['app/frontend/**', 'app/public/**']
        }
      }
    },
    watch: {
      scripts: {
        files: 'app/frontend/*.coffee',
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

};