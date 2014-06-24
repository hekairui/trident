directive 'ipView', -> 
  replace: true
  restrict: 'E'
  templateUrl: 'ip.html'  
  controller: [
    '$scope','ipService', '$state'
    ($scope, ipService, $state) ->
      ipService.getIpList().success (ip) ->
        $scope.ipList = ip

      $scope.add = () ->
        $state.go 'ip.add'

      $scope.change = (ip) ->
        if ip.state?
          if ip.state == 1
            ipService.disableIp(ip.id)
            .success () ->
              ip.state = 0  
          else
            ipService.enableIp(ip.id)
            .success () ->
              ip.state = 1
  ]
config [
  '$stateProvider'
  ($stateProvider) ->
    $stateProvider
    .state 'ip.add', 
      url: '/add',
      template: '<ip-add-view></ip-add-view>'
]  
