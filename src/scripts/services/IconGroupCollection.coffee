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
		define("services/IconGroupCollection", [
			"angular"
			"values/icon-groups-map"
		], factory);

	# Non-AMD
	else
		factory(root.angular);

umd this, (angular) ->

	# Register Angular Module
	module = angular.module("ui-iconpicker/services/IconGroupCollection", [
		"ui-iconpicker/values/icon-groups-map"
	]);

	module.factory "IconGroupCollection", [
		"iconGroupsMap"
		(iconGroupsMap) ->

			class IconGroupCollection
				# usage: iconGroups = new IconGroupCollection("bootstrap font-awesome");
				constructor: (groupIdLiteral = "bootstrap") ->
					@iconGroupsMap = {};

					@includeGroups(groupIdLiteral);

				# usage: iconGroups = iconGroups.filterByGroups("bootstrap font-awesome")
				filterByGroups: (groupIdLiteral = "bootstrap") ->
					if groupIdLiteral isnt "all"
						groupIds = groupIdLiteral.split(" ");

						for groupId, group of @iconGroupsMap when groupIds.indexOf(groupId) isnt -1
							delete @iconGroupsMap[groupId]

					return @;

				# usage: iconGroups = iconGroups.includeGroups("bootstrap font-awesome")
				includeGroups: (groupIdLiteral = "bootstrap") ->
					groupIds = groupIdLiteral.split(" ");

					for groupId, group of iconGroupsMap when not @iconGroupsMap[groupId]?
						if groupIdLiteral is "all" or groupIds.indexOf(groupId) isnt -1
							@iconGroupsMap[groupId] = group;

					return @;

				# usage: array = iconsets.getClassArray()
				getClassArray: ->
					classes = [];

					for id, group of @iconGroupsMap
						classes.push(group.prefix + iconClass) for iconClass in group.classes;

					return classes;
	]