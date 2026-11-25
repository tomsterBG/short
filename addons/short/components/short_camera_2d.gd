## A 2D camera that can be controlled by input actions.
##
## Features movement via input actions, mouse dragging to pan, zooming and rotation.
##[br]Each feature is toggleable in the inspector and in code.

@tool
class_name ShortCamera2D extends Camera2D


#region variables
@export_group("Move", "move_")

## Enables moving the camera via input actions.
@export_custom(PROPERTY_HINT_GROUP_ENABLE, "") var move_on: bool = false: set = set_move_on

## Movement speed in [code]pixels/second[/code] at zoom 1.0.
@export_custom(PROPERTY_HINT_NONE, "suffix:px/s") var move_speed: float = 600.0

## If [code]true[/code], movement directions rotate to match the camera view rotation.
@export var move_in_view_space: bool = true

## Action for moving left.
@export_custom(PROPERTY_HINT_INPUT_NAME, "") var move_left: StringName = &"": set = set_move_left

## Action for moving right.
@export_custom(PROPERTY_HINT_INPUT_NAME, "") var move_right: StringName = &"": set = set_move_right

## Action for moving up.
@export_custom(PROPERTY_HINT_INPUT_NAME, "") var move_up: StringName = &"": set = set_move_up

## Action for moving down.
@export_custom(PROPERTY_HINT_INPUT_NAME, "") var move_down: StringName = &"": set = set_move_down

@export_subgroup("Speed Modifiers", "move_")

## Enables move speed modifiers via input actions.
@export_custom(PROPERTY_HINT_GROUP_ENABLE, "") var move_speed_on: bool = false: set = set_move_speed_on

## Action for moving faster.
@export_custom(PROPERTY_HINT_INPUT_NAME, "") var move_faster: StringName = &"": set = set_move_faster

## Action for moving slower.
@export_custom(PROPERTY_HINT_INPUT_NAME, "") var move_slower: StringName = &"": set = set_move_slower

## Move speed multiplier when moving faster.
@export_custom(PROPERTY_HINT_NONE, "suffix:x") var move_speed_fast: float = 2.0

## Move speed multiplier when moving slower.
@export_custom(PROPERTY_HINT_NONE, "suffix:x") var move_speed_slow: float = 0.5

@export_group("Pan", "pan_")

## Enables mouse drag-panning.
@export_custom(PROPERTY_HINT_GROUP_ENABLE, "") var pan_on: bool = false

## Mouse button mask used to drag the camera.
@export var pan_mouse_mask: MouseButtonMask = MOUSE_BUTTON_MASK_RIGHT

@export_group("Zoom", "zoom_")

## Enables stepped zooming via input actions.
@export_custom(PROPERTY_HINT_GROUP_ENABLE, "") var zoom_on: bool = false: set = set_zoom_on

## Multiplier applied per zoom step.
@export_custom(PROPERTY_HINT_NONE, "suffix:x") var zoom_factor: float = 1.2: set = set_zoom_factor

## If [code]true[/code], zooming keeps the mouse cursor pointing at the same position.
@export var zoom_to_mouse: bool = true

## Action for zooming in.
@export_custom(PROPERTY_HINT_INPUT_NAME, "") var zoom_in: StringName = &"": set = set_zoom_in

## Action for zooming out.
@export_custom(PROPERTY_HINT_INPUT_NAME, "") var zoom_out: StringName = &"": set = set_zoom_out

## Controls which property is modified by zoom actions. Default [member Camera2D.zoom].
@export var zoom_property: StringName = &"zoom": set = set_zoom_property

@export_subgroup("Zoom Limits", "zoom_")

## Enables zoom limits.
@export_custom(PROPERTY_HINT_GROUP_ENABLE, "") var zoom_limit_on: bool = false: set = set_zoom_limit_on

## Minimum zoom limits.
@export var zoom_min: Vector2 = Vector2(0.1, 0.1): set = set_zoom_min

## Maximum zoom limits.
@export var zoom_max: Vector2 = Vector2(10.0, 10.0): set = set_zoom_max

@export_group("Rotate", "rotate_")

## Enables rotating the camera via input actions.
@export_custom(PROPERTY_HINT_GROUP_ENABLE, "") var rotate_on: bool = false: set = set_rotate_on

## Rotation speed in [code]radians/second[/code].
@export_custom(PROPERTY_HINT_NONE, "suffix:rad/s") var rotate_speed: float = PI / 2.0

## Action for rotating counter-clockwise.
@export_custom(PROPERTY_HINT_INPUT_NAME, "") var rotate_left: StringName = &"": set = set_rotate_left

## Action for rotating clockwise.
@export_custom(PROPERTY_HINT_INPUT_NAME, "") var rotate_right: StringName = &"": set = set_rotate_right
#endregion variables


#region setters
func set_move_on(value: bool) -> void:
	move_on = value
	if Engine.is_editor_hint(): update_configuration_warnings()

func set_move_left(value: StringName) -> void:
	move_left = value
	if Engine.is_editor_hint(): update_configuration_warnings()

func set_move_right(value: StringName) -> void:
	move_right = value
	if Engine.is_editor_hint(): update_configuration_warnings()

func set_move_up(value: StringName) -> void:
	move_up = value
	if Engine.is_editor_hint(): update_configuration_warnings()

func set_move_down(value: StringName) -> void:
	move_down = value
	if Engine.is_editor_hint(): update_configuration_warnings()

func set_move_speed_on(value: bool) -> void:
	move_speed_on = value
	if Engine.is_editor_hint(): update_configuration_warnings()

func set_move_faster(value: StringName) -> void:
	move_faster = value
	if Engine.is_editor_hint(): update_configuration_warnings()

func set_move_slower(value: StringName) -> void:
	move_slower = value
	if Engine.is_editor_hint(): update_configuration_warnings()

func set_zoom_on(value: bool) -> void:
	zoom_on = value
	if Engine.is_editor_hint(): update_configuration_warnings()

func set_zoom_factor(value: float) -> void:
	zoom_factor = maxf(value, 1.001)

func set_zoom_in(value: StringName) -> void:
	zoom_in = value
	if Engine.is_editor_hint(): update_configuration_warnings()

func set_zoom_out(value: StringName) -> void:
	zoom_out = value
	if Engine.is_editor_hint(): update_configuration_warnings()

func set_zoom_property(value: StringName) -> void:
	zoom_property = value
	if Engine.is_editor_hint(): update_configuration_warnings()

func set_zoom_limit_on(value: bool) -> void:
	zoom_limit_on = value
	if Engine.is_editor_hint(): update_configuration_warnings()

func set_zoom_min(value: Vector2) -> void:
	zoom_min = value
	if Engine.is_editor_hint(): update_configuration_warnings()

func set_zoom_max(value: Vector2) -> void:
	zoom_max = value
	if Engine.is_editor_hint(): update_configuration_warnings()

func set_rotate_on(value: bool) -> void:
	rotate_on = value
	if Engine.is_editor_hint(): update_configuration_warnings()

func set_rotate_left(value: StringName) -> void:
	rotate_left = value
	if Engine.is_editor_hint(): update_configuration_warnings()

func set_rotate_right(value: StringName) -> void:
	rotate_right = value
	if Engine.is_editor_hint(): update_configuration_warnings()
#endregion setters


#region getters
## Calculates desired movement vector normalized to 1.
func get_move_direction() -> Vector2:
	var result: Vector2 = Vector2.ZERO
	if move_up: result += Vector2.UP * Input.get_action_strength(move_up)
	if move_down: result += Vector2.DOWN * Input.get_action_strength(move_down)
	if move_left: result += Vector2.LEFT * Input.get_action_strength(move_left)
	if move_right: result += Vector2.RIGHT * Input.get_action_strength(move_right)
	if result.length() > 1.0:
		result = result.normalized()
	return result

## Calculates desired movement speed multiplier.
func get_move_speed_multi() -> float:
	var result: float = 1.0
	if move_speed_on:
		if move_faster and Input.is_action_pressed(move_faster):
			result *= move_speed_fast
		if move_slower and Input.is_action_pressed(move_slower):
			result *= move_speed_slow
	return result

## Calculates desired rotation direction (-1.0 for counter-clockwise, 1.0 for clockwise).
func get_rotate_direction() -> float:
	var result: float = 0.0
	if rotate_left: result -= Input.get_action_strength(rotate_left)
	if rotate_right: result += Input.get_action_strength(rotate_right)
	return result
#endregion getters


#region methods
## Zooms in by [member zoom_factor].
func do_zoom_in(should_zoom_to_mouse: bool) -> void:
	_apply_zoom(zoom_factor, should_zoom_to_mouse)

## Zooms out by [member zoom_factor].
func do_zoom_out(should_zoom_to_mouse: bool) -> void:
	_apply_zoom(1.0 / zoom_factor, should_zoom_to_mouse)
#endregion methods


#region virtual
func _set(property: StringName, _value: Variant) -> bool:
	if !Engine.is_editor_hint(): return false
	if property == &"ignore_rotation":
		update_configuration_warnings()
	return false

func _unhandled_input(event: InputEvent) -> void:
	if Engine.is_editor_hint(): return
	
	if zoom_on:
		if zoom_in and event.is_action_pressed(zoom_in):
			do_zoom_in(zoom_to_mouse)
		elif zoom_out and event.is_action_pressed(zoom_out):
			do_zoom_out(zoom_to_mouse)
	
	if pan_on and event is InputEventMouseMotion:
		if Input.get_mouse_button_mask() & pan_mouse_mask == pan_mouse_mask:
			var mouse_delta: Vector2 = (event as InputEventMouseMotion).relative / zoom
			if not ignore_rotation and rotation != 0.0: mouse_delta = mouse_delta.rotated(rotation)
			position -= mouse_delta

func _process(delta: float) -> void:
	if Engine.is_editor_hint(): return
	
	if rotate_on:
		var rotate_direction: float = get_rotate_direction()
		if rotate_direction != 0.0:
			rotation += rotate_direction * rotate_speed * delta
	
	if move_on:
		var direction: Vector2 = get_move_direction()
		if !direction.is_zero_approx():
			if move_in_view_space and not ignore_rotation and rotation != 0.0:
				direction = direction.rotated(rotation)
			position += (direction * move_speed * get_move_speed_multi() * delta) / zoom

func _get_configuration_warnings() -> PackedStringArray:
	var warnings: PackedStringArray = []
	
	if move_on:
		if move_left == &"" and move_right == &"" and move_up == &"" and move_down == &"":
			warnings.append("Move is on, but all move actions are empty.")
		if move_speed_on and move_faster == &"" and move_slower == &"":
			warnings.append("Move speed modifiers are on, but both modifier actions are empty.")
	
	if zoom_on:
		if zoom_in == &"" and zoom_out == &"":
			warnings.append("Zoom is on, but both zoom actions are empty.")
		if typeof(get(zoom_property)) != TYPE_VECTOR2:
			warnings.append("zoom_property isn't a Vector2.")
		if zoom_limit_on and (zoom_min.x >= zoom_max.x or zoom_min.y >= zoom_max.y):
			warnings.append("Zoom limits are inverted or equal.")
	
	if rotate_on:
		if ignore_rotation:
			warnings.append("Rotate is on, but ignore_rotation is on too.")
		if rotate_left == &"" and rotate_right == &"":
			warnings.append("Rotate is on, but both rotate actions are empty.")
	
	return warnings
#endregion virtual


#region internal
func _apply_zoom(zoom_multi: float, should_zoom_to_mouse: bool) -> void:
	if typeof(get(zoom_property)) != TYPE_VECTOR2: return
	var old_zoom: Vector2 = get(zoom_property)
	var new_zoom: Vector2 = old_zoom * zoom_multi
	if zoom_limit_on: new_zoom = new_zoom.clamp(zoom_min, zoom_max)
	if new_zoom == old_zoom: return
	
	if should_zoom_to_mouse:
		var screen_offset: Vector2 = get_viewport().get_mouse_position()
		if anchor_mode == ANCHOR_MODE_DRAG_CENTER:
			screen_offset -= get_viewport_rect().size * 0.5
		var pos_delta: Vector2 = screen_offset / old_zoom - screen_offset / new_zoom
		if not ignore_rotation and rotation != 0.0:
			pos_delta = pos_delta.rotated(rotation)
		position += pos_delta
	
	self[zoom_property] = new_zoom
#endregion internal
