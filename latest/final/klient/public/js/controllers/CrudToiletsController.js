'use strict';

angular
  .module('myapp')
  .controller('CrudToiletsController', CrudToiletsController);

function CrudToiletsController($scope, $http, CrudToiletService, $sessionStorage, $route) {

    CrudToiletService.getOwnToilets($sessionStorage.username)
        .then(result => {
            return $http.get('http://localhost:3000/api/toilets?appkey=supernyckelen&creator_id='+result.data.id);
        })
        .then(value => {
            console.log(value.data.toilets);
            this.ownList = value.data.toilets;
        })
        .catch(e => {
            console.log(e);
        });

    this.remove = function(id){
        $route.reload();
        CrudToiletService.remove(id)
            .then(value => {
                
            })
            .catch(e => console.log(e));

    };
}
