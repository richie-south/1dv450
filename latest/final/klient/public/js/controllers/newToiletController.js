'use strict';

angular
  .module('myapp')
  .controller('newToiletController', newToiletController);

function newToiletController($scope, $http, $sessionStorage, $route, $routeParams, CrudToiletService, TagService) {


    TagService.getAll()
        .then(value => {
            console.log(value.data.tags);
            this.tags = value.data.tags;

        })
        .catch(e => {
            console.log(e);
        });
        this.save = function(){
                console.log(this);

            var getTags = (tags) => {
                return tags.filter(tag => {
                    return tag.hasOwnProperty('val') && tag.val === true;
                })
                .map(tag => {
                    return {
                        name: tag.name
                    };
                });
            };
            var t = {
                toilet: {
                    name: this.toilet.name,
                    description: this.toilet.description,
                    positions:[
                        { address: this.toilet.address }
                    ],
                    tags: getTags(this.tags)
                }
            };

            CrudToiletService.create(t)
                .then(r => {
                    this.mes = 'Succsesfully created toilet!';
                    this.mesClass = 'is-success';
                })
                .catch(e => {
                    if(e.status === 404) {
                        this.mes = 'Faild to create toilet!';
                        this.mesClass = 'is-danger';
                    } else {
                        this.mes = 'unknown error';
                        this.mesClass = 'is-warning';
                    }
                });
        };

}
