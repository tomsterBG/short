## A 2D camera with built-in action movement, drag-panning, stepped zoom, and rotation controls.
##
## All features are independently toggleable in the inspector.

@tool
class_name ShortCamera2D extends Camera2D


#region variables
@export_group("Move", "move_")

## Enables moving the camera via input actions.
@export_custom(PROPERTY_HINT_GROUP_ENABLE, "") var move_enabled: bool = false: set = set_move_enabled

## Movement speed in [code]pixels/second[/code] at zoom 1.0.
@export var move_speed: float = 600.0

## If [code]true[/code], movement directions rotate to match the camera view rotation.
@export var move_in_view_space: bool = true

## Action for moving left.
@export_custom(PROPERTY_HINT_INPUT_NAME, "") var move_left_action: StringName = &"": set = set_move_left_action

## Action for moving right.
@export_custom(PROPERTY_HINT_INPUT_NAME, "") var move_right_action: StringName = &"": set = set_move_right_action

## Action for moving up.
@export_custom(PROPERTY_HINT_INPUT_NAME, "") var move_up_action: StringName = &"": set = set_move_up_action

## Action for moving down.
@export_custom(PROPERTY_HINT_INPUT_NAME, "") var move_down_action: StringName = &"": set = set_move_down_action

@export_group("Pan", "pan_")

## Enables mouse drag-panning.
@export_custom(PROPERTY_HINT_GROUP_ENABLE, "") var pan_enabled: bool = false

## Mouse button mask used to drag the camera.
@export var pan_mouse_mask: MouseButtonMask = MOUSE_BUTTON_MASK_RIGHT

@export_group("Zoom", "zoom_")

## Enables stepped zooming via input actions.
@export_custom(PROPERTY_HINT_GROUP_ENABLE, "") var zoom_enabled: bool = false: set = set_zoom_enabled

## Multiplier applied per zoom step.
@export var zoom_factor: float = 1.2: set = set_zoom_factor

## Minimum zoom limits.
@export var zoom_min: Vector2 = Vector2(0.1, 0.1): set = set_zoom_min

## Maximum zoom limits.
@export var zoom_max: Vector2 = Vector2(10.0, 10.0): set = set_zoom_max

## Action for zooming in.
@export_custom(PROPERTY_HINT_INPUT_NAME, "") var zoom_in_action: StringName = &"": set = set_zoom_in_action

## Action for zooming out.
@export_custom(PROPERTY_HINT_INPUT_NAME, "") var zoom_out_action: StringName = &"": set = set_zoom_out_action

@export_group("Rotate", "rotate_")

## Enables rotating the camera via input actions.
@export_custom(PROPERTY_HINT_GROUP_ENABLE, "") var rotate_enabled: bool = false: set = set_rotate_enabled

## Rotation speed in [code]radians/second[/code].
@export_custom(PROPERTY_HINT_NONE, "suffix:rad/s") var rotate_speed: float = TAU

## Action for rotating counter-clockwise.
@export_custom(PROPERTY_HINT_INPUT_NAME, "") var rotate_left_action: StringName = &"": set = set_rotate_left_action

## Action for rotating clockwise.
@export_custom(PROPERTY_HINT_INPUT_NAME, "") var rotate_right_action: StringName = &"": set = set_rotate_right_action
#endregion variables


#region setters
func set_move_enabled(value: bool) -> void:
	move_enabled = value
	if Engine.is_editor_hint(): update_configuration_warnings()

func set_move_left_action(value: StringName) -> void:
	move_left_action = value
	if Engine.is_editor_hint(): update_configuration_warnings()

func set_move_right_action(value: StringName) -> void:
	move_right_action = value
	if Engine.is_editor_hint(): update_configuration_warnings()

func set_move_up_action(value: StringName) -> void:
	move_up_action = value
	if Engine.is_editor_hint(): update_configuration_warnings()

func set_move_down_action(value: StringName) -> void:
	move_down_action = value
	if Engine.is_editor_hint(): update_configuration_warnings()

func set_zoom_enabled(value: bool) -> void:
	zoom_enabled = value
	if Engine.is_editor_hint(): update_configuration_warnings()

func set_zoom_factor(value: float) -> void:
	zoom_factor = maxf(value, 1.001)

func set_zoom_min(value: Vector2) -> void:
	zoom_min = value.clamp(Vector2(0.001, 0.001), zoom_max)

func set_zoom_max(value: Vector2) -> void:
	zoom_max = value.clamp(zoom_min, Vector2(100.0, 100.0))

func set_zoom_in_action(value: StringName) -> void:
	zoom_in_action = value
	if Engine.is_editor_hint(): update_configuration_warnings()

func set_zoom_out_action(value: StringName) -> void:
	zoom_out_action = value
	if Engine.is_editor_hint(): update_configuration_warnings()

func set_rotate_enabled(value: bool) -> void:
	rotate_enabled = value
	if Engine.is_editor_hint(): update_configuration_warnings()

func set_rotate_left_action(value: StringName) -> void:
	rotate_left_action = value
	if Engine.is_editor_hint(): update_configuration_warnings()

func set_rotate_right_action(value: StringName) -> void:
	rotate_right_action = value
	if Engine.is_editor_hint(): update_configuration_warnings()
#endregion setters


#region getters
## Calculates desired movement vector normalized to 1.
func get_move_direction() -> Vector2:
	var result := Vector2.ZERO
	if move_up_action: result += Vector2.UP * Input.get_action_strength(move_up_action)
	if move_down_action: result += Vector2.DOWN * Input.get_action_strength(move_down_action)
	if move_left_action: result += Vector2.LEFT * Input.get_action_strength(move_left_action)
	if move_right_action: result += Vector2.RIGHT * Input.get_action_strength(move_right_action)
	if result.length() > 1.0:
		result = result.normalized()
	return result

## Calculates desired rotation direction (-1.0 for counter-clockwise, 1.0 for clockwise).
func get_rotate_direction() -> float:
	var result := 0.0
	if rotate_left_action: result -= Input.get_action_strength(rotate_left_action)
	if rotate_right_action: result += Input.get_action_strength(rotate_right_action)
	return result
#endregion getters


#region methods
## Zooms in by [member zoom_factor].
func zoom_in() -> void:
	zoom = (zoom * zoom_factor).clamp(zoom_min, zoom_max)

## Zooms out by [member zoom_factor].
func zoom_out() -> void:
	zoom = (zoom / zoom_factor).clamp(zoom_min, zoom_max)
#endregion methods


#region virtual
func _set(property: StringName, _value: Variant) -> bool:
	if !Engine.is_editor_hint(): return false
	if property == &"ignore_rotation":
		update_configuration_warnings()
	return false

func _input(event: InputEvent) -> void:
	if Engine.is_editor_hint(): return
	
	if zoom_enabled:
		if zoom_in_action and event.is_action_pressed(zoom_in_action):
			zoom_in()
		elif zoom_out_action and event.is_action_pressed(zoom_out_action):
			zoom_out()
	
	if pan_enabled and event is InputEventMouseMotion:
		if Input.get_mouse_button_mask() & pan_mouse_mask == pan_mouse_mask:
			position -= (event as InputEventMouseMotion).relative / zoom

func _process(delta: float) -> void:
	if Engine.is_editor_hint(): return
	
	if rotate_enabled:
		var rotate_direction := get_rotate_direction()
		if rotate_direction != 0.0:
			rotation += rotate_direction * rotate_speed * delta
	
	if move_enabled:
		var direction := get_move_direction()
		if !direction.is_zero_approx():
			if move_in_view_space and rotation != 0.0:
				direction = direction.rotated(rotation)
			position += (direction * move_speed * delta) / zoom

func _get_configuration_warnings() -> PackedStringArray:
	var warnings: PackedStringArray = []
	if move_enabled and move_left_action.is_empty() and move_right_action.is_empty() and move_up_action.is_empty() and move_down_action.is_empty():
		warnings.append("Move is enabled, but all move actions are empty.")
	if zoom_enabled and zoom_in_action.is_empty() and zoom_out_action.is_empty():
		warnings.append("Zoom is enabled, but both zoom actions are empty.")
	return warnings
#endregion virtual
