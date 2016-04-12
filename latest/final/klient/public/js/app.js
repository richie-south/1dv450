'use strict';

console.log('app.js');

angular
  .module("myapp", ['ngRoute'])
  .config(['$routeProvider', '$locationProvider',
    function($routeProvider, $locationProvider) {
      $routeProvider.
        when('/', {
          templateUrl: '/partials/index.html'
        }).
        when('/toilets', {
          templateUrl: '/partials/toilet-list.html',
          controller: 'ToiletListController',
          controllerAs: 'toilets'
        }).
        when('/toilets/:id', {
          templateUrl: '/partials/toilet-detail.html',
          controller: 'ToiletDetailController',
          controllerAs: 'toilet'
        }).
        when('/tags', {
          templateUrl: '/partials/tag-list.html',
          controller: 'TagListController',
          controllerAs: 'tag'
        }).
        when('/tags/:id', {
          templateUrl: '/partials/tag-detail.html',
          controller: 'TagDetailController',
          controllerAs: 'tagdetail'
        }).
        otherwise({
          redirectTo: '/'
        });
      $locationProvider.html5Mode(true);

}]);
