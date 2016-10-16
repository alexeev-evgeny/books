app.directive('tooltip', () ->
  restrict: 'A'
  templateUrl: 'views/directives/tooltip.html'
  scope:
    tooltipValue: '@'
  link: (scope, element, attrs) ->
  	angular.element(element).addClass('b-tooltip-box');
)