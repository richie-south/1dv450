'use strict';

angular
  .module("myapp")
  .factory('TagService', TagService);

function TagService($q, $http) {

    return {
        getAll:function() {
            return $http.get('http://localhost:3000/api/tags?appkey=supernyckelen');
        },

        getAllToiletsOnTag: function(id){
            return $http.get('http://localhost:3000/api/toilets/?appkey=supernyckelen&tag_id='+id);
        },

        getOnId: function(id){
            return $http.get('http://localhost:3000/api/tags/'+id+'?appkey=supernyckelen');
        }


    };
}
