'use strict';

angular
  .module("myapp")
  .factory('ToiletService', ToiletService);

function ToiletService($q, $http) {

    return {
        getAll:function() {
            return $http.get('http://localhost:3000/api/toilets?appkey=supernyckelen');
        },

        getToilet: function(id){
            return $http.get('http://localhost:3000/api/toilets/'+id+'?appkey=supernyckelen');
        }
    };
}
