# Routes configuration for my AngularJS app

(->

  config = [ '$routeProvider', '$locationProvider', '$httpProvider', ($routeProvider, $locationProvider, $httpProvider) ->
    # Turning '/#/smth' routes into '/smth'. Practical!
    $locationProvider.html5Mode
      enabled: true,
      requireBase: false

    # Rails CSRF protection
    $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content')

    $routeProvider
      .when '/',
        templateUrl: 'ng-views/home.html',
        controller: 'ParrotsController as vm' # Modern 'as' syntax
                                              # 'vm' goes for ViewModel
      .otherwise
        redirectTo: '/'
  ]

  angular
    .module('app')
    .config(config)

)()