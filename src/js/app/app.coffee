dependencies = [
  'ngRoute', 
  'ngFileUpload'
]

this.app = angular.module('app', dependencies);

app.run(($http, $rootScope) ->
  $http.defaults.headers.common['Content-Type'] = 'application/json'
  $http.defaults.headers.common['Accept'] = 'application/json'
  $http.defaults.headers.common['x-apikey'] = '57fce1d2e9bc4d712dbf2b83'

  $rootScope.dbUrl = 'https://books-98cd.restdb.io/rest/books'
  $rootScope.dbUrlMedia = 'https://books-98cd.restdb.io/media'
)  

app.config(($locationProvider) ->
  $locationProvider.html5Mode(true)
)
