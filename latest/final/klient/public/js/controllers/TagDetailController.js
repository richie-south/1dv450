'use strict';

angular
  .module('myapp')
  .controller('TagDetailController', TagDetailController);



function TagDetailController($scope, $routeParams, TagService) {

    TagService.getAllToiletsOnTag($routeParams.id)
    .then(tags => {
        console.log(tags.data.toilets);
        this.tagText = 'All toilets on tag';
        this.infoBox = 'is-info';
        this.tagList = tags.data.toilets;
    })
    .catch(e => {
        console.log(e);
        this.infoBox = 'is-warning';
        this.tagText = 'Nothing is taged width this tag';
    });
}
