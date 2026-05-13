# TODO:

## @experimental: This class could change.
## A generic fold button.
##
## When the button is pressed, the [member node] will be visible, otherwise it will be invisible.

@tool
@icon("unfolded.svg")
class_name FoldButton extends Button


#region variables
## Fold this object by changing its visibility.
@export var node: CanvasItem: set = set_node

@export_group("Icons", "icon_")

## Used when the button isn't pressed. See [member BaseButton.button_pressed].
@export var icon_folded: Texture2D = preload("uid://0kuvxm3lm6ed")

## Used when the button is pressed. See [member BaseButton.button_pressed].
@export var icon_unfolded: Texture2D = preload("uid://diktvutgm43e6")
#endregion variables


#region setters
func set_node(value: CanvasItem) -> void:
	node = value
	refresh()
#endregion setters


#region methods
## Refreshes the visuals.
func refresh() -> void:
	if node: node.visible = button_pressed
	icon = icon_unfolded if button_pressed else icon_folded

## Toggles this button.
func toggle() -> void:
	button_pressed = !button_pressed
#endregion methods


#region virtual
func _enter_tree() -> void:
	toggle_mode = true
	refresh()

func _toggled(_toggled_on: bool) -> void:
	refresh()

func _get_configuration_warnings() -> PackedStringArray:
	var warnings: PackedStringArray
	if !node:
		warnings.append("Missing node. The button won't fold anything.")
	elif node == self:
		warnings.append("The button will fold itself.")
	if !toggle_mode:
		warnings.append("The button won't unfold with toggle_mode false.")
	return warnings
#endregion virtual
