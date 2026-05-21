extends GutTest


#region tests
func test_safe_connect_and_disconnect():
	var fold_button := FoldButton.new()
	add_child_autofree(fold_button)
	assert_eq(fold_button.pressed.is_connected(fold_button.get_rect), false)
	
	SignalLib.safe_connect(fold_button, &"pressed", fold_button.get_rect)
	assert_eq(fold_button.pressed.is_connected(fold_button.get_rect), true)
	
	SignalLib.safe_connect(fold_button, &"pressed", fold_button.get_rect)
	assert_eq(fold_button.pressed.is_connected(fold_button.get_rect), true)
	
	SignalLib.safe_disconnect(fold_button, &"pressed", fold_button.get_rect)
	assert_eq(fold_button.pressed.is_connected(fold_button.get_rect), false)
	
	SignalLib.safe_disconnect(fold_button, &"pressed", fold_button.get_rect)
	assert_eq(fold_button.pressed.is_connected(fold_button.get_rect), false)

func test_reconnect():
	var fold_button_1 := FoldButton.new()
	var fold_button_2 := FoldButton.new()
	add_child_autofree(fold_button_1)
	add_child_autofree(fold_button_2)
	assert_eq(fold_button_1.pressed.is_connected(fold_button_1.get_rect), false)
	assert_eq(fold_button_2.pressed.is_connected(fold_button_1.get_rect), false)
	
	SignalLib.safe_connect(fold_button_1, &"pressed", fold_button_1.get_rect)
	assert_eq(fold_button_1.pressed.is_connected(fold_button_1.get_rect), true)
	assert_eq(fold_button_2.pressed.is_connected(fold_button_1.get_rect), false)
	
	SignalLib.reconnect(fold_button_1, fold_button_2, &"pressed", fold_button_1.get_rect)
	assert_eq(fold_button_1.pressed.is_connected(fold_button_1.get_rect), false)
	assert_eq(fold_button_2.pressed.is_connected(fold_button_1.get_rect), true)
#endregion tests
