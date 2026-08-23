# NOTE:
# Not yet passed through class quality checklist.
# IDEAS:

## @experimental: This class could change.
## A [Button] with extra functionality.
##
##[br][br][b]Note:[/b] This assumes that the [ArrayLib] and [PropertyBinding] classes exist.

@tool
class_name ShortButton extends Button


#region variables
@export_group("Bind Animations", "animation_")
## If true, enables playing animations when [method BaseButton._pressed] is called.
@export_custom(PROPERTY_HINT_GROUP_ENABLE, "") var animation_enabled: bool = false
## Animation to play when the button is pressed.
@export var animation_press: AnimationBinding
## Animation to play when the button is un-pressed. Only works if [member BaseButton.toggle_mode] is [code]true[/code].
@export var animation_unpress: AnimationBinding
## When [code]true[/code] and [member animation_unpress] would be played, [member animation_press] is played in reverse instead.
@export var animation_reverse_on_toggle_off: bool = false

@export_group("Bind Properties", "bind_properties_")
## If true, enables binding [Node] properties when [method BaseButton._pressed] is called.
@export_custom(PROPERTY_HINT_GROUP_ENABLE, "") var bind_properties_enabled: bool = false
## [Array] of properties to bind.
@export var bind_properties_array: Array[PropertyBinding] = []

@export_group("Tooltip", "tooltip_")
## If true, enables extra tooltip functionality.
@export_custom(PROPERTY_HINT_GROUP_ENABLE, "") var tooltip_enabled: bool = false
## Format string used to automatically format the tooltip.
@export_custom(PROPERTY_HINT_MULTILINE_TEXT, "") var tooltip_format_string: String = "pressed: %s"
## Properties of this [ShortButton] used for [member tooltip_format_string]. This is in CSV format.
@export_custom(PROPERTY_HINT_MULTILINE_TEXT, "") var tooltip_properties: String = "button_pressed"
#endregion variables


#region virtual
func _get_tooltip(_at_position: Vector2) -> String:
	if !tooltip_enabled: return tooltip_text
	return tooltip_format_string % ArrayLib.get_object_properties(self, ArrayLib.from_csv(tooltip_properties))

func _pressed() -> void:
	if Engine.is_editor_hint(): return
	
	if bind_properties_enabled:
		for property_binding in bind_properties_array:
			property_binding.update_nodes(self)
			property_binding.apply()
	
	if animation_enabled:
		if !button_pressed and toggle_mode and animation_reverse_on_toggle_off:
			animation_press.update_animation_player(self)
			animation_press.play_backwards()
		elif !button_pressed and toggle_mode:
			animation_unpress.update_animation_player(self)
			animation_unpress.play()
		else:
			animation_press.update_animation_player(self)
			animation_press.play()
#endregion virtual
