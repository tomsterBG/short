extends GutTest


#region tests
func test_bind():
	var fold_button := FoldButton.new()
	var control := Control.new()
	add_child_autofree(fold_button)
	add_child_autofree(control)
	
	var context := BindLib.BindContext.new(fold_button, &"button_pressed", control, &"visible", &"pressed")
	assert_eq(fold_button.button_pressed, false)
	assert_eq(control.visible, true)
	
	BindLib.bind(context)
	assert_eq(fold_button.button_pressed, false)
	assert_eq(control.visible, false)
	
	fold_button.toggle()
	assert_eq(fold_button.button_pressed, true)
	assert_eq(control.visible, false)
	
	fold_button.pressed.emit()
	assert_eq(fold_button.button_pressed, true)
	assert_eq(control.visible, true)
	
	for connection in fold_button.pressed.get_connections():
		fold_button.pressed.disconnect(connection.callable)
	
	fold_button.toggle()
	fold_button.pressed.emit()
	assert_eq(fold_button.button_pressed, false)
	assert_eq(control.visible, true)
	
	context.source_signal = &"toggled"
	context.bind_mode = BindLib.BindContext.BindMode.SIGNAL_ARG_1_IS_VALUE
	BindLib.bind(context)
	assert_eq(fold_button.button_pressed, false)
	assert_eq(control.visible, false)
	
	fold_button.toggle()
	assert_eq(fold_button.button_pressed, true)
	assert_eq(control.visible, true)
	
	fold_button.toggle()
	assert_eq(fold_button.button_pressed, false)
	assert_eq(control.visible, false)
#endregion tests
