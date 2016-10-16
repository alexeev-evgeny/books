app.controller 'parentCtrl', ($scope, $rootScope) ->

  if localStorage.getItem('orderField') == undefined
    $scope.orderField = 'title'
  else
    $scope.orderField = localStorage.getItem('orderField')

  $scope.orderByField = (field) ->
    $scope.orderField = field
    localStorage.setItem('orderField', field)
  
  $rootScope.showOnlyFavorites = false
  $scope.toggleFavoritesVisible = () ->
    $rootScope.showOnlyFavorites = !$rootScope.showOnlyFavorites
    
  $scope.checkFavoriteState = (favoriteState) ->
    if !$rootScope.showOnlyFavorites || favoriteState
      return true
