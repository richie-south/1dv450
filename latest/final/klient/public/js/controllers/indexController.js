'use strict';

angular
    .module('myapp')
    .controller('indexController', indexController);

function indexController($scope, $sessionStorage, IndexService) {

    this.search = function(){
        this.mesClass = 'is-hidden';
        IndexService.getOwnToilets(this.searchfield)
            .then(value => {
                console.log(value);
                this.mes = '';
                this.mesClass = 'is-hidden';
                this.toiletList = value.data.toilets;
            })
            .catch(e => {
                console.log(e);
                if(e.status === 404) {
                    this.mes = 'No result!';
                    this.mesClass = 'is-danger';
                } else {
                    this.mes = 'unknown error';
                    this.mesClass = 'is-warning';
                }
            });

    };
}
