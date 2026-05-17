extends GutTest


#region constants
const IS_RECURSIVE = true
const INCLUDES_EXTENSION = true
#endregion constants


#region tests
func test_get_dir_children():
	var dir_children := Helper.get_dir_children("res://")
	assert_has(dir_children.files, "res://README.md", "Found README.md file.")
	assert_has(dir_children.folders, "res://addons", "Found addons folder.")
	assert_does_not_have(dir_children.files, "res://addons/gut/gut.gd", "Not recursive.")
	dir_children = Helper.get_dir_children("res://", IS_RECURSIVE)
	assert_has(dir_children.files, "res://addons/gut/gut.gd", "Found gut.gd file.")
	dir_children = Helper.get_dir_children("res://tests")
	assert_has(dir_children.folders, "res://tests/files")

func test_get_lines_in_file():
	var lines := Helper.get_lines_in_file("res://tests/files/123 line script.gd")
	assert_eq(lines, 123, "Lines are 123.")
	lines = Helper.get_lines_in_file("res://tests/files/79 line text.md")
	assert_eq(lines, 79, "Lines are 79.")
	lines = Helper.get_lines_in_file("res://tests/files/empty file.txt")
	assert_eq(lines, 0, "Lines are 0.")

func test_get_resource_filename():
	var resource := ResourceLoader.load("res://tests/files/my capsule shape.tres")
	assert_eq(Helper.get_resource_filename(resource), "my capsule shape", 'Name is "my capsule shape".')
	assert_eq(Helper.get_resource_filename(resource, INCLUDES_EXTENSION), "my capsule shape.tres", 'Name is "my capsule shape.tres".')

func test_is_affirmative():
	assert_true(Helper.is_affirmative("yes"), "Affirmative.")
	assert_true(Helper.is_affirmative("y"), "Affirmative.")
	assert_true(Helper.is_affirmative("true"), "Affirmative.")
	assert_true(Helper.is_affirmative("1"), "Affirmative.")
	
	assert_false(Helper.is_affirmative(""), "Not affirmative.")
	assert_false(Helper.is_affirmative("no"), "Not affirmative.")
	assert_false(Helper.is_affirmative("n"), "Not affirmative.")
	assert_false(Helper.is_affirmative("false"), "Not affirmative.")
	assert_false(Helper.is_affirmative("0"), "Not affirmative.")

func test_is_negative():
	assert_true(Helper.is_negative("n"), "Negative.")
	assert_true(Helper.is_negative("false"), "Negative.")
	assert_true(Helper.is_negative("0"), "Negative.")
	assert_true(Helper.is_negative("no"), "Negative.")
	
	assert_false(Helper.is_negative(""), "Not negative.")
	assert_false(Helper.is_negative("yes"), "Not negative.")
	assert_false(Helper.is_negative("y"), "Not negative.")
	assert_false(Helper.is_negative("true"), "Not negative.")
	assert_false(Helper.is_negative("1"), "Not negative.")

func test_is_binary():
	assert_true(Helper.is_binary("100111011101100"), "A number in binary.")
	assert_false(Helper.is_binary("100O1101O101100"), "Not a number in binary.")
	assert_false(Helper.is_binary(""), "Not a number in binary.")

func test_is_character():
	assert_true(Helper.is_character("7"), "A character.")
	assert_true(Helper.is_character("A"), "A character.")
	assert_true(Helper.is_character("*"), "A character.")
	assert_false(Helper.is_character("923"), "Not a character.")
	assert_false(Helper.is_character("chap"), "Not a character.")
	assert_false(Helper.is_character(""), "Not a character.")

func test_is_digit():
	assert_true(Helper.is_digit("2"), "A digit.")
	assert_false(Helper.is_digit("69"), "Not a digit.")
	assert_false(Helper.is_digit("a"), "Not a digit.")
	assert_false(Helper.is_digit(""), "Not a digit.")

func test_is_letter():
	assert_true(Helper.is_letter("t"), "A letter.")
	assert_false(Helper.is_letter("zag"), "Not a letter.")
	assert_false(Helper.is_letter("8"), "Not a letter.")
	assert_false(Helper.is_letter(""), "Not a letter.")

func test_is_func_definition():
	assert_true(Helper.is_func_definition("func"), "A function.")
	assert_true(Helper.is_func_definition(" func "), "A function.")
	assert_true(Helper.is_func_definition("func my_problem"), "A function.")
	assert_true(Helper.is_func_definition("static func my_problem"), "A function.")
	assert_true(Helper.is_func_definition("@abstract func my_problem"), "A function.")
	assert_false(Helper.is_func_definition("static var"), "Not a function.")
	assert_false(Helper.is_func_definition(""), "Not a function.")

func test_save_resource():
	var resource := Resource.new()
	var new_folder := "res://tests/files/new_folder"
	#assert_eq(ResourceSaver.save(resource, "%s/new_resource.tres" % new_folder), ERR_CANT_OPEN) # NOTE: Works, but also pushes a debugger error.
	assert_eq(Helper.save_resource(resource, "%s/new_resource.tres" % new_folder), OK)
	assert_eq(DirAccess.remove_absolute("%s/new_resource.tres" % new_folder), OK)
	assert_eq(DirAccess.remove_absolute(new_folder), OK)
#endregion tests
