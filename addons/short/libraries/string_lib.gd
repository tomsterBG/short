# TODO:

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
