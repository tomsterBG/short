# NOTE:
# Not yet passed through class quality checklist.
# IDEAS:

## @experimental: This class could change.
## An [OptionButton] with extra functionality.
##
##[br][br][b]Note:[/b] This assumes that the [PropertyBinding] and [SignalLib] classes exist.

@tool
class_name ShortOptionButton extends OptionButton


#region variables
@export_group("Bind Properties", "bind_properties_")
## If true, enables binding [Node] properties when [method ShortOptionButton._on_item_selected] is called.
@export_custom(PROPERTY_HINT_GROUP_ENABLE, "") var bind_properties_enabled: bool = false
## [Array] of properties to bind.
@export var bind_properties_array: Array[PropertyBinding] = []

@export_group("Tooltip", "tooltip_")
## If true, enables extra tooltip functionality.
@export_custom(PROPERTY_HINT_GROUP_ENABLE, "") var tooltip_enabled: bool = false
## Format string used to automatically format the tooltip.
@export_custom(PROPERTY_HINT_MULTILINE_TEXT, "") var tooltip_format_string: String = "pressed: %s"
## Properties of this [ShortOptionButton] used for [member tooltip_format_string]. This is in CSV format.
@export_custom(PROPERTY_HINT_MULTILINE_TEXT, "") var tooltip_properties: String = "button_pressed"
#endregion variables


#region virtual
func _get_tooltip(_at_position: Vector2) -> String:
	if !tooltip_enabled: return tooltip_text
	return tooltip_format_string % ArrayLib.get_object_properties(self, ArrayLib.from_csv(tooltip_properties))

func _enter_tree() -> void:
	SignalLib.safe_connect(self, &"item_selected", _on_item_selected)

## Virtual method called every time when [signal OptionButton.item_selected] is emitted.
func _on_item_selected(_index: int) -> void:
	if Engine.is_editor_hint(): return
	if bind_properties_array:
		for property_binding in bind_properties_array:
			property_binding.update_nodes(self)
			property_binding.apply()
#endregion virtual
