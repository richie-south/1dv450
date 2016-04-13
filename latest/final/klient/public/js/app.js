'use strict';

angular
  .module("myapp", ['ngRoute', 'ngMap', 'ngStorage'])
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
        when('/login/', {
          templateUrl: '/partials/login.html',
          controller: 'LoginController',
          controllerAs: 'loginctr'
        }).
        when('/owntoilets/', {
          templateUrl: '/partials/listOwnToilets.html',
          controller: 'CrudToiletsController',
          controllerAs: 'owntctr'
        }).
        when('/owntoilets/:id', {
          templateUrl: '/partials/listOwnToilet.html',
          controller: 'OwnToiletController',
          controllerAs: 'ottctr'
        }).
        when('/owntags/', {
          templateUrl: '/partials/listOwnTags.html',
          controller: 'CrudTagsController',
          controllerAs: 'owntags'
        }).
        when('/owntags/:id', {
          templateUrl: '/partials/listOwnTag.html',
          controller: 'OwnTagController',
          controllerAs: 'owntag'
        }).
        when('/newTag', {
          templateUrl: '/partials/newTag.html',
          controller: 'newTagController',
          controllerAs: 'newtag'
        }).
        otherwise({
          redirectTo: '/'
        });
      $locationProvider.html5Mode(true);

}]);
