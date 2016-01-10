# AngularJS Application is defined here

(->
  angular
    .module('app', [
      'ui.bootstrap',
      'templates', # gem 'angular-rails-templates'
      'ngRoute' # standard routes
    ])
)()