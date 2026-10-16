# TODO:
# IDEAS:

## A button that changes the current scene.
##
## When the button is pressed, the [member scene] will be loaded.
##[br][br][b]Note:[/b] This overrides [method Node._get_configuration_warnings] and [method BaseButton._pressed]. Use [code]super()[/code] if you want to extend the same methods.
##[br][br][b]Note:[/b] This assumes that the [AudioLib] class exists.

@tool
class_name SceneButton extends Button


#region variables
## Changes to this [PackedScene] when the button is pressed.
@export var scene: PackedScene: set = set_scene

## Loads and changes to this scene when the button is pressed. Useful when [member scene] causes circular dependency.
@export_file("*.tscn") var scene_path: String: set = set_scene_path

@export_group("Audio")

## [AudioStream] to play when the button is pressed.
@export var press_stream: AudioStream

## The position to begin playing [member press_stream] at.
@export var press_stream_from_position: float = 0.0
#endregion variables


#region setters
func set_scene(value: PackedScene) -> void:
	scene = value
	if Engine.is_editor_hint(): update_configuration_warnings()

func set_scene_path(value: String) -> void:
	scene_path = value
	if Engine.is_editor_hint(): update_configuration_warnings()
#endregion setters


#region methods
## Changes to [member scene].
func change_scene() -> void:
	if scene:
		get_tree().change_scene_to_packed(scene)
	else:
		get_tree().change_scene_to_file(scene_path)
#endregion methods


#region virtual
func _pressed() -> void:
	if press_stream: AudioLib.play_persistent(press_stream, press_stream_from_position)
	change_scene()

func _get_configuration_warnings() -> PackedStringArray:
	var warnings: PackedStringArray
	if !scene and !scene_path:
		warnings.append("Missing scene. The button won't do anything.")
	return warnings
#endregion virtual
