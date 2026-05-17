# INFO:
# This works standalone and is publicly accessible.
#
# Some methods that were promoting anti-patterns, were simply removed or not implemented. That was abstraction for the sake of abstraction. Such as:
# - get_ancestor
# - find_child_with_method, find_child_with_signal, find_children_with_method, find_children_with_signal
# TODO:
# - Add an optional PackedStringArray to is_affirmative and is_negative to control what is considered as such.
# - get_class_name(source_code)
# - diff_arrays(old, new) -> added, removed, stayed
# - get_deep_value(object, value) -> Variant
# - get_indent_level(line) -> int
# - strip_code_comments(string) -> String
# - get_dir_file_extensions() -> PackedStringArray: like get_dir_children, but returns a list of file extensions
# - 
# IDEAS:
# - Improve performance of the find_child family of methods.
# - Make tire size calculator function. Takes width (mm)/ratio (percent) R (inch). Spits out a TireSizeResult with width (m), diameter (m), rim diameter (m), sidewall height (m).
# - Get air pressure at height (Earth).
# - save_dict_as_json(data: Dictionary, path: String) -> Error, load_dict_from_json(path: String) -> Dictionary, vec3_to_str(vec: Vector3, precision: int = 2) -> String, radians_to_compass_direction(angle: float) -> String, change_scene, format_memory(bytes: int) -> String, create_timer(wait_time: float, callable: Callable, owner_node: Node)
# - is_position_inside(position, volume)
# - flatten_array(array: Array) - converts nested arrays to elements of the parent array
# 	- a matrixify() counterpart to turn a flat array into a matrix or something complex
# - remove_duplicates(array: Array) - removes duplicate array values
# - wrap_text(text: String, line_length: int) - adds \n every line_length symbols from the start of a line
# - Random.get_total_weight() or sum_array()
# - instantiate_at - PackedScene as child of and at position.
# - rebase_path(path, old_base, new_base) - res://docs/README.md -> user://data/README.md
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
# - trash_dir(path) - Just use OS.move_to_trash(ProjectSettings.globalize_path(path)).

## @experimental: This class could change.
## Shorten your code.
##
## Available in all scripts without any setup.
##[br][br]A generic library to help you achieve more behavior with less code.

@abstract class_name Helper extends Object


#region classes
## The result returned by [method Helper.get_dir_children].
class DirChildrenResult:
	## The files found at [param path].
	var files: Array = []
	## The folders found at [param path].
	var folders: Array = []
#endregion classes


#region getters
## Returns a [Helper.DirChildrenResult] containing paths to files and folders, at the given [param path]. Uses [method DirAccess.get_files_at], [method DirAccess.get_directories_at].
##[br][br]Each path starts from [param path] and ends with the file or folder name. For example if [param path] is [code]"res://"[/code] and you only have an [code]addons[/code] folder, the string for it would look like [code]"res://addons"[/code].
static func get_dir_children(path: String, recursive: bool = false) -> DirChildrenResult:
	var result := DirChildrenResult.new()
	
	var files: Array = DirAccess.get_files_at(path)
	result.files.assign(files.map(func(f: String) -> String: return path.path_join(f)))
	
	var folders := DirAccess.get_directories_at(path)
	for folder in folders:
		result.folders.append(path.path_join(folder))
		if !recursive: continue
		var this_result := get_dir_children(path.path_join(folder), recursive)
		result.files.append_array(this_result.files)
		result.folders.append_array(this_result.folders)
	
	return result

## Returns the amount of lines in a file.
static func get_lines_in_file(path: String) -> int:
	if FileAccess.get_size(path) <= 0: return 0
	return FileAccess.get_file_as_string(path).split("\n").size()

## Returns a [Resource]'s file system name. If [param include_extension] is [code]true[/code], includes the file extension.
static func get_resource_filename(resource: Resource, include_extension := false) -> String:
	if include_extension: return resource.resource_path.get_file()
	return resource.resource_path.get_basename().get_file()
#endregion getters


#region methods
## A more robust [method ResourceSaver.save].
##[br][br]Makes sure the folder to [param path] exists.
static func save_resource(resource: Resource, path: String, flags := 0 as ResourceSaver.SaverFlags) -> Error:
	var folder := path.get_base_dir()
	if !DirAccess.dir_exists_absolute(folder):
		DirAccess.make_dir_recursive_absolute(folder)
	
	var result := ResourceSaver.save(resource, path, flags)
	return result
#endregion methods
