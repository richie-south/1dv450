

'use strict';

angular
  .module("myapp")
  .factory('CrudToiletService', CrudToiletService);

function CrudToiletService($q, $http, $sessionStorage) {

    return {
        update:function(data, id) {

            var req = {
                method: "put",
                url :"http://localhost:3000/api/toilets/"+id+"?appkey=supernyckelen",
                headers: {"Authorization": $sessionStorage.jwt},
                data: data
            };
         return $http(req);
        },

        remove: function(id){
            var req = {
            method: "delete",
                url :"http://localhost:3000/api/toilets/"+id+"?appkey=supernyckelen",
                headers: {"Authorization": $sessionStorage.jwt}
            };
            return $http(req);
        },

        getOwnToilets: function(name){
            return $http.get('http://localhost:3000/api/creator_by_name?appkey=supernyckelen&name='+name);
        },


    };
}
