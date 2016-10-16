app.controller 'NewCtrl', ($scope, $rootScope, $location, $log, $http, dbService, Upload) ->

  $scope.formSubmitted = false
  $scope.newBook = {
      'favorite': false,
      'authors': [
        {
          'name': '',
          'surname': ''
        }
      ]
    }
  $scope.isbnRegex = /^(?:ISBN(?:-1[03])?:? )?(?=[0-9X]{10}$|(?=(?:[0-9]+[- ]){3})[- 0-9X]{13}$|97[89][0-9]{10}$|(?=(?:[0-9]+[- ]){4})[- 0-9]{17}$)(?:97[89][- ]?)?[0-9]{1,5}[- ]?[0-9]+[- ]?[0-9]+[- ]?[0-9X]$/
  
  $scope.addAuthor = ->
    $scope.newBook.authors.push({'name': '', 'surname': ''})

  $scope.add = () ->
    $scope.formSubmitted = true
    switch
      when !$scope.newBookForm.$valid then alert('Form is invalid')
      when !$scope.newBook then alert('Form is empty')
      else dbService.add($rootScope.dbUrl, $scope.newBook).then((result) ->
              if result.status == 201
                $location.path('/')
              else
                $log.error(result)
            )

  $scope.fileUploadInProgress = false
  $scope.uploadImage = (file) ->
    $scope.fileUploadInProgress = true
    dbService.uploadFile($rootScope.dbUrlMedia, file).then((response) ->
      $scope.openedBook.imageUrl = response.fileUrl
      $scope.fileUploadInProgress = !response.fileIsUploaded
    )

  $scope.checkField = (name) ->
    if $scope.formSubmitted
      return !!(
        $scope.newBookForm.$invalid && 
        $scope.newBookForm[name].$invalid &&
        $scope.newBookForm[name].$untouched
      )

  $scope.fileUploadInProgress = false
  $scope.uploadImage = (file) ->
    $scope.fileUploadInProgress = true
    dbService.uploadFile($rootScope.dbUrlMedia, file).then((response) ->
      $scope.newBook.imageUrl = response.fileUrl
      $scope.fileUploadInProgress = !response.fileIsUploaded
    )
