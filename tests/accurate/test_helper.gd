extends GutTest


#region constants
const IS_RECURSIVE = true
const INCLUDES_EXTENSION = true
#endregion constants


#region tests
func test_get_dir_children():
	var dir_children := Helper.get_dir_children("res://")
	assert_false(dir_children.invalid_dir)
	assert_has(dir_children.files, "res://README.md", "Found README.md file.")
	assert_has(dir_children.folders, "res://addons", "Found addons folder.")
	assert_does_not_have(dir_children.files, "res://addons/gut/gut.gd", "Not recursive.")
	dir_children = Helper.get_dir_children("res://", IS_RECURSIVE)
	assert_has(dir_children.files, "res://addons/gut/gut.gd", "Found gut.gd file.")
	dir_children = Helper.get_dir_children("res://tests")
	assert_has(dir_children.folders, "res://tests/files")
	dir_children = Helper.get_dir_children("res://tests/")
	assert_has(dir_children.folders, "res://tests/files", "Supports trailing / on folders.")
	dir_children = Helper.get_dir_children("")
	assert_true(dir_children.folders.is_empty(), "Empty result.")
	assert_true(dir_children.files.is_empty(), "Empty result.")
	dir_children = Helper.get_dir_children("res://non_existent")
	assert_true(dir_children.invalid_dir)

func test_get_resource_filename():
	var resource := ResourceLoader.load("res://tests/files/my capsule shape.tres")
	assert_eq(Helper.get_resource_filename(resource), "my capsule shape", 'Name is "my capsule shape".')
	assert_eq(Helper.get_resource_filename(resource, INCLUDES_EXTENSION), "my capsule shape.tres", 'Name is "my capsule shape.tres".')

func test_save_resource():
	var resource := Resource.new()
	var new_folder := "res://tests/files/new_folder"
	#assert_eq(ResourceSaver.save(resource, "%s/new_resource.tres" % new_folder), ERR_CANT_OPEN) # NOTE: Works, but also pushes a debugger error.
	assert_eq(Helper.save_resource(resource, "%s/new_resource.tres" % new_folder), OK)
	assert_eq(DirAccess.remove_absolute("%s/new_resource.tres" % new_folder), OK)
	assert_eq(DirAccess.remove_absolute(new_folder), OK)
#endregion tests
