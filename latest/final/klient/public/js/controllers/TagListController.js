'use strict';

angular
  .module('myapp')
  .controller('TagListController', TagListController);

function TagListController($scope, $rootScope, TagService) {

    TagService.getAll()
    .then(tags => {
        console.log(tags.data.tags);
        this.tagList = tags.data.tags;
    })
    .catch(e => console.log(e));
}
