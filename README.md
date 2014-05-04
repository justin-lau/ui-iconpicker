# ui-iconpicker - _Bootstrap 3 Icon Picker for AngularJS_ #

[![Bower version](https://badge.fury.io/bo/ui-iconpicker.png)](http://badge.fury.io/bo/ui-iconpicker)
[![devDependencies Status](https://david-dm.org/justin-lau/ui-iconpicker/dev-status.png)](https://david-dm.org/justin-lau/ui-iconpicker#info=devDependencies)


ui-iconpicker is a [Bootstrap]([Bootstrap](http://getbootstrap.com/)) (and
optionally [Font Awesome](http://fortawesome.github.io/Font-Awesome/)) icons
picking component implemented in [AngularJS](https://angularjs.org/).



## Demo ##

To see the directive in action, visit http://justin-lau.github.io/ui-iconpicker/.



## Usage ##

### Dependencies ###
ui-iconpicker depends only on
[Angular UI Bootstrap](http://angular-ui.github.io/bootstrap/), and thus also
depends on [AngularJS](https://angularjs.org/) and
[Bootstrap](http://getbootstrap.com/)'s CSS. It also supports
[Font Awesome](http://fortawesome.github.io/Font-Awesome/) icons.

### Installation ###
Normally you would use ui-iconpicker like this:

```html
<html>
<head>
	<!-- Bootstrap CSS -->
	<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
	<!-- Font-Awesome CSS (Optional) -->
	<link rel="stylesheet" href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.min.css">
	<!-- AngularJS CSP CSS -->
	<link rel="stylesheet" href="//rawgithub.com/angular/code.angularjs.org/master/1.2.16/angular-csp.css">
	<!-- ui-iconpicker CSS -->
	<link rel="stylesheet" href="//rawgithub.com/justin-lau/ui-iconpicker/v0.1.4/dist/styles/ui-iconpicker.min.css">
</head>
<body ng-app>
	<!-- Body Content -->

	<!-- AngularJS Script -->
	<script type="text/javascript" src="//ajax.googleapis.com/ajax/libs/angularjs/1.2.16/angular.min.js"></script>
	<!-- Angular UI Boostrap Script -->
	<script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/angular-ui-bootstrap/0.10.0/ui-bootstrap-tpls.min.js"></script>
	<!-- ui-iconpicker Script -->
	<script type="text/javascript" src="//rawgithub.com/justin-lau/ui-iconpicker/v0.1.4/dist/scripts/ui-iconpicker.min.js"></script>
	<script>
		
		// load ui-iconpicker as Angular dependency
		angular.module('myModule', ['ui-iconpicker']);

	</script>
</body>
</html>
```

ui-iconpicker also supports the AMD API ([RequireJS](http://requirejs.org/)),
the same scripts from above would look like the following with RequireJS:

```javascript
require.config({
	paths: {
		'angular': '//ajax.googleapis.com/ajax/libs/angularjs/1.2.16/angular.min',
		'angular-bootstrap': '//cdnjs.cloudflare.com/ajax/libs/angular-ui-bootstrap/0.10.0/ui-bootstrap-tpls.min',
		'ui-iconpicker': '//rawgithub.com/justin-lau/ui-iconpicker/v0.1.4/dist/scripts/ui-iconpicker.min',
	},

	shim: {
		'angular': {
			exports: 'angular',
		},
		'angular-bootstrap': {
			deps: ['angular'],
		},
	},
});

require(['angular', 'ui-iconpicker'], function (angular) {

	// load ui-iconpicker as Angular dependency
	angular.module('myModule', ['ui-iconpicker']);

});
```