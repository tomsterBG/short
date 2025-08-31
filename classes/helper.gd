# INFO:
# This works standalone and is publicly accessible.
# TODO:
# - Make more helper methods.
# - Improve documentation.
# - Ensure correct code formatting.
# IDEAS:
# - Improve performance of the find_child family of methods.
# BAD IDEAS:
# - https://github.com/godotengine/godot-proposals/discussions/13011
# 	- As stated there: find_parent_with_method, find_parent_with_signal.
# 		- However this ignores a very important design pattern which is to not access parents.
# - toggle(bool) -> !bool: It's an idea, but like... why?
# - approach a value: We already have move_toward(), this could work differently though.
# - calculate linear crossfade volume: First steps towards an engine sound system.
# - toggle fullscreen: Maybe? Ensure it doesn't need me to remember state.

## @experimental: This class is immature.
## Public helper methods to shorten your code.
##
## Available in all scripts.

class_name Helper
extends Node


#region classes
## The result returned by [method Helper.get_dir_children].
class DirChildrenResult:
	## The files found at [param path].
	var files: Array = []
	## The folders found at [param path].
	var folders: Array = []
#endregion classes


#region constants
## Represents the acceleration of the Earth.
## Gravity (Earth) = 9.80665 (m/s^2)
const EARTH_GRAVITY = 9.80665
#endregion constants


#region methods
	#region conversions
		#region time
## Converts a time from seconds to milliseconds.
##[br][br][b]Time (seconds) * 1000 = Time (milliseconds)[/b]
static func sec_to_msec(sec: float) -> float:
	return sec * 1_000.0

## Converts a time from milliseconds to seconds.
##[br][br][b]Time (milliseconds) / 1000 = Time (seconds)[/b]
static func msec_to_sec(msec: float) -> float:
	return msec / 1_000.0

## Converts a time from seconds to microseconds.
##[br][br][b]Time (seconds) * 1000 000 = Time (microseconds)[/b]
static func sec_to_usec(sec: float) -> float:
	return sec * 1_000_000.0

## Converts a time from microseconds to seconds.
##[br][br][b]Time (microseconds) / 1000 000 = Time (seconds)[/b]
static func usec_to_sec(usec: float) -> float:
	return usec / 1_000_000.0
		#endregion time

		#region proportion
## Converts a proportion from units to percentages. Units are from [code]0[/code] to [code]1[/code]. Percentages are from [code]0[/code] to [code]100[/code]. See [method percent_to_unit].
##[br][br][b]Proportion (units) * 100 = Proportion (percentages)[/b]
static func unit_to_percent(unit: float) -> float:
	return unit * 100.0

## Converts a proportion from percentages to units. Percentages are from [code]0[/code] to [code]100[/code]. Units are from [code]0[/code] to [code]1[/code]. See [method unit_to_percent].
##[br][br][b]Proportion (percentages) / 100 = Proportion (units)[/b]
static func percent_to_unit(percent: float) -> float:
	return percent / 100.0
		#endregion proportion

		#region speed
## @experimental: Untested.
## Converts a speed from [code]meters/second[/code] to [code]km/h[/code]. See also [url=https://www.youtube.com/watch?v=wFV3ycTIfn0]Converting m/s to km/h[/url].
##[br][br][b]Speed (meters/second) * 3.6 = Speed (km/h)[/b]
static func ms_to_kmh(ms: float) -> float:
	return ms * 3.6

## @experimental: Untested.
## Converts a speed from [code]km/h[/code] to [code]meters/second[/code]. See also [url=https://www.youtube.com/watch?v=ahDfIu1kxCU]Converting km/h to m/s[/url].
##[br][br][b]Speed (km/h) / 3.6 = Speed (meters/second)[/b]
static func kmh_to_ms(kmh: float) -> float:
	return kmh / 3.6

## @experimental: Untested.
## Converts a speed from [code]km/h[/code] to [code]miles/h[/code].
##[br][br][b]Speed (km/h) * 0.6213712 = Speed (miles/h)[/b]
##[br][br][b]Speed (km/h) / 1.609344 = Speed (miles/h)[/b]
static func kmh_to_mph(kmh: float) -> float:
	return kmh * 0.6213712

## @experimental: Untested.
## Converts a speed from [code]miles/h[/code] to [code]km/h[/code].
##[br][br][b]Speed (miles/h) * 1.609344 = Speed (km/h)[/b]
##[br][br][b]Speed (miles/h) / 0.6213712 = Speed (km/h)[/b]
static func mph_to_kmh(mph: float) -> float:
	return mph * 1.609344
		#endregion speed
	#endregion conversions

	#region find_
## Finds the first descendant of a [param node] that has [param method]. Works similarly to [method Node.find_child]. See [method Object.has_method].
##[br][br][b]Note:[/b] This method can be slow.
static func find_child_with_method(node: Node, method: StringName, recursive := true, owned := true) -> Node:
	var children_cache = node.get_children()
	for child: Node in children_cache:
		if (owned and !child.owner) or (!owned and child.owner): continue
		if child.has_method(method):
			return child
		if recursive:
			children_cache.append_array(child.get_children())
	return null

## Finds the first descendant of a [param node] that has [param signal_name]. Works similarly to [method Node.find_child]. See [method Object.has_signal].
##[br][br][b]Note:[/b] This method can be slow.
static func find_child_with_signal(node: Node, signal_name: StringName, recursive := true, owned := true) -> Node:
	var children_cache = node.get_children()
	for child: Node in children_cache:
		if (owned and !child.owner) or (!owned and child.owner): continue
		if child.has_signal(signal_name):
			return child
		if recursive:
			children_cache.append_array(child.get_children())
	return null

## Finds all descendants of a [param node] that have [param method]. Works similarly to [method Node.find_children]. See [method Object.has_method].
##[br][br][b]Note:[/b] This method can be slow.
static func find_children_with_method(node: Node, method: StringName, recursive := true, owned := true) -> Array[Node]:
	var array: Array[Node] = []
	var children_cache = node.get_children()
	for child: Node in children_cache:
		if (owned and !child.owner) or (!owned and child.owner): continue
		if child.has_method(method):
			array.append(child)
		if recursive:
			children_cache.append_array(child.get_children())
	return array

## Finds all descendants of a [param node] that have [param signal_name]. Works similarly to [method Node.find_children]. See [method Object.has_signal].
##[br][br][b]Note:[/b] This method can be slow.
static func find_children_with_signal(node: Node, signal_name: StringName, recursive := true, owned := true) -> Array[Node]:
	var array: Array[Node] = []
	var children_cache = node.get_children()
	for child: Node in children_cache:
		if (owned and !child.owner) or (!owned and child.owner): continue
		if child.has_signal(signal_name):
			array.append(child)
		if recursive:
			children_cache.append_array(child.get_children())
	return array
	#endregion find_

## @experimental: Bad code practice. Nodes should be unaware of their parents. More useful than "[code]get_grandparent()[/code]" (that method does not exist).
## Returns [param node]'s nth ancestor node [code]n[/code] [param levels] up, or [code]null[/code] if the node doesn't have such ancestor. Calls [method Node.get_parent] [code]n[/code] times.
static func get_ancestor(node: Node, levels: int) -> Node:
	var ancestor := node
	while levels > 0:
		levels -= 1
		ancestor = ancestor.get_parent()
		if ancestor == null: return null
	return ancestor

## Returns a [Helper.DirChildrenResult] containing paths to files and folders, at the given [param path]. Uses [method DirAccess.get_files_at], [method DirAccess.get_directories_at].
##[br][br]Each path starts from [param path] and ends with the file or folder name. For example if [param path] is [code]"res://"[/code] and you only have an [code]addons[/code] folder, the string for it would look like [code]"res://addons"[/code].
static func get_dir_children(path: String, recursive: bool = false) -> DirChildrenResult:
	var result := DirChildrenResult.new()
	
	var files = DirAccess.get_files_at(path)
	for file in files: # Is there a way to fast-add prefix to all strings in an array?
		result.files.append(path+file)
	
	var folders = DirAccess.get_directories_at(path)
	for folder in folders:
		result.folders.append(path+folder)
		if !recursive: continue
		var this_result = get_dir_children(path+folder+"/", recursive)
		result.files.append_array(this_result.files)
		result.folders.append_array(this_result.folders)
	
	return result

## Returns the amount of lines in a file.
static func get_lines_in_file(path: String) -> int:
	var lines := 0
	var file := FileAccess.open(path, FileAccess.READ)
	while !file.eof_reached():
		file.get_line()
		lines += 1
	file.close()
	return lines
#endregion methods
