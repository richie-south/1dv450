'use strict';

angular
  .module('myapp')
  .controller('OwnTagController', OwnTagController);

function OwnTagController($scope, $routeParams, CrudTagService, TagService) {

    TagService.getOnId($routeParams.id)
        .then(value => {
            console.log(value);
            this.tag = value.data;
        });

    this.save = function(){

        var obj = {
            tag:{
                name: this.tag.name,
                description: this.tag.description,
                positions:[
                    { address: this.tag.address }
                ]
            }
        };
        CrudTagService.update(obj, $routeParams.id)
            .then(value => {
                this.mes = 'Update succsesfull';
                this.mesClass = 'is-success';
                console.log(value);
            })
            .catch(e => {
                if(e.status === 404) {
                    this.mes = 'Faild to update!';
                    this.mesClass = 'is-danger';
                } else {
                    this.mes = 'unknown error';
                    this.mesClass = 'is-warning';
                }
            });
    };
}
