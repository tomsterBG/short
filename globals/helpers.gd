# INFO:
# TODO:
# - Make more helpers.
# - Improve documentation.
# - Ensure correct code formatting.
# IDEAS:
# - Improve performance after testing how long the find_child family of methods takes.
# BAD IDEAS:
# - https://github.com/godotengine/godot-proposals/discussions/13011
# 	- As stated there: find_parent_with_method, find_parent_with_signal.
# 		- However this ignores a very important design pattern which is to not access parents.
# - Make all time conversions. From msec to sec and usec, from usec to sec and msec.

## @experimental: This class is immature.
## Global helper functions to shorten your code.
##
## Available in all scripts.
##[br][br][b]Note:[/b] When adding this script as a global, name the node [param Helpers].

class_name HelperMethods
extends Node


#region methods
#region conversions
## Converts a time expressed in seconds to milliseconds.
func sec_to_msec(sec: float) -> float:
	return sec * 1_000.0

## Converts a time expressed in seconds to microseconds.
func sec_to_usec(sec: float) -> float:
	return sec * 1_000_000.0

## Converts a number expressed in units to percentages. Units are from [code]0[/code] to [code]1[/code]. Percentages are from [code]0[/code] to [code]100[/code].
func unit_to_percent(unit: float) -> float:
	return unit * 100.0

## Converts a number expressed in percentages to units. Percentages are from [code]0[/code] to [code]100[/code]. Units are from [code]0[/code] to [code]1[/code].
func percent_to_unit(percent: float) -> float:
	return percent / 100.0
#endregion conversions

#region find_
## Finds the first descendant of a [param node] that has [param method]. Works similarly to [method Node.find_child]. See [method Object.has_method].
##[br][br][b]Note:[/b] This method can be slow.
func find_child_with_method(node: Node, method: StringName, recursive := true, owned := true) -> Node:
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
func find_child_with_signal(node: Node, signal_name: StringName, recursive := true, owned := true) -> Node:
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
func find_children_with_method(node: Node, method: StringName, recursive := true, owned := true) -> Array[Node]:
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
func find_children_with_signal(node: Node, signal_name: StringName, recursive := true, owned := true) -> Array[Node]:
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

## @experimental: Useless bloat, but more useful than a "[param get_grandparent()]".
## Returns [param node]'s nth ancestor node [code]n[/code] [param levels] up, or [code]null[/code] if the node doesn't have such ancestor. Calls [method Node.get_parent] [code]n[/code] times.
func get_ancestor(node: Node, levels: int) -> Node:
	var ancestor := node
	while levels > 0:
		levels -= 1
		ancestor = ancestor.get_parent()
		if ancestor == null: return null
	return ancestor
#endregion methods
