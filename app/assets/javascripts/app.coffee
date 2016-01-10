# AngularJS Application is defined here

(->
  angular
    .module('app', [
      'ui.bootstrap',
      'angular-loading-bar',
      'ngAnimate',
      'templates', # gem 'angular-rails-templates'
      'ngRoute' # standard routes
    ])

    # angular-loading-bar configuration
    .config(['cfpLoadingBarProvider', (cfpLoadingBarProvider) ->
      cfpLoadingBarProvider.latencyThreshold = 10
      cfpLoadingBarProvider.includeSpinner   = false
    ])
)()