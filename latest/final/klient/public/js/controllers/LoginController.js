'use strict';

angular
  .module('myapp')
  .controller('LoginController', LoginController);

function LoginController($scope, LoginService) {

    this.save = function(user){
        LoginService.getJWT({ username: this.user.username, password: this.user.password})
            .then(result => {
                console.log(result);

                this.mes = 'Succses!';
                this.mesClass = 'is-success';
            })
            .catch(e => {
                if(e.status === 404){
                    this.mes = 'Faild to login!';
                    this.mesClass = 'is-danger';
                }else{
                    this.mes = 'unknown error';
                    this.mesClass = 'is-warning';
                }
            });

    };
}
