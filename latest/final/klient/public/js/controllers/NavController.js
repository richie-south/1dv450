'use strict';

angular
  .module('myapp')
  .controller('NavController', NavController);

function NavController($scope, LoginService) {

    $scope.isLoggedIn = function(){
        return LoginService.isLoggedIn();
    };
}
