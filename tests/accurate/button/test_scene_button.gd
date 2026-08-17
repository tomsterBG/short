extends GutTest


#region variables
var scene_button: SceneButton
#endregion variables


#region virtual
func before_each():
	scene_button = SceneButton.new()
	add_child_autofree(scene_button)
	watch_signals(scene_button)
#endregion virtual


#region tests
func test_initial_values():
	assert_null(scene_button.scene, "Scene is null.")
	assert_true(scene_button.scene_path.is_empty(), "Scene path is null.")

func test_initial_method_values():
	assert_eq(scene_button._get_configuration_warnings().size(), 1, "Scene is null.")
#endregion tests
