trident = angular.module 'trident', [
  'ngAnimate'
  'ngTouch'
  'ui.router'
  'ui.bootstrap'
  'trident.templates'
  ]

directive = controller = factory = service = config = filter = null

(() ->
  _apply = (name,that) -> () -> that[name].apply that,arguments
  directive = _apply 'directive', trident
  controller = _apply 'controller', trident
  factory = _apply 'factory', trident
  service = _apply 'service', trident
  config = _apply 'config', trident
  filter = _apply 'filter', trident
)()


angular.element document 
.ready ->
  angular.bootstrap document, [
  	'trident'
  ]