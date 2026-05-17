extends GutTest


#region tests
	#region getters
func test_get_class_name():
	assert_eq(StringLib.get_class_name(""), "")
	assert_eq(StringLib.get_class_name("var my_var\nclass_name StringLib"), "")
	assert_eq(StringLib.get_class_name("func my_var\nclass_name StringLib"), "")
	assert_eq(StringLib.get_class_name("class my_var\nclass_name StringLib"), "")
	assert_eq(StringLib.get_class_name("const my_var\nclass_name StringLib"), "")
	assert_eq(StringLib.get_class_name("signal my_var\nclass_name StringLib"), "")
	assert_eq(StringLib.get_class_name("class_name StringLib extends Object"), "StringLib")
	assert_eq(StringLib.get_class_name("@abstract class_name StringLib extends Object"), "StringLib")

func test_get_base_class():
	assert_eq(StringLib.get_base_class(""), "")
	assert_eq(StringLib.get_base_class("extends Object"), "Object")
	assert_eq(StringLib.get_class_name("var my_var\nextends Object"), "")
	assert_eq(StringLib.get_class_name("func my_var\nextends Object"), "")
	assert_eq(StringLib.get_class_name("class my_var\nextends Object"), "")
	assert_eq(StringLib.get_class_name("const my_var\nextends Object"), "")
	assert_eq(StringLib.get_class_name("signal my_var\nextends Object"), "")
	assert_eq(StringLib.get_base_class("class_name StringLib extends Object"), "Object")
	assert_eq(StringLib.get_base_class("@abstract class_name StringLib extends Object"), "Object")

func test_get_indent_level():
	assert_eq(StringLib.get_indent_level(""), 0)
	assert_eq(StringLib.get_indent_level(" "), 0)
	assert_eq(StringLib.get_indent_level("	"), 1)
	assert_eq(StringLib.get_indent_level(" 	 	"), 0)
	assert_eq(StringLib.get_indent_level("		"), 2)
	assert_eq(StringLib.get_indent_level("	 	 	"), 1)
	assert_eq(StringLib.get_indent_level("			"), 3)

func test_get_region_name():
	assert_eq(StringLib.get_region_name(""), "")
	assert_eq(StringLib.get_region_name("tags"), "")
	assert_eq(StringLib.get_region_name("# region Tags"), "")
	assert_eq(StringLib.get_region_name("# endregion WHY"), "")
	assert_eq(StringLib.get_region_name("#region tags"), "tags")
	assert_eq(StringLib.get_region_name("#region Tags"), "Tags")
	assert_eq(StringLib.get_region_name("#endregion WHY"), "WHY")

func test_get_todo_info():
	assert_eq(StringLib.get_todo_info(""), "")
	assert_eq(StringLib.get_todo_info("TODO Hello world!"), "")
	assert_eq(StringLib.get_todo_info("#TODO Hello world!"), "")
	assert_eq(StringLib.get_todo_info("# TODO Hello world!"), "Hello world!")
	assert_eq(StringLib.get_todo_info("# TODO: Hello world!"), "Hello world!")
	assert_eq(StringLib.get_todo_info(" 	 # TODO: Hello world!"), "Hello world!")
	assert_eq(StringLib.get_todo_info("func my_func(): # TODO: rename this"), "rename this")
	assert_eq(StringLib.get_todo_info(" 	 func my_func(): # TODO: rename this"), "rename this")
	assert_eq(StringLib.get_todo_info("func my_func() -> void: # TODO: rename this"), "rename this")

func test_get_project_relative_path():
	assert_eq(StringLib.get_project_relative_path(""), "")
	assert_eq(StringLib.get_project_relative_path(ProjectSettings.globalize_path("res://tests/files")), "res://tests/files")

func test_get_line_at_offset():
	assert_eq(StringLib.get_line_at_offset("", 0), 1)
	assert_eq(StringLib.get_line_at_offset("string", 999), 1)
	assert_eq(StringLib.get_line_at_offset("string\ntwo", 999), 2)
	assert_eq(StringLib.get_line_at_offset("string\n\nthree", 6), 1)
	assert_eq(StringLib.get_line_at_offset("string\n\nthree", 7), 2)
	assert_eq(StringLib.get_line_at_offset("string\n\nthree", 8), 3)
	#endregion getters

	#region is_
func test_is_affirmative():
	assert_true(StringLib.is_affirmative("yes"), "Affirmative.")
	assert_true(StringLib.is_affirmative("y"), "Affirmative.")
	assert_true(StringLib.is_affirmative("true"), "Affirmative.")
	assert_true(StringLib.is_affirmative("1"), "Affirmative.")
	
	assert_false(StringLib.is_affirmative(""), "Not affirmative.")
	assert_false(StringLib.is_affirmative("no"), "Not affirmative.")
	assert_false(StringLib.is_affirmative("n"), "Not affirmative.")
	assert_false(StringLib.is_affirmative("false"), "Not affirmative.")
	assert_false(StringLib.is_affirmative("0"), "Not affirmative.")

func test_is_negative():
	assert_true(StringLib.is_negative("n"), "Negative.")
	assert_true(StringLib.is_negative("false"), "Negative.")
	assert_true(StringLib.is_negative("0"), "Negative.")
	assert_true(StringLib.is_negative("no"), "Negative.")
	
	assert_false(StringLib.is_negative(""), "Not negative.")
	assert_false(StringLib.is_negative("yes"), "Not negative.")
	assert_false(StringLib.is_negative("y"), "Not negative.")
	assert_false(StringLib.is_negative("true"), "Not negative.")
	assert_false(StringLib.is_negative("1"), "Not negative.")

func test_is_binary():
	assert_true(StringLib.is_binary("100111011101100"), "A number in binary.")
	assert_false(StringLib.is_binary("100O1101O101100"), "Not a number in binary.")
	assert_false(StringLib.is_binary(""), "Not a number in binary.")

func test_is_character():
	assert_true(StringLib.is_character("7"), "A character.")
	assert_true(StringLib.is_character("A"), "A character.")
	assert_true(StringLib.is_character("*"), "A character.")
	assert_false(StringLib.is_character("923"), "Not a character.")
	assert_false(StringLib.is_character("chap"), "Not a character.")
	assert_false(StringLib.is_character(""), "Not a character.")

func test_is_digit():
	assert_true(StringLib.is_digit("2"), "A digit.")
	assert_false(StringLib.is_digit("69"), "Not a digit.")
	assert_false(StringLib.is_digit("a"), "Not a digit.")
	assert_false(StringLib.is_digit(""), "Not a digit.")

func test_is_letter():
	assert_true(StringLib.is_letter("t"), "A letter.")
	assert_false(StringLib.is_letter("zag"), "Not a letter.")
	assert_false(StringLib.is_letter("8"), "Not a letter.")
	assert_false(StringLib.is_letter(""), "Not a letter.")

func test_is_func_definition():
	assert_true(StringLib.is_func_definition(" func hello"), "A function.")
	assert_true(StringLib.is_func_definition("func my_problem"), "A function.")
	assert_true(StringLib.is_func_definition("static func my_problem"), "A function.")
	assert_true(StringLib.is_func_definition("@abstract func my_problem"), "A function.")
	assert_false(StringLib.is_func_definition("static func "), "Not a function.")
	assert_false(StringLib.is_func_definition("static var"), "Not a function.")
	assert_false(StringLib.is_func_definition(" func "), "Not a function.")
	assert_false(StringLib.is_func_definition("func"), "Not a function.")
	assert_false(StringLib.is_func_definition(""), "Not a function.")

func test_is_var_definition():
	assert_true(StringLib.is_var_definition("var hello"), "A variable.")
	assert_true(StringLib.is_var_definition(" var world"), "A variable.")
	assert_true(StringLib.is_var_definition("@export var hello"), "A variable.")
	assert_true(StringLib.is_var_definition("@onready var ready"), "A variable.")
	assert_true(StringLib.is_var_definition(" 	 var weird_tabs"), "A variable.")
	assert_false(StringLib.is_var_definition(" var "), "Not a variable.")
	assert_false(StringLib.is_var_definition("var"), "Not a variable.")
	assert_false(StringLib.is_var_definition(""), "Not a variable.")

func test_is_signal_definition():
	assert_true(StringLib.is_signal_definition("signal peed"), "A signal.")
	assert_true(StringLib.is_signal_definition(" 	 signal weird_tabs"), "A signal.")
	assert_false(StringLib.is_signal_definition(" 	 signal "), "Not a signal.")
	assert_false(StringLib.is_signal_definition(" signal "), "Not a signal.")
	assert_false(StringLib.is_signal_definition("signal"), "Not a signal.")
	assert_false(StringLib.is_signal_definition(""), "Not a signal.")

func test_is_region_start():
	assert_true(StringLib.is_region_start("#region"), "A #region.")
	assert_true(StringLib.is_region_start("	#region"), "A #region.")
	assert_true(StringLib.is_region_start("#region hello"), "A #region.")
	assert_false(StringLib.is_region_start("# region"), "Not a #region.")
	assert_false(StringLib.is_region_start(""), "Not a #region.")

func test_is_region_end():
	assert_true(StringLib.is_region_end("#endregion"), "An #endregion.")
	assert_true(StringLib.is_region_end("	#endregion"), "An #endregion.")
	assert_true(StringLib.is_region_end("#endregion bye"), "An #endregion.")
	assert_false(StringLib.is_region_end("# endregion"), "Not an #endregion.")
	assert_false(StringLib.is_region_end(""), "Not an #endregion.")

func test_is_inside_string():
	assert_true(StringLib.is_inside_string('var my := "Stringyyyyyy"', 11), "Inside a string.")
	assert_false(StringLib.is_inside_string('var my := "Stringyyyyyy"', 10), "Not inside a string.")
	assert_false(StringLib.is_inside_string(' ', 0), "Not inside a string.")
	#endregion is_

func test_strip_comments():
	assert_eq(StringLib.strip_comments("#var my_var"), "")
	assert_eq(StringLib.strip_comments("var #my_var"), "var ")
	assert_eq(StringLib.strip_comments("var my#_var"), "var my")
	assert_eq(StringLib.strip_comments("var my_var"), "var my_var")
	assert_eq(StringLib.strip_comments('var my_var = "#"'), 'var my_var = "#"')
	assert_eq(StringLib.strip_comments("var my_var = '#'"), "var my_var = '#'")
#endregion tests
