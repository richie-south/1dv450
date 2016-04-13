'use strict';

angular
  .module('myapp')
  .controller('CrudTagsController', CrudTagsController);

function CrudTagsController($scope, $http, CrudTagService, $sessionStorage, $route) {
    CrudTagService.getOwnTags($sessionStorage.username)
        .then(result => {
            return $http.get('http://localhost:3000/api/tags?appkey=supernyckelen&creator_id='+result.data.id);
        })
        .then(value => {
            console.log(value.data.tags);
            this.ownList = value.data.tags;
        })
        .catch(e => {
            console.log(e);
        });

    this.remove = function(id){
        $route.reload();
        CrudTagService.remove(id)
            .then(value => {

            })
            .catch(e => console.log(e));

    };
}
