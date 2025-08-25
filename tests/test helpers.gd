# TODO:
# - Ensure correct code formatting.
# - Look at Godot source code to accurately improve the find_child functions.
# - Test large-scale performance on the find_child family of methods in a scene.

extends GutTest


#region constants
var IS_RECURSIVE = true
var IS_OWNED = true
var IS_NAME_READABLE = true
#endregion constants


#region variables
var test_scene: Node
#endregion variables


#region virtual methods
func before_all():
	test_scene = preload("res://tests/scenes/test scene.tscn").instantiate()
	add_child(test_scene, IS_NAME_READABLE)
	test_scene.find_children("*", "CollisionShape2D")[0].owner = null # WARNING: Assumption before tests.

func after_all():
	test_scene.free()
#endregion virtual methods


#region tests
#region test scene
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
#endregion test scene

func test_existence():
	assert_is(Helpers, HelperMethods, "Helpers exists.")

func test_conversions():
	assert_eq(Helpers.sec_to_msec(25), 25_000.0, "Milliseconds is seconds * 1000.")
	assert_eq(Helpers.sec_to_usec(999), 999_000_000.0, "Microseconds is seconds * 1000_000.")
	assert_eq(Helpers.unit_to_percent(1.75), 175.0, "Percentages are units * 100.")
	assert_eq(Helpers.percent_to_unit(0.5), 0.005, "Units are percentages / 100.")

func test_find_children_with_method():
	var characters = Helpers.find_children_with_method(test_scene, "is_on_floor")
	assert_eq(characters.size(), 2, "Found two characters.")
	assert_true(characters[0].is_class("CharacterBody2D"), "The first is CharacterBody2D.")
	assert_true(characters[1].is_class("CharacterBody3D"), "The second is CharacterBody3D.")
	characters = Helpers.find_children_with_method(test_scene, "is_on_floor", !IS_RECURSIVE)
	assert_eq(characters.size(), 0, "Nothing because characters are not children of test_scene.")
	characters = Helpers.find_children_with_method(test_scene, "is_on_floor", IS_RECURSIVE, !IS_OWNED)
	assert_eq(characters.size(), 0, "Nothing because characters are owned.")
	characters = Helpers.find_children_with_method(test_scene, "is_on_floor", !IS_RECURSIVE, !IS_OWNED)
	assert_eq(characters.size(), 0, "Nothing because characters are not children of test_scene.")
	var collisions: Array[Node] = Helpers.find_children_with_method(test_scene, "is_one_way_collision_enabled")
	assert_eq(collisions.size(), 0, "Nothing because is_one_way_collision_enabled is a setter, not a method.")

func test_find_child_with_method():
	var character = Helpers.find_child_with_method(test_scene, "is_on_floor")
	assert_true(character.is_class("CharacterBody2D"), "Found a character.")
	character = Helpers.find_child_with_method(test_scene, "is_on_floor", !IS_RECURSIVE)
	assert_null(character, "Nothing because character is not child of test_scene.")
	character = Helpers.find_child_with_method(test_scene, "is_on_floor", IS_RECURSIVE, !IS_OWNED)
	assert_null(character, "Nothing because character is owned.")
	character = Helpers.find_child_with_method(test_scene, "is_on_floor", !IS_RECURSIVE, !IS_OWNED)
	assert_null(character, "Nothing because character is not child of test_scene.")
	var collision = Helpers.find_child_with_method(test_scene, "is_one_way_collision_enabled")
	assert_null(collision, "Nothing because is_one_way_collision_enabled is a setter, not a method.")

func test_find_children_with_signal():
	var buttons = Helpers.find_children_with_signal(test_scene, "picker_created")
	assert_eq(buttons.size(), 1, "Found a button.")
	assert_true(buttons[0].is_class("ColorPickerButton"), "Of class ColorPickerButton.")
	buttons = Helpers.find_children_with_signal(test_scene, "picker_created", !IS_RECURSIVE)
	assert_eq(buttons.size(), 0, "Nothing because button is not child of test_scene.")
	buttons = Helpers.find_children_with_signal(test_scene, "picker_created", IS_RECURSIVE, !IS_OWNED)
	assert_eq(buttons.size(), 0, "Nothing because button is owned.")
	buttons = Helpers.find_children_with_signal(test_scene, "picker_created", !IS_RECURSIVE, !IS_OWNED)
	assert_eq(buttons.size(), 0, "Nothing because button is not child of test_scene.")

func test_find_child_with_signal():
	var button = Helpers.find_child_with_signal(test_scene, "picker_created")
	assert_true(button.is_class("ColorPickerButton"), "Found a button.")
	button = Helpers.find_child_with_signal(test_scene, "picker_created", !IS_RECURSIVE)
	assert_null(button, "Nothing because button is not child of test_scene.")
	button = Helpers.find_child_with_signal(test_scene, "picker_created", IS_RECURSIVE, !IS_OWNED)
	assert_null(button, "Nothing because button is owned.")
	button = Helpers.find_child_with_signal(test_scene, "picker_created", !IS_RECURSIVE, !IS_OWNED)
	assert_null(button, "Nothing because button is not child of test_scene.")

func test_get_ancestor():
	var nested_four := test_scene.find_child("four fours")
	assert_true(nested_four.is_class("Node"), "Found a node.")
	assert_eq(Helpers.get_ancestor(nested_four, 6), test_scene, "Found node is 6 levels deep.")
	assert_eq(Helpers.get_ancestor(nested_four, 5), test_scene.find_child("tree"), "And 5 levels inside tree.")

func test_performance_of_find():
	var start_time = Time.get_ticks_usec()
	assert_not_null(test_scene.find_child("deepest four"), "Found deepest four.")
	var taken_time: Dictionary
	taken_time.find_child = Time.get_ticks_usec() - start_time
	print("find_child(\"deepest four\") took " + str(taken_time.find_child) + " usec.")
	
	start_time = Time.get_ticks_usec()
	assert_eq(test_scene.find_children("*", "ConfirmationDialog").size(), 1, "Found a ConfirmationDialog.")
	taken_time.find_children = Time.get_ticks_usec() - start_time
	print("find_children(\"*\", \"ConfirmationDialog\") took " + str(taken_time.find_children) + " usec.")
	
	start_time = Time.get_ticks_usec()
	assert_not_null(Helpers.find_child_with_method(test_scene, "get_cancel_button"), "Found a ConfirmationDialog.")
	taken_time.find_child_with_method = Time.get_ticks_usec() - start_time
	print("find_child_with_method(test_scene, \"get_cancel_button\") took " + str(taken_time.find_child_with_method) + " usec.")
	
	start_time = Time.get_ticks_usec()
	assert_eq(Helpers.find_children_with_method(test_scene, "get_cancel_button").size(), 1, "Found a ConfirmationDialog.")
	taken_time.find_children_with_method = Time.get_ticks_usec() - start_time
	print("find_children_with_method(test_scene, \"get_cancel_button\") took " + str(taken_time.find_children_with_method) + " usec.")
#endregion tests
