'use strict';

angular
  .module('myapp')
  .controller('OwnToiletController', OwnToiletController);

function OwnToiletController($scope, $routeParams, CrudToiletService, ToiletService, TagService) {

    TagService.getAll()
        .then(value => {
            this.tags = value.data.tags;
            console.log(this.tags);
            return ToiletService.getToilet($routeParams.id);
        })
        .then(value => {
            this.toilet = value.data;
        })
        .catch(e => {
            console.log(e);
        });

    this.save = function(){
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

        CrudToiletService.update(t, $routeParams.id)
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
