'use strict';

/* Filters */
console.log('filters.js');
angular.module('myapp.filters', []).
  filter('interpolate', function (version) {
    return function (text) {
      return String(text).replace(/\%VERSION\%/mg, version);
    };
  });
