/**
 * @author    Justin Lau <justin@tclau.com>
 * @copyright Copyright (c) 2014 Justin Lau <justin@tclau.com>
 * @license   The MIT License (MIT)
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the 'Software'), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */


// RequireJS configuration
require.config({
	noGlobal: true,

	paths: {
		'angular': '//ajax.googleapis.com/ajax/libs/angularjs/1.2.16/angular.min',
		'angular-bootstrap': '//cdnjs.cloudflare.com/ajax/libs/angular-ui-bootstrap/0.10.0/ui-bootstrap-tpls.min',
		'prettify': '//raw.githubusercontent.com/angular/code.angularjs.org/master/1.2.16/docs/components/google-code-prettify-1.0.1/src/prettify',
		'ui-iconpicker': '//rawgithub.com/justin-lau/ui-iconpicker/v0.1.0/dist/scripts/ui-iconpicker.min',
	},

	shim: {
		'angular': {
			exports: 'angular',
		},
		'angular-bootstrap': {
			deps: ['angular'],
		},
	},

	waitSeconds: 20,
});
		
require([
	'angular',
	'ui-iconpicker',
	'prettify'
], function (angular, iconpicker, prettify) {

	angular.module('demo', [
		'ui-iconpicker',
	]);

	angular.bootstrap(document, ['demo']);

	prettify.prettyPrint();

})