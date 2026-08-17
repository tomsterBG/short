extends GutTest


#region variables
var fold_button: FoldButton
var control: Control
#endregion variables


#region virtual
func before_each():
	fold_button = FoldButton.new()
	add_child_autofree(fold_button)
	watch_signals(fold_button)
	control = Control.new()
	add_child_autofree(control)
	watch_signals(control)
#endregion virtual


#region tests
func test_initial_values():
	assert_null(fold_button.node, "Node is null.")
	assert_not_null(fold_button.icon_folded, "Folded icon is preloaded.")
	assert_not_null(fold_button.icon_unfolded, "Unfolded icon is preloaded.")
	assert_eq(fold_button.icon, fold_button.icon_unfolded, "Icon is unfolded.")
	assert_true(fold_button.toggle_mode, "Toggle mode is on.")
	assert_false(fold_button.button_pressed, "Button isn't pressed.")
	assert_true(control.visible, "Control is visible.")

func test_initial_method_values():
	assert_eq(fold_button._get_configuration_warnings().size(), 1, "Node is null.")

func test_refresh():
	fold_button.refresh()
	assert_eq(fold_button.icon, fold_button.icon_unfolded, "Icon is still unfolded.")
	assert_eq(fold_button._get_configuration_warnings().size(), 1, "Node is still null.")

func test_set_node():
	fold_button.node = control
	assert_true(control.visible, "Control is visible.")
	assert_eq(fold_button.icon, fold_button.icon_unfolded, "Icon is still unfolded.")
	assert_eq(fold_button._get_configuration_warnings().size(), 0, "All good.")

func test_toggle():
	fold_button.button_pressed = true
	assert_true(fold_button.button_pressed, "Button is now pressed.")
	assert_eq(fold_button.icon, fold_button.icon_folded, "Icon is now folded.")
	fold_button.toggle_mode = false
	assert_false(fold_button.button_pressed, "Button is now released.")
	assert_eq(fold_button.icon, fold_button.icon_unfolded, "Icon is now unfolded.")
	fold_button.button_pressed = true
	assert_false(fold_button.button_pressed, "Button couldn't toggle.")
	assert_eq(fold_button.icon, fold_button.icon_unfolded, "Icon is still unfolded.")
	fold_button.toggle()
	assert_false(fold_button.button_pressed, "Button couldn't toggle.")
	assert_eq(fold_button.icon, fold_button.icon_unfolded, "Icon is still unfolded.")
	fold_button.toggle_mode = true
	fold_button.toggle()
	assert_true(fold_button.button_pressed, "Button is now pressed.")
	assert_eq(fold_button.icon, fold_button.icon_folded, "Icon is now folded.")

func test_toggle_node():
	fold_button.node = control
	fold_button.toggle_mode = true
	fold_button.button_pressed = true
	assert_false(control.visible, "Control is invisible.")
	assert_eq(fold_button.icon, fold_button.icon_folded, "Icon is now folded.")
	fold_button.button_pressed = false
	assert_true(control.visible, "Control is visible.")
	assert_eq(fold_button.icon, fold_button.icon_unfolded, "Icon is now unfolded.")
#endregion tests
