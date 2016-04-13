'use strict';

angular
  .module("myapp")
  .factory('IndexService', IndexService);

function IndexService($q, $http, $sessionStorage) {

    return {
        getOwnToilets: function(text){
            return $http.get('http://localhost:3000/api/toilets?appkey=supernyckelen&search='+text);
        }
    };
}
