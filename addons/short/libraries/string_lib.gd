# TODO:
# - get_class_name(source: String) -> StringName
# - get_base_class(source: String) -> StringName
# - get_indent_level(line: String) -> int
# - strip_comments(line: String) -> String
#
# - is_var_definition(line: String) -> bool
# - is_onready_var(line: String) -> bool
# - is_signal_definition(line: String) -> bool
# - is_inner_class_definition(line: String) -> bool: the class inside a class_name
#
# - is_region_start(line: String) -> bool
# - is_region_end(line: String) -> bool
# - get_region_name(line: String) -> String
#
# - is_tool_script(source: String) -> bool
# - get_todo_info(line: String) -> String
# - is_inside_string(source: String, index: int) -> bool: is index inside a string definition?
#
# - get_function_params(source: String) -> PackedStringArray
# - has_annotation(line: String, annotation: String) -> bool: check for @tool, @experimental, @abstract
# - get_export_var_type(line: String) -> String
# - get_line_at_offset(source: String, offset: int) -> int
# - is_script_skeleton(source: String) -> bool: does this script have logic/data?
#
# - get_project_relative_path(path: String) -> String: C:/Users/.../project/res://ui/view.gd to res://ui/view.gd
# - rebase_path(path, old_base, new_base) - res://docs/README.md -> user://data/README.md
# - wrap_text(text: String, line_length: int) - adds \n every line_length symbols from the start of a line
# - is_valid_res_path(path: String) -> bool
# IDEAS:
# - get_script_meat_ratio(source: String) -> float: how much of the source code is actual logic?

## @experimental: This class could change.
## Work with strings.
##
## Available in all scripts without any setup.

@abstract class_name StringLib extends Object


#region methods
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

## Returns [code]true[/code] if the given line is a GDScript function definition. 
static func is_func_definition(line: String) -> bool:
	var stripped := line.strip_edges()
	if (stripped.begins_with("func")
	or stripped.begins_with("static func")
	or stripped.begins_with("@abstract func")): return true
	return false
	#endregion is_
#endregion methods
