'use strict';

angular
  .module('myapp')
  .controller('TagListController', TagListController)
  .directive('myTagList', function() {
    return {
        restrict: 'E',
        templateUrl: '../../partials/myTagListDirective.html'
    };
  });

function TagListController($scope, $rootScope, TagService) {
    TagService.getAll()
    .then(tags => {
        this.tagList = tags.data.tags;
    })
    .catch(e => console.log(e));
}
