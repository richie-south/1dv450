'use strict';

angular
  .module('myapp')
  .controller('ToiletListController', ToiletListController);
//ToiletListController.$inject = ['PositionService'];

function ToiletListController($scope, NgMap, ToiletService) {
    var that = this;

    NgMap.getMap().then((map) => {
        this.map = map;
        return ToiletService.getAll();
    })
    .then(toilets => {
      this.toiletList = toilets.data.toilets;
      that.mark = toilets.data.toilets[0];
    }).catch(e => console.log(e));


    this.markerClick = function(e, toilet){
        console.log(toilet);
        that.mark = toilet;
        that.map.showInfoWindow('iwi', this);
    };

}
