'use strict';

angular
  .module("myapp")
  .factory('PositionService', PositionService);

function PositionService($q, $http) {

    return {
        getAll:function() {
            return $http.get('http://localhost:3000/api/positions?appkey=supernyckelen');
        },
        
        // TODO: use this?
        getPosition:function(id) {

        }
    };
}
