app.config(['$routeProvider', ($routeProvider) ->
  $routeProvider
    .when('/', {
      templateUrl: 'views/books/index.html',
      controller: 'IndexCtrl'
    })
    .when('/new', {
      templateUrl: 'views/books/new.html',
      controller: 'NewCtrl'
    })
    .when('/view/:id', {
      templateUrl: 'views/books/view.html',
      controller: 'ViewCtrl'
    })
    .when('/edit/:id', {
      templateUrl: 'views/books/edit.html',
      controller: 'EditCtrl'
    })
    .otherwise({
      'redirectTo': '/'
    })
])
