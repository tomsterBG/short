extends GutTest


#region variables
var button: ShortCheckBox
#endregion variables


#region virtual
func before_each():
	button = ShortCheckBox.new()
	add_child_autofree(button)
#endregion virtual


#region tests
func test_initial_values():
	assert_true(button.toggle_mode, "Toggle mode is true.")
	assert_false(button.button_pressed, "Button isn't pressed.")
	assert_false(button.animation_enabled, "Animation is disabled.")
	assert_null(button.animation_press, "Animation press is null.")
	assert_null(button.animation_unpress, "Animation unpress is null.")
	assert_false(button.animation_reverse_on_toggle_off, "Animation doesn't reverse.")
	assert_false(button.bind_properties_enabled, "Bind properties is disabled.")
	assert_true(button.bind_properties_array.is_empty(), "Bind properties array is empty.")
	assert_false(button.tooltip_enabled, "Tooltip is disabled.")
	assert_false(button.tooltip_format_string.is_empty(), "Tooltip format string isn't empty.")
	assert_false(button.tooltip_properties.is_empty(), "Tooltip properties aren't empty.")

func test__get_tooltip():
	assert_eq(button._get_tooltip(Vector2.ZERO), button.tooltip_text, "Disabled by default.")

func test__toggled():
	button._toggled(true)
	assert_false(button.button_pressed, "Button stays unpressed.")

func test__pressed():
	button._pressed()
	assert_false(button.button_pressed, "Button stays unpressed.")
#endregion tests
