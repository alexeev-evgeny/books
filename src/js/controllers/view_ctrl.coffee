app.controller 'ViewCtrl', ($scope, $rootScope, $routeParams, $location, dbService) ->

  $scope.openedBook = null

  if $routeParams.id
    $scope.url = $rootScope.dbUrl + '/' + $routeParams.id
 
    dbService.load($scope.url).then((data) ->
      $scope.openedBook = data
      printingDate = $scope.openedBook.printingDate
      $scope.openedBook.printingDate = moment(printingDate).format('DD.MM.YYYY')
    )
  else
    $location.path('/')

  $scope.delete = () ->
    if confirm('Delete a book?')
      dbService.delete($scope.url).then(
        $location.path('/')
      )
