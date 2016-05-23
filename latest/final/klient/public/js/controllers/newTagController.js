'use strict';

angular
  .module('myapp')
  .controller('newTagController', newTagController);

function newTagController($scope, $http, $sessionStorage, $route, $routeParams, CrudTagService) {

    this.save = function() {
        var obj = {
            tag:{
                name: this.tag.name
            }
        };

        CrudTagService.newTag(obj)
            .then(value => {
                this.mes = 'Create succsesfull';
                this.mesClass = 'is-success';
            })
            .catch(e => {
                if(e.status === 404) {
                    this.mes = 'Faild to create!';
                    this.mesClass = 'is-danger';
                } else {
                    this.mes = 'unknown error';
                    this.mesClass = 'is-warning';
                }
            });
    };
}
