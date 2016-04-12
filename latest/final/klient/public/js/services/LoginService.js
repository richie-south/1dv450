'use strict';

angular
  .module("myapp")
  .factory('LoginService', LoginService);

function LoginService($q, $http, $sessionStorage) {

    return {
        getJWT:function(data) {
            console.log(data.username);
            var req = {
            method: "post",
            url :"http://localhost:3000/knock/auth_token?key=friendss01e10",
            data: {"auth": {"name": data.username, "password": data.password}}

          };
         return $http(req);
        },

        isLoggedIn: function(){
            return $sessionStorage.loggedInUser;
        },

        logOut: function(){
            $sessionStorage.$reset();
        },

        getJwt: function(){
            return $sessionStorage.jwt;
        }

    };
}
