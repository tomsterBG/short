# INFO:
# TODO:
# - Add more unit tests.
# - Document undocumented methods.
# - Improve documentation.
# - Ensure correct code formatting.
# - The find_child method family owner property is probably implemented incorrectly. Don't check if owner is node, check if owner is valid.
# BAD IDEAS:
# - https://github.com/godotengine/godot-proposals/discussions/13011
# 	- As stated there: find_parent_with_method, find_parent_with_signal.
# 		- However this ignores a very important design pattern which is to not access parents.

## @experimental: This class is immature.
## Global helper functions to shorten your code.
##
## Available in all scripts.
##[br][br][b]Note:[/b] When adding this script as a global, name the node [param Helpers].

class_name HelperMethods
extends Node


#region methods
#region find_
## @experimental: Untested.
## Finds the first descendant of a [param node] that has [param method]. Works similarly to [method Node.find_child]. See [method Object.has_method].
func find_child_with_method(node: Node, method: StringName, recursive := true, owned := true) -> Node:
	var children_cache = node.get_children()
	for child: Node in children_cache:
		if owned and !child.owner: continue
		if child.has_method(method):
			return child
		if recursive:
			children_cache.append_array(child.get_children())
	return null

## @experimental: Untested.
## Finds the first descendant of a [param node] that has [param signal_name]. Works similarly to [method Node.find_child]. See [method Object.has_signal].
func find_child_with_signal(node: Node, signal_name: StringName, recursive := true, owned := true) -> Node:
	var children_cache = node.get_children()
	for child: Node in children_cache:
		if owned and !child.owner: continue
		if child.has_signal(signal_name):
			return child
		if recursive:
			children_cache.append_array(child.get_children())
	return null

## @experimental: Untested.
## Finds all descendants of a [param node] that have [param method]. Works similarly to [method Node.find_children]. See [method Object.has_method].
func find_children_with_method(node: Node, method: StringName, recursive := true, owned := true) -> Array[Node]:
	var array := []
	var children_cache = node.get_children()
	for child: Node in children_cache:
		if owned and !child.owner: continue
		if child.has_method(method):
			array.append(child)
		if recursive:
			children_cache.append_array(child.get_children())
	return array

## @experimental: Untested.
## Finds all descendants of a [param node] that have [param signal_name]. Works similarly to [method Node.find_children]. See [method Object.has_signal].
func find_children_with_signal(node: Node, signal_name: StringName, recursive := true, owned := true) -> Array[Node]:
	var array := []
	var children_cache = node.get_children()
	for child: Node in children_cache:
		if owned and !child.owner: continue
		if child.has_signal(signal_name):
			array.append(child)
		if recursive:
			children_cache.append_array(child.get_children())
	return array
#endregion find_

## @experimental: Untested. Useless bloat, but more useful than a "[param get_grandparent()]".
## Returns [param node]'s nth ancestor node [code]n[/code] [param levels] up, or [code]null[/code] if the node doesn't have such ancestor. Calls [method Node.get_parent] [code]n[/code] times.
func get_ancestor(node: Node, levels: int) -> Node:
	var ancestor := node
	while levels > 0:
		levels -= 1
		ancestor = ancestor.get_parent()
		if ancestor == null: return null
	return ancestor
#endregion methods
