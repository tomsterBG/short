# TODO:
# - is_inner_class_definition(line: String) -> bool: the class inside a class_name
#
# - is_onready_var(line: String) -> bool
# - get_export_var_type(line: String) -> String
# - is_tool_script(source: String) -> bool
# - get_annotation(line: String) -> String
# - has_annotation(line: String, annotation: String) -> bool: check for @tool, @experimental, @abstract
#
# - get_func_name
#
# - get_function_params(source: String) -> PackedStringArray
#
# - is_script_skeleton(source: String) -> bool: does this script have logic/data?
#
# - rebase_path(path, old_base, new_base) - res://docs/README.md -> user://data/README.md
# - is_valid_res_path(path: String) -> bool
#
# - wrap_text(text: String, line_length: int) - adds \n every line_length symbols from the start of a line
#
# - fuzzy_score(string_a, string_b) -> float
# IDEAS:
# - get_script_logic_ratio(source: String) -> float: how much of the source code is actual logic?
# - Optimize the ordering of (line.contains("var") or line.contains("func") or line.contains("signal") or line.contains("const")) with data. Run a script that says "Definitions: var - x, func - x, signal - x, const - x"
# BAD IDEAS:
# - Existing:
# 	- String: to_snake_case, to_pascal_case, to_camel_case, to_kebab_case

## @experimental: This class could change.
## Work with strings.
##
## Available in all scripts without any setup.
##[br][br][b]Note:[/b] For conversion from binary or hex use [method String.bin_to_int] or [method String.hex_to_int].

@abstract class_name StringLib extends Object


#region constants
## Usually used for [method String.split]'s [param allow_empty] parameter.
const ALLOW_EMPTY := true
#endregion constants


#region getters
## Returns the [code]class_name[/code] defined in this GDScript source. Ignores comments and strings.
static func get_class_name(source: String) -> StringName:
	for line in source.split("\n"):
		var stripped := strip_strings(strip_comment(line)).strip_edges()
		if stripped.is_empty(): continue
		
		# NOTE: class_name isn't allowed after these keywords.
		if is_func_definition(line) or is_var_definition(line) or is_signal_definition(line) or stripped.begins_with("const ") or stripped.begins_with("class "):
			return &""
		
		if stripped.contains("class_name "):
			var tokens := stripped.split(" ", false)
			var idx := tokens.find("class_name")
			if idx != -1 and idx + 1 < tokens.size():
				return StringName(tokens[idx + 1])
	return &""

## Returns the base class name this GDScript [code]extends[/code]. Ignores comments and strings.
static func get_base_class(source: String) -> StringName:
	for line in source.split("\n"):
		var stripped := strip_strings(strip_comment(line)).strip_edges()
		if stripped.is_empty(): continue
		
		# NOTE: extends isn't allowed after these keywords.
		if is_func_definition(line) or is_var_definition(line) or is_signal_definition(line) or stripped.begins_with("const ") or stripped.begins_with("class "):
			return &""
		
		if stripped.contains("extends "):
			var tokens := stripped.split(" ", false)
			var idx := tokens.find("extends")
			if idx != -1 and idx + 1 < tokens.size():
				return StringName(tokens[idx + 1])
	return &""

## Returns all classes referenced in this GDScript with reference count. Ignores comments and strings.
static func get_referenced_classes(source: String) -> Dictionary[StringName, int]:
	var classes: Dictionary[StringName, int] = {}
	var stripped := ""
	for line in source.split("\n"):
		stripped += strip_strings(strip_comment(line)).strip_edges()
	# NOTE: A PascalCase word boundary regex.
	var regex := RegEx.create_from_string("\\b[A-Z]\\w*\\b")
	for regex_match in regex.search_all(stripped):
		if !classes.has(regex_match.get_string()):
			classes[regex_match.get_string()] = 1
		else:
			classes[regex_match.get_string()] += 1
	return classes

## Returns the number of leading tabs in a line.
static func get_indent_level(line: String) -> int:
	var count := 0
	for i in range(line.length()):
		if line[i] == "\t": count += 1
		else: break
	return count

## Returns the GDScript comment on this line, including the "#". Returns "" if there is no comment.
static func get_comment(line: String) -> String:
	var hash_pos := line.find("#")
	while hash_pos != -1:
		if is_inside_string(line, hash_pos):
			hash_pos = line.find("#", hash_pos + 1)
			continue
		return line.substr(hash_pos)
	return ""

## Returns the name of a GDScript region from a region start line.
static func get_region_name(line: String) -> String:
	if is_region_start(line):
		return line.strip_edges().trim_prefix("#region").strip_edges()
	elif is_region_end(line):
		return line.strip_edges().trim_prefix("#endregion").strip_edges()
	return ""

## Extracts info from a TODO comment.
static func get_todo_info(line: String, prefixes: Array[String] = ["# TODO:", "# TODO"]) -> String:
	var comment := get_comment(line)
	if comment.is_empty(): return ""
	
	for prefix: String in prefixes:
		if comment.begins_with(prefix):
			return comment.trim_prefix(prefix).strip_edges()
	return ""

## Converts an absolute system path to a project-relative "res://" path.
static func get_project_relative_path(absolute_path: String) -> String:
	var res_path := ProjectSettings.globalize_path("res://")
	if absolute_path.begins_with(res_path):
		return absolute_path.replace(res_path, "res://").replace("\\", "/")
	return absolute_path

## Returns the amount of lines in a file.
static func get_lines_in_file(path: String, allow_empty := true) -> int:
	if FileAccess.get_size(path) <= 0: return 0
	return FileAccess.get_file_as_string(path).split("\n", allow_empty).size()

## Returns the line number corresponding to a character offset in a string.
##[br][br]The "\n" character is considered to be on the same line.
static func get_line_at_offset(string: String, offset: int) -> int:
	# NOTE: The + 1 comes from converting offset from an index starting at 0, to a length starting at 1.
	offset = mini(len(string) - 1, offset) + 1
	var lines := string.split("\n")
	var line_num := 1
	for line in lines:
		# NOTE: The + 1 comes from String.split stripping the delimiter.
		offset -= len(line) + 1
		if offset <= 0: return line_num
		line_num += 1
	return line_num

## Returns the function name found in this [param line].
static func get_function_name(line: String) -> String:
	if !is_func_definition(line): return ""
	var stripped := line.strip_edges().trim_prefix("@abstract")
	stripped = stripped.strip_edges().trim_prefix("static")
	stripped = stripped.strip_edges().trim_prefix("func").strip_edges()
	return stripped.substr(0, stripped.find("(")).strip_edges()

## Returns all functions by name in the given [param source].
static func get_function_names(source: String) -> PackedStringArray:
	var result: PackedStringArray = []
	for line in source.split("\n", !ALLOW_EMPTY):
		if !is_func_definition(line): continue
		result.append(get_function_name(line))
	return result
#endregion getters


#region methods
	#region is_
## Returns [code]true[/code] if the given string is affirmative. Can customize what is considered affirmative with [param keywords].
##[br][br][b]Note:[/b] An affirmative string is [code]"yes", "y", "true", "1"[/code].
static func is_affirmative(string: String, keywords: Array[String] = ["yes", "y", "true", "1"]) -> bool:
	return keywords.has(string)

## Returns [code]true[/code] if the given string is negative. Can customize what is considered negative with [param keywords].
##[br][br][b]Note:[/b] A negative string is [code]"no", "n", "false", "0"[/code].
static func is_negative(string: String, keywords: Array[String] = ["no", "n", "false", "0"]) -> bool:
	return keywords.has(string)

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
## Returns [code]true[/code] if the given line is a GDScript function definition. Ignores comments and strings.
static func is_func_definition(line: String) -> bool:
	var tokens := strip_strings(strip_comment(line.strip_edges())).split(" ", !ALLOW_EMPTY)
	if (tokens.has("func")
	or (tokens.has("static") and tokens.has("func"))
	or (tokens.has("@abstract") and tokens.has("func"))): return true
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

## Returns [code]true[/code] if the [param index] in [param source] is currently inside a GDScript string.
static func is_inside_string(source: String, index: int) -> bool:
	if index < 0 or index >= source.length(): return false
	
	var quote_type: String = ""
	var escaped := false
	
	for i in range(index + 1):
		var c := source[i]
		if escaped: escaped = false; continue
		if c == "\\": escaped = true; continue
		
		if quote_type != "":
			if c == quote_type:
				if i == index: return true # NOTE: Still inside at the closing quote
				quote_type = ""
		elif c == '"' or c == "'":
			quote_type = c
		
		if i == index:
			return quote_type != ""
	
	return false

## Returns [code]true[/code] if the [param index] in [param source] is currently inside a GDScript comment.
static func is_inside_comment(source: String, index: int) -> bool:
	if index < 0 or index >= source.length(): return false
	
	var hash_pos := source.find("#")
	while hash_pos != -1:
		if hash_pos > index: break
		if !is_inside_string(source, hash_pos):
			var line_end := source.find("\n", hash_pos)
			if line_end == -1 or line_end >= index:
				return true
			hash_pos = source.find("#", line_end)
		else:
			hash_pos = source.find("#", hash_pos + 1)
	return false

## Returns [code]true[/code] if the [param action_name] is part of the [InputMap] of this project.
static func is_valid_action(action_name: StringName) -> bool:
	return action_name in InputMap.get_actions()
	#endregion is_

## Returns the line with GDScript comment removed. Ignores comment inside strings.
static func strip_comment(line: String) -> String:
	var hash_pos := line.find("#")
	while hash_pos != -1:
		if !is_inside_string(line, hash_pos):
			return line.substr(0, hash_pos)
		hash_pos = line.find("#", hash_pos + 1)
	return line

## Returns the line with GDScript strings removed. Ignores strings inside comments.
static func strip_strings(line: String) -> String:
	var result := ""
	var inside_quote := ""
	var escaped := false
	
	for i in range(line.length()):
		var c := line[i]
		if escaped: escaped = false; continue
		if c == "\\": escaped = true; result += c; continue
			
		if inside_quote != "":
			if c == inside_quote:
				inside_quote = ""
		elif (c == '"' or c == "'") and !is_inside_comment(line, i):
			inside_quote = c
		elif inside_quote == "":
			result += c
			
	return result
#endregion methods
