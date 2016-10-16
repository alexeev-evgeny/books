app.controller 'EditCtrl', ($scope, $rootScope, $location, $routeParams, $log, dbService) ->

  $scope.formSubmitted = false
  $scope.openedBook = null
  $scope.isbnRegex = /^(?:ISBN(?:-1[03])?:? )?(?=[0-9X]{10}$|(?=(?:[0-9]+[- ]){3})[- 0-9X]{13}$|97[89][0-9]{10}$|(?=(?:[0-9]+[- ]){4})[- 0-9]{17}$)(?:97[89][- ]?)?[0-9]{1,5}[- ]?[0-9]+[- ]?[0-9]+[- ]?[0-9X]$/

  $scope.load = () ->
    dbService.load($scope.url).then((data) ->
      $scope.openedBook = data
      printingDate = $scope.openedBook.printingDate
      $scope.openedBook.printingDate = new Date(printingDate)
    )    

  $scope.save = () ->
    $scope.formSubmitted = true
    switch
      when !$scope.editBookForm.$valid then return alert('Form is invalid')
      when !$scope.openedBook then return alert('Form is empty')
      else dbService.save($scope.url, $scope.openedBook).then((result) ->
        if result.status == 200
          $location.path('/view/' + $routeParams.id)
        else
          $log.error(result)
      )

  $scope.delete = () ->
    if confirm('Delete a book?')
      dbService.delete($scope.url).then((result) ->
        if result.status == 200
          $location.path('/')
        else
          $log.error(result)
      )

  $scope.fileUploadInProgress = false
  $scope.uploadImage = (file) ->
    console.log 'KOKOKO'
    $scope.fileUploadInProgress = true
    dbService.uploadFile($rootScope.dbUrlMedia, file).then((response) ->
      $scope.openedBook.imageUrl = response.fileUrl
      $scope.fileUploadInProgress = !response.fileIsUploaded
    )

  $scope.checkField = (name) ->
    if $scope.formSubmitted
      return !!(
        $scope.openedBook.$invalid && 
        $scope.openedBook[name].$invalid &&
        $scope.openedBook[name].$untouched
      )

  $scope.addAuthor = ->
    $scope.openedBook.authors.push({'name': '', 'surname': ''})

  if $routeParams.id
    $scope.url = 'https://books-98cd.restdb.io/rest/books/' + $routeParams.id
    $scope.load()
  else
    $location.path('/')
