'use strict';

angular
  .module('myapp')
  .controller('ToiletDetailController', ToiletDetailController);

function ToiletDetailController($scope, $routeParams, ToiletService) {

    ToiletService.getToilet($routeParams.id)
    .then(toilet => {
        this.data = toilet.data;
    })
    .catch(e => {
        console.log(e);
    });
}
