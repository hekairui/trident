service 'ipService', [
  '$http','$q','$state'
  ($http, $q, $state) ->
    cityMap = null

    @getIpList = () ->
      $http.get '/remote/admin/internal_ips.json'

    @addIp = (ip) ->
      $http.post '/remote/admin/add_internal_ip.json', ip

    @enableIp = (id) ->
      $http.post '/remote/admin/enable_internal_ip.json',
        id : id
    
    @disableIp = (id) ->
      $http.post '/remote/admin/disable_internal_ip.json',
        id : id
  
    @go = ->
      $state.go 'ip' 
    return
]
