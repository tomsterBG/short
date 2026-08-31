## An [AudioStreamPlayer] that specifically plays sounds for any [BaseButton].

@tool
class_name ButtonAudioPlayer extends AudioStreamPlayer


## The button to play audio for.
@export var button: BaseButton: set = set_button

## Played when [member button] is pressed.
@export var press_stream: AudioStream


#region setters
func set_button(value: BaseButton) -> void:
	button = value
	if button:
		button.pressed.connect(_on_button_pressed)
	if Engine.is_editor_hint():
		update_configuration_warnings()
#endregion setters


#region virtual
## Runs when [member button] is pressed.
func _on_button_pressed() -> void:
	stream = press_stream
	play()

func _get_configuration_warnings() -> PackedStringArray:
	var result: PackedStringArray
	if !button:
		result.append("Missing button. This node won't do anything.")
	return result
#endregion virtual
