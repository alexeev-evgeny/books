app.controller 'IndexCtrl', ($scope, $rootScope, dbService) ->
 
  $scope.books = {}
  dbService.load($rootScope.dbUrl).then((data) ->
    $scope.books = data
  )

  
