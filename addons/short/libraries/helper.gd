# INFO:
# This works standalone and is publicly accessible.
# TODO:
# IDEAS:
# - Improve performance of the find_child family of methods.
# - Make tire size calculator function. Takes width (mm)/ratio (percent) R (inch). Spits out a TireSizeResult with width (m), diameter (m), rim diameter (m), sidewall height (m).
# - Get air pressure at height (Earth).
# - save_dict_as_json(data: Dictionary, path: String) -> Error, load_dict_from_json(path: String) -> Dictionary, vec3_to_str(vec: Vector3, precision: int = 2) -> String, radians_to_compass_direction(angle: float) -> String, change_scene, format_memory(bytes: int) -> String, create_timer(wait_time: float, callable: Callable, owner_node: Node)
# - is_position_inside(position, volume)
# - flatten_array(array: Array) - converts nested arrays to elements of the parent array
# 	- a matrixify() counterpart to turn a flat array into a matrix or something complex
# - remove_duplicates(array: Array) - removes duplicate array values
# - wrap_text(text: String, line_length: int)
# - Random.get_total_weight() or sum_array()
# BAD IDEAS:
# - https://github.com/godotengine/godot-proposals/discussions/13011
# 	- As stated there: find_parent_with_method, find_parent_with_signal.
# 		- However this ignores a very important design pattern which is to not access parents.
# - toggle(bool) -> !bool: It's an idea, but like... why?
# - approach a value: We already have move_toward(), this could work differently though.
# - calculate linear crossfade volume: First steps towards an engine sound system.
# - toggle fullscreen: Maybe? Ensure it doesn't need me to remember state.
# - mouse axis input with deadzones: Must first check how to do that without helper.
# - get_usec_since_event(event_at) - usec, Time.get_ticks_usec() - event_at. Hard to test.

## @experimental: This class is immature.
## Shorten your code.
##
## Available in all scripts without any setup.
##[br][br]An abstract script to help you achieve more behavior with less code.

@abstract class_name Helper extends Node


#region classes
## The result returned by [method Helper.get_dir_children].
class DirChildrenResult:
	## The files found at [param path].
	var files: Array = []
	## The folders found at [param path].
	var folders: Array = []
#endregion classes


#region getters
## Returns [param node]'s nth ancestor node [code]n[/code] [param levels] up, or [code]null[/code] if the node doesn't have such ancestor. Calls [method Node.get_parent] [code]n[/code] times.
##[br][br][b]Note:[/b] Bad code practice. Nodes should be unaware of their parents.
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
	
	var files: Array = DirAccess.get_files_at(path)
	result.files.assign(files.map(func(f): return path+f))
	
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

## Returns a [Resource]'s file system name. If [param include_extension] is [code]true[/code], includes the file extension.
static func get_resource_filename(resource: Resource, include_extension := false) -> String:
	if include_extension: return resource.resource_path.get_file()
	return resource.resource_path.get_basename().get_file()
#endregion getters


#region methods
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

	#region is_
## Returns [code]true[/code] if the given string is affirmative.
##[br][br][b]Note:[/b] An affirmative string is [code]"yes", "y", "true", "1"[/code].
static func is_affirmative(string: String) -> bool:
	return ["yes", "y", "true", "1"].has(string)

## Returns [code]true[/code] if the given string is negative.
##[br][br][b]Note:[/b] A negative string is [code]"no", "n", "false", "0"[/code].
static func is_negative(string: String) -> bool:
	return ["no", "n", "false", "0"].has(string)

## Returns [code]true[/code] if the given string is a number in binary.
static func is_binary(binary: String) -> bool:
	for character in binary:
		if character == "0" or character == "1": continue
		else: return false
	return true

## Returns [code]true[/code] if the given string is a single character.
static func is_character(string: String) -> bool:
	return string.length() == 1

## Returns [code]true[/code] if the given character is a digit.
static func is_digit(character: String) -> bool:
	if !is_character(character): return false
	return character >= "0" and character <= "9"

## Returns [code]true[/code] if the given character is a letter.
static func is_letter(character: String) -> bool:
	if !is_character(character): return false
	return (character >= "a" and character <= "z") or (character >= "A" and character <= "Z")
	#endregion is_

## @experimental: Untested.
## Instantiates a [param scene] at [param position] inside [param parent] and returns it.
static func instantiate_at(scene: PackedScene, parent: Node, position) -> Node:
	var instance := scene.instantiate()
	parent.add_child(instance)
	instance.position = position
	return instance
#endregion methods
