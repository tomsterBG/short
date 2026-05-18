# TODO:
# - is_inner_class_definition(line: String) -> bool: the class inside a class_name
#
# - is_onready_var(line: String) -> bool
# - get_export_var_type(line: String) -> String
# - is_tool_script(source: String) -> bool
# - get_annotation(line: String) -> String
# - has_annotation(line: String, annotation: String) -> bool: check for @tool, @experimental, @abstract
#
# - is_inside_comment(source: String, index: int) -> bool:
#
# - get_function_params(source: String) -> PackedStringArray
#
# - is_script_skeleton(source: String) -> bool: does this script have logic/data?
#
# - rebase_path(path, old_base, new_base) - res://docs/README.md -> user://data/README.md
# - is_valid_res_path(path: String) -> bool
#
# - wrap_text(text: String, line_length: int) - adds \n every line_length symbols from the start of a line
# IDEAS:
# - get_script_meat_ratio(source: String) -> float: how much of the source code is actual logic?
# - Optimize the ordering of (line.contains("var") or line.contains("func") or line.contains("signal") or line.contains("const")) with data. Run a script that says "Definitions: var - x, func - x, signal - x, const - x"

## @experimental: This class could change.
## Work with strings.
##
## Available in all scripts without any setup.

@abstract class_name StringLib extends Object


#region constants
const ALLOW_EMPTY := true
#endregion constants


#region getters
## Returns the name of the class defined in this GDScript source.
static func get_class_name(source: String) -> StringName:
	for line in source.split("\n"):
		if line.contains("class_name "):
			var tokens := line.split(" ", !ALLOW_EMPTY)
			var idx := tokens.find("class_name")
			return tokens[idx + 1]
		elif (line.contains("var") or line.contains("func")
		or line.contains("signal") or line.contains("const") or line.contains("class ")):
			return &""
	return &""

## Returns the name of the base class this GDScript extends.
static func get_base_class(source: String) -> StringName:
	for line in source.split("\n"):
		if line.contains("extends "):
			var tokens := line.split(" ", !ALLOW_EMPTY)
			var idx := tokens.find("extends")
			return tokens[idx + 1]
		elif (line.contains("var") or line.contains("func")
		or line.contains("signal") or line.contains("const") or line.contains("class ")):
			return &""
	return &""

## Returns the number of leading tabs in a line.
static func get_indent_level(line: String) -> int:
	var count := 0
	for i in range(line.length()):
		if line[i] == "\t": count += 1
		else: break
	return count

## Returns the name of a GDScript region from a region start line.
static func get_region_name(line: String) -> String:
	if is_region_start(line):
		return line.strip_edges().trim_prefix("#region").strip_edges()
	elif is_region_end(line):
		return line.strip_edges().trim_prefix("#endregion").strip_edges()
	return ""

# TODO: Make this more parametrized for customizability.
## Extracts info from a TODO comment.
static func get_todo_info(line: String) -> String:
	var stripped_comments := strip_comments(line)
	if line == stripped_comments: return ""
	
	var comment := line.trim_prefix(stripped_comments)
	for prefix: String in ["# TODO:", "# TODO"]:
		if comment.begins_with(prefix):
			return comment.trim_prefix(prefix).strip_edges()
	return ""

## Converts an absolute system path to a project-relative "res://" path.
static func get_project_relative_path(path: String) -> String:
	var res_path := ProjectSettings.globalize_path("res://")
	if path.begins_with(res_path):
		return path.replace(res_path, "res://").replace("\\", "/")
	return path

## Returns the amount of lines in a file.
static func get_lines_in_file(path: String) -> int:
	if FileAccess.get_size(path) <= 0: return 0
	return FileAccess.get_file_as_string(path).split("\n").size()

## Returns the line number corresponding to a character offset in a string.
##[br][br]The "\n" character is considered to be on the same line.
static func get_line_at_offset(string: String, offset: int) -> int:
	var count := 1
	for i in range(min(offset, string.length())):
		if string[i] == "\n": count += 1
	return count
#endregion getters


#region methods
	#region is_
## Returns [code]true[/code] if the given string is affirmative. Can customize what is considered affirmative with [param keywords].
##[br][br][b]Note:[/b] An affirmative string is [code]"yes", "y", "true", "1"[/code].
static func is_affirmative(string: String, keywords: Array[String] = []) -> bool:
	if !keywords.is_empty(): return keywords.has(string)
	return ["yes", "y", "true", "1"].has(string)

## Returns [code]true[/code] if the given string is negative. Can customize what is considered negative with [param keywords].
##[br][br][b]Note:[/b] A negative string is [code]"no", "n", "false", "0"[/code].
static func is_negative(string: String, keywords: Array[String] = []) -> bool:
	if !keywords.is_empty(): return keywords.has(string)
	return ["no", "n", "false", "0"].has(string)

## Returns [code]true[/code] if the given string is a number in binary.
static func is_binary(binary: String) -> bool:
	if binary.is_empty(): return false
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

		#region definition
## Returns [code]true[/code] if the given line is a GDScript function definition. 
static func is_func_definition(line: String) -> bool:
	var stripped := line.strip_edges()
	if (stripped.begins_with("func ")
	or stripped.begins_with("static func ")
	or stripped.begins_with("@abstract func ")): return true
	return false

## Returns [code]true[/code] if the line is a GDScript variable definition.
static func is_var_definition(line: String) -> bool:
	var stripped := line.strip_edges()
	return (stripped.begins_with("var ") or stripped.begins_with("@export var ")
	or stripped.begins_with("@onready var "))

## Returns [code]true[/code] if the line is a GDScript signal definition.
static func is_signal_definition(line: String) -> bool:
	return line.strip_edges().begins_with("signal ")
		#endregion definition

		#region region
## Returns [code]true[/code] if the line starts a GDScript region.
static func is_region_start(line: String) -> bool:
	return line.strip_edges().begins_with("#region")

## Returns [code]true[/code] if the line ends a GDScript region.
static func is_region_end(line: String) -> bool:
	return line.strip_edges().begins_with("#endregion")
		#endregion region

## Returns [code]true[/code] if the [param index] in [param source] is currently inside a GDScript string literal.
static func is_inside_string(source: String, index: int) -> bool:
	var inside_double := false
	var inside_single := false
	for i in range(min(index, source.length())):
		var c := source[i]
		if c == '"' and !inside_single: inside_double = !inside_double
		elif c == "'" and !inside_double: inside_single = !inside_single
	return inside_double or inside_single
	#endregion is_

## Returns the line with GDScript comments removed. Knows to ignore comments inside strings.
static func strip_comments(line: String) -> String:
	var hash_pos := line.find("#")
	while hash_pos != -1:
		if is_inside_string(line, hash_pos):
			hash_pos = line.find("#", hash_pos + 1)
			continue
		return line.substr(0, hash_pos)
	return line
#endregion methods
