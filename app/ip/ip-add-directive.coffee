directive 'ipAddView', -> 
  replace: true
  restrict: 'E'
  templateUrl: 'ip-add.html'  
  controller: [
    '$scope','$state','$stateParams','ipService','toast'
    ($scope, $state, $stateParams, ipService, toast) ->
      $scope.submiting = false
      $scope.submit = ->
        if !$scope.submiting and $scope.ipForm.$valid
          $scope.alert = null
          $scope.submiting = true
          
          ipService.addIp 
            ip : $scope.ip.ip_address
          .success (ip)->
            ipService.getIpList().success (ip) ->
              $scope.submiting = false
              $scope.$parent.ipList = ip
              toast "保存成功"
              $state.go '^'  
          .error (error)->
            $scope.submiting = false
            $scope.alert = 
              type : 'danger'
              text : errorHanlder error 
  ]

