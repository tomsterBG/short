# TODO:
# IDEAS:

## A button that changes the current scene.
##
## When the button is pressed, the [member scene] will be loaded.
##[br][br][b]Note:[/b] This overrides [method Node._get_configuration_warnings] and [method BaseButton._pressed]. Use [code]super()[/code] if you want to extend the same methods.

@tool
class_name SceneButton extends Button


#region variables
## Change to this [PackedScene].
@export var scene: PackedScene: set = set_scene
#endregion variables


#region setters
func set_scene(value: PackedScene) -> void:
	scene = value
	if Engine.is_editor_hint(): update_configuration_warnings()
#endregion setters


#region methods
## Changes to [member scene].
func change_scene() -> void:
	get_tree().change_scene_to_packed(scene)
#endregion methods


#region virtual
func _pressed() -> void:
	change_scene()

func _get_configuration_warnings() -> PackedStringArray:
	var warnings: PackedStringArray
	if !scene:
		warnings.append("Missing scene. The button won't do anything.")
	return warnings
#endregion virtual
