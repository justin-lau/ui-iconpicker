# @author    Justin Lau <justin@tclau.com>
# @copyright Copyright (c) 2014 Justin Lau <justin@tclau.com>
# @license   The MIT License (MIT)
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#

umd = (root, factory) ->

	# AMD
	if typeof define is "function" and define.amd?
		define("templates/iconpicker", [
			"angular"
			"angular-bootstrap"
		], factory);

	# Non-AMD
	else
		factory(root.angular);

umd this, (angular) ->

	# Register Angular Module
	module = angular.module("ui-iconpicker/templates/iconpicker", [
		"ui.bootstrap"
	]);

	# Create template into cache
	module.run [
		"$templateCache"
		($templateCache) ->
			$templateCache.put "templates/iconpicker.html",
				"""
				<span class="btn-group ui-iconpicker" ng-class="{ disabled: disabled }">
					<button type="button" class="btn btn-default dropdown-toggle"><i class="{{ iconClass }}"></i><span class="caret"></span>
					</button>
					<ul class="dropdown-menu" role="menu">
						<li ng-repeat="class in availableIconClasses">
							<button class="btn btn-default" type="button" ng-click="$parent.iconClass = class"><span class="{{ class }}"></span></button>
						</li>
					</ul>
					<input name="{{ name }}" type="hidden" value="{{ iconClass }}" ng-if="name" />
				</span>
				"""
	]