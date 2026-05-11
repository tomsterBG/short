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
	assert_eq(fold_button.node, null, "Node is null.")
	assert_ne(fold_button.icon_folded, null, "Folded icon is preloaded.")
	assert_ne(fold_button.icon_unfolded, null, "Unfolded icon is preloaded.")
	assert_eq(fold_button.icon, null, "Icon isn't initialized.")
	assert_eq(fold_button.toggle_mode, false, "Toggle mode is off.") # TODO: Should be true.
	assert_eq(fold_button.button_pressed, false, "Button isn't pressed.")
	assert_eq(control.visible, true, "Control is visible.")

func test_refresh():
	fold_button.refresh()
	assert_eq(fold_button.icon, fold_button.icon_folded, "Icon is now folded.")

func test_set_node():
	fold_button.node = control
	assert_eq(control.visible, false, "Control is invisible.")
	assert_eq(fold_button.icon, fold_button.icon_folded, "Icon is now folded.")

func test_toggle():
	fold_button.button_pressed = true
	assert_eq(fold_button.button_pressed, false, "Button couldn't toggle.")
	fold_button.toggle_mode = true
	fold_button.button_pressed = true
	assert_eq(fold_button.button_pressed, true, "Button is now pressed.")
	assert_eq(fold_button.icon, fold_button.icon_unfolded, "Icon is now unfolded.")

func test_toggle_node():
	fold_button.node = control
	fold_button.toggle_mode = true
	fold_button.button_pressed = true
	assert_eq(control.visible, true, "Control is visible.")
	assert_eq(fold_button.icon, fold_button.icon_unfolded, "Icon is now unfolded.")
	fold_button.button_pressed = false
	assert_eq(control.visible, false, "Control is invisible.")
	assert_eq(fold_button.icon, fold_button.icon_folded, "Icon is now folded.")
#endregion tests
