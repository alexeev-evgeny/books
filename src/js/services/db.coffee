app.service 'dbService', ($http, $log, Upload) ->

  @load = (url) =>
    $http
      .get(url)
      .then(
        (response) ->
          return response.data
        (error) ->
          $log.error('ERROR: ' + error)
      )

  @save = (url, data) =>
    $http
      .put(url, data)
      .success((data, status, headers, config) ->
        $log.info('DATA SAVE SUCCESSFULL')
      )
      .error((data, status, header, config) ->
        $log.error('DATA SAVE ERROR:', status, data)
      )

  @add = (url, data) =>
    dataJson = angular.toJson(data)
    $http
      .post(url, dataJson)
      .success((data, status, headers, config) ->
        $log.info('DATA SAVE SUCCESSFULL', status, data)
      )
      .error((data, status, header, config) ->
        $log.error('DATA SAVE ERROR:', status, data, config)
      )

  @delete = (url) =>
    $http
      .delete(url)
      .success((data, status) ->
        $log.info('DATA DELETE SUCCESSFULL', status, data)
      )
      .error((data, status, header, config) ->
        $log.error('DATA DELETE ERROR:', status, data)
      )

  @uploadFile = (url, file) =>
    if !file
      $log.error('FILE UPLOAD ERROR: ', file)
      return
    result = {}
    file.upload = Upload.upload({
      url: url,
      data: {file: file}
    }).then(
      (response) ->
        if response.status == 201
          result.fileUrl = url + '/' + response.data.ids[0]
          return result
      (response) ->
        $log.error('FILE UPLOAD ERROR: ', response)
      (event) ->
        result.fileIsUploaded = true
        return result
    )

  return @