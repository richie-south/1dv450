'use strict';

angular
  .module('myapp')
  .controller('OwnToiletController', OwnToiletController);

function OwnToiletController($scope, $routeParams, CrudToiletService, ToiletService) {

    ToiletService.getToilet($routeParams.id)
        .then(value => {
            console.log(value);
            this.toilet = value.data;
        });

    this.save = function(){

        var obj = {
            toilet:{
                name: this.toilet.name,
                description: this.toilet.description,
                positions:[
                    { address: this.toilet.address }
                ]
            }
        };
        CrudToiletService.update(obj, this.toilet.id)
            .then(value => {
                console.log(value);
            });
        //console.log(this);
    };
}
