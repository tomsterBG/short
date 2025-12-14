extends GutTest


#region constants
const IS_RECURSIVE = true
const IS_OWNED = true
const IS_NAME_READABLE = true
#endregion constants


#region variables
var test_scene: Node
#endregion variables


#region virtual methods
func before_all():
	test_scene = preload("res://tests/scenes/test_scene.tscn").instantiate()
	add_child(test_scene, IS_NAME_READABLE)
	test_scene.find_children("*", "CollisionShape2D")[0].owner = null # WARNING: Assumption before tests.

func after_all():
	test_scene.free()
#endregion virtual methods


#region tests
	#region test_scene
func test_color_picker_button():
	var buttons: Array[Node] = test_scene.find_children("*", "ColorPickerButton")
	assert_eq(buttons.size(), 1, "Found a ColorPickerButton.")
	assert_not_null(buttons[0].owner, "ColorPickerButton has an owner.")
	assert_ne(buttons[0].get_parent(), test_scene, "ColorPickerButton is not child of test_scene.")

func test_confirmation_dialog():
	var dialog: Array[Node] = test_scene.find_children("*", "ConfirmationDialog")
	assert_eq(dialog.size(), 1, "Found a ConfirmationDialog.")
	assert_not_null(dialog[0].owner, "ConfirmationDialog has an owner.")
	assert_ne(dialog[0].get_parent(), test_scene, "ConfirmationDialog is not child of test_scene.")
	assert_eq(dialog[0].get_parent().name, "deepest four", "Its parent is deepest four.")

func test_character_body_2d():
	var characters: Array[Node] = test_scene.find_children("*", "CharacterBody2D")
	assert_eq(characters.size(), 1, "Found a CharacterBody2D.")
	assert_not_null(characters[0].owner, "CharacterBody2D has an owner.")
	assert_ne(characters[0].get_parent(), test_scene, "CharacterBody2D is not child of test_scene.")

func test_character_body_3d():
	var characters: Array[Node] = test_scene.find_children("*", "CharacterBody3D")
	assert_eq(characters.size(), 1, "Found a CharacterBody3D.")
	assert_not_null(characters[0].owner, "CharacterBody3D has an owner.")
	assert_ne(characters[0].get_parent(), test_scene, "CharacterBody3D is not child of test_scene.")

func test_collision_shape_2d():
	var collisions: Array[Node] = test_scene.find_children("*", "CollisionShape2D")
	assert_eq(collisions.size(), 0, "Nothing because collision is not owned.")
	collisions = test_scene.find_children("*", "CollisionShape2D", IS_RECURSIVE, !IS_OWNED)
	assert_eq(collisions.size(), 1, "Found a CollisionShape2D.")
	assert_null(collisions[0].owner, "CollisionShape2D has no owner.")
	assert_ne(collisions[0].get_parent(), test_scene, "CollisionShape2D is not child of test_scene.")

func test_collision_shape_3d():
	var collisions: Array[Node] = test_scene.find_children("*", "CollisionShape3D")
	assert_eq(collisions.size(), 1, "Found a CollisionShape3D.")
	assert_not_null(collisions[0].owner, "CollisionShape3D has an owner.")
	assert_ne(collisions[0].get_parent(), test_scene, "CollisionShape3D is not child of test_scene.")
	#endregion test_scene

func test_find_children_with_method():
	var characters = Helper.find_children_with_method(test_scene, "is_on_floor")
	assert_eq(characters.size(), 2, "Found two characters.")
	assert_true(characters[0].is_class("CharacterBody2D"), "The first is CharacterBody2D.")
	assert_true(characters[1].is_class("CharacterBody3D"), "The second is CharacterBody3D.")
	characters = Helper.find_children_with_method(test_scene, "is_on_floor", !IS_RECURSIVE)
	assert_eq(characters.size(), 0, "Nothing because characters are not children of test_scene.")
	characters = Helper.find_children_with_method(test_scene, "is_on_floor", IS_RECURSIVE, !IS_OWNED)
	assert_eq(characters.size(), 0, "Nothing because characters are owned.")
	characters = Helper.find_children_with_method(test_scene, "is_on_floor", !IS_RECURSIVE, !IS_OWNED)
	assert_eq(characters.size(), 0, "Nothing because characters are not children of test_scene.")
	var collisions: Array[Node] = Helper.find_children_with_method(test_scene, "is_one_way_collision_enabled")
	assert_eq(collisions.size(), 0, "Nothing because is_one_way_collision_enabled is a setter, not a method.")

func test_find_child_with_method():
	var character = Helper.find_child_with_method(test_scene, "is_on_floor")
	assert_true(character.is_class("CharacterBody2D"), "Found a character.")
	character = Helper.find_child_with_method(test_scene, "is_on_floor", !IS_RECURSIVE)
	assert_null(character, "Nothing because character is not child of test_scene.")
	character = Helper.find_child_with_method(test_scene, "is_on_floor", IS_RECURSIVE, !IS_OWNED)
	assert_null(character, "Nothing because character is owned.")
	character = Helper.find_child_with_method(test_scene, "is_on_floor", !IS_RECURSIVE, !IS_OWNED)
	assert_null(character, "Nothing because character is not child of test_scene.")
	var collision = Helper.find_child_with_method(test_scene, "is_one_way_collision_enabled")
	assert_null(collision, "Nothing because is_one_way_collision_enabled is a setter, not a method.")

func test_find_children_with_signal():
	var buttons = Helper.find_children_with_signal(test_scene, "picker_created")
	assert_eq(buttons.size(), 1, "Found a button.")
	assert_true(buttons[0].is_class("ColorPickerButton"), "Of class ColorPickerButton.")
	buttons = Helper.find_children_with_signal(test_scene, "picker_created", !IS_RECURSIVE)
	assert_eq(buttons.size(), 0, "Nothing because button is not child of test_scene.")
	buttons = Helper.find_children_with_signal(test_scene, "picker_created", IS_RECURSIVE, !IS_OWNED)
	assert_eq(buttons.size(), 0, "Nothing because button is owned.")
	buttons = Helper.find_children_with_signal(test_scene, "picker_created", !IS_RECURSIVE, !IS_OWNED)
	assert_eq(buttons.size(), 0, "Nothing because button is not child of test_scene.")

func test_find_child_with_signal():
	var button = Helper.find_child_with_signal(test_scene, "picker_created")
	assert_true(button.is_class("ColorPickerButton"), "Found a button.")
	button = Helper.find_child_with_signal(test_scene, "picker_created", !IS_RECURSIVE)
	assert_null(button, "Nothing because button is not child of test_scene.")
	button = Helper.find_child_with_signal(test_scene, "picker_created", IS_RECURSIVE, !IS_OWNED)
	assert_null(button, "Nothing because button is owned.")
	button = Helper.find_child_with_signal(test_scene, "picker_created", !IS_RECURSIVE, !IS_OWNED)
	assert_null(button, "Nothing because button is not child of test_scene.")

func test_get_ancestor():
	var nested_four := test_scene.find_child("four fours")
	assert_true(nested_four.is_class("Node"), "Found a node.")
	assert_eq(Helper.get_ancestor(nested_four, 6), test_scene, "Found node is 6 levels deep.")
	assert_eq(Helper.get_ancestor(nested_four, 5), test_scene.find_child("tree"), "And 5 levels inside tree.")

func test_get_dir_children():
	var dir_children := Helper.get_dir_children("res://")
	assert_has(dir_children.files, "res://README.md", "Found README.md file.")
	assert_has(dir_children.folders, "res://addons", "Found addons folder.")
	assert_does_not_have(dir_children.files, "res://tests/test_helper.gd", "Not recursive.")
	dir_children = Helper.get_dir_children("res://", IS_RECURSIVE)
	assert_has(dir_children.files, "res://tests/test_helper.gd", "Found test_helper.gd file.")

func test_get_lines_in_file():
	var lines := Helper.get_lines_in_file("res://tests/files/123 line script.gd")
	assert_eq(lines, 123, "Lines are 123.")
	lines = Helper.get_lines_in_file("res://tests/files/79 line text.md")
	assert_eq(lines, 79, "Lines are 79.")

func test_is_affirmative():
	assert_eq(Helper.is_affirmative("yes"), true, "Affirmative.")
	assert_eq(Helper.is_affirmative("no"), false, "Not affirmative.")
	assert_eq(Helper.is_affirmative("y"), true, "Affirmative.")
	assert_eq(Helper.is_affirmative("n"), false, "Not affirmative.")
	assert_eq(Helper.is_affirmative("true"), true, "Affirmative.")
	assert_eq(Helper.is_affirmative("false"), false, "Not affirmative.")
	assert_eq(Helper.is_affirmative("1"), true, "Affirmative.")
	assert_eq(Helper.is_affirmative("0"), false, "Not affirmative.")

func test_is_negative():
	assert_eq(Helper.is_negative("no"), true, "Negative.")
	assert_eq(Helper.is_negative("yes"), false, "Not negative.")
	assert_eq(Helper.is_negative("n"), true, "Negative.")
	assert_eq(Helper.is_negative("y"), false, "Not negative.")
	assert_eq(Helper.is_negative("false"), true, "Negative.")
	assert_eq(Helper.is_negative("true"), false, "Not negative.")
	assert_eq(Helper.is_negative("0"), true, "Negative.")
	assert_eq(Helper.is_negative("1"), false, "Not negative.")

func test_is_binary():
	assert_eq(Helper.is_binary("100111011101100"), true, "A number in binary.")
	assert_eq(Helper.is_binary("100O1101O101100"), false, "Not a number in binary.")

func test_is_character():
	assert_eq(Helper.is_character("923"), false, "Not a character.")
	assert_eq(Helper.is_character("chap"), false, "Not a character.")
	assert_eq(Helper.is_character("7"), true, "A character.")
	assert_eq(Helper.is_character("A"), true, "A character.")
	assert_eq(Helper.is_character("*"), true, "A character.")

func test_is_digit():
	assert_eq(Helper.is_digit("a"), false, "Not a digit.")
	assert_eq(Helper.is_digit("2"), true, "A digit.")
	assert_eq(Helper.is_digit("69"), false, "Not a character.")

func test_is_letter():
	assert_eq(Helper.is_letter("8"), false, "Not a letter.")
	assert_eq(Helper.is_letter("t"), true, "A letter.")
	assert_eq(Helper.is_letter("zag"), false, "Not a character.")

	#region performance
func test_performance_of_find():
	var start_time = Time.get_ticks_usec()
	assert_not_null(test_scene.find_child("deepest four"), "Found deepest four.")
	var taken_time: Dictionary
	taken_time.find_child = Time.get_ticks_usec() - start_time
	gut.logger.info("find_child(\"deepest four\") took " + str(taken_time.find_child) + " usec.")
	
	start_time = Time.get_ticks_usec()
	assert_eq(test_scene.find_children("*", "ConfirmationDialog").size(), 1, "Found a ConfirmationDialog.")
	taken_time.find_children = Time.get_ticks_usec() - start_time
	gut.logger.info("find_children(\"*\", \"ConfirmationDialog\") took " + str(taken_time.find_children) + " usec.")
	
	start_time = Time.get_ticks_usec()
	assert_not_null(Helper.find_child_with_method(test_scene, "get_cancel_button"), "Found a ConfirmationDialog.")
	taken_time.find_child_with_method = Time.get_ticks_usec() - start_time
	gut.logger.info("find_child_with_method(test_scene, \"get_cancel_button\") took " + str(taken_time.find_child_with_method) + " usec.")
	
	start_time = Time.get_ticks_usec()
	assert_eq(Helper.find_children_with_method(test_scene, "get_cancel_button").size(), 1, "Found a ConfirmationDialog.")
	taken_time.find_children_with_method = Time.get_ticks_usec() - start_time
	gut.logger.info("find_children_with_method(test_scene, \"get_cancel_button\") took " + str(taken_time.find_children_with_method) + " usec.")
	#endregion performance
#endregion tests
