'use strict';

angular
  .module('myapp')
  .controller('ToiletListController', ToiletListController);

//ToiletListController.$inject = ['PositionService'];

function ToiletListController($scope, PositionService) {
    
    PositionService.getAll()
    .then(positions => {
        console.log(positions.data.positions);
        this.positionList = positions.data.positions;
    })
    .catch(e => console.log(e));
}
