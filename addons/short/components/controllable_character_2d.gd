# IDEAS:
# - jump_action
# - jump_speed
# - walk_local_direction

## A character that can be controlled.
##
##[br][br][b]Note:[/b] This assumes that the [StringLib] class exists.

@tool
class_name ControllableCharacter2D extends CharacterBody2D


#region variables
@export_group("Move")

## Toggles movement through [method Node._process].
@export var move_in__process: bool = false

## Toggles movement through [method Node._physics_process].
@export var move_in__physics_process: bool = false

## Toggles if the character experiences gravity in [method calculate_velocity].
@export var gravity_enabled: bool = false

@export_group("Walk")

## Toggles if the character can walk via user input.
@export_custom(PROPERTY_HINT_GROUP_ENABLE, "") var walk_enabled: bool = false: set = set_walk_enabled

## Speed of walking in [code]pixels/second[/code].
@export var walk_speed: float = 100.0

## Input action for walking towards [constant Vector2.LEFT].
@export_custom(PROPERTY_HINT_INPUT_NAME, "") var walk_left_action: StringName = &"": set = set_walk_left_action

## Input action for walking towards [constant Vector2.RIGHT].
@export_custom(PROPERTY_HINT_INPUT_NAME, "") var walk_right_action: StringName = &"": set = set_walk_right_action

## Input action for walking towards [constant Vector2.UP].
@export_custom(PROPERTY_HINT_INPUT_NAME, "") var walk_up_action: StringName = &"": set = set_walk_up_action

## Input action for walking towards [constant Vector2.DOWN].
@export_custom(PROPERTY_HINT_INPUT_NAME, "") var walk_down_action: StringName = &"": set = set_walk_down_action
#endregion variables


#region setters
func set_walk_enabled(value: bool) -> void:
	walk_enabled = value
	if Engine.is_editor_hint(): update_configuration_warnings()

func set_walk_left_action(value: StringName) -> void:
	walk_left_action = value
	if Engine.is_editor_hint(): update_configuration_warnings()

func set_walk_right_action(value: StringName) -> void:
	walk_right_action = value
	if Engine.is_editor_hint(): update_configuration_warnings()

func set_walk_up_action(value: StringName) -> void:
	walk_up_action = value
	if Engine.is_editor_hint(): update_configuration_warnings()

func set_walk_down_action(value: StringName) -> void:
	walk_down_action = value
	if Engine.is_editor_hint(): update_configuration_warnings()
#endregion setters


#region getters
## Calculates desired walk direction according to walk input actions. Just like [method Input.get_vector], maximum vector length is 1.
func get_walk_direction() -> Vector2:
	# NOTE: It is better with Input.get_vector, but it causes errors when some actions don't exist.
	## The desired walk direction.
	var result: Vector2 = Vector2.ZERO
	if walk_up_action:
		result += Vector2.UP * Input.get_action_strength(walk_up_action)
	if walk_down_action:
		result += Vector2.DOWN * Input.get_action_strength(walk_down_action)
	if walk_left_action:
		result += Vector2.LEFT * Input.get_action_strength(walk_left_action)
	if walk_right_action:
		result += Vector2.RIGHT * Input.get_action_strength(walk_right_action)
	if result.length() > 1.0:
		result = result.normalized()
	return result
#endregion getters


#region methods
## Calculates velocity after [param delta] seconds.
func calculate_velocity(delta: float) -> Vector2:
	## The resulting velocity.
	var result: Vector2 = Vector2.ZERO
	
	if gravity_enabled:
		result += get_gravity() * delta
	
	if walk_enabled:
		result += get_walk_direction() * walk_speed * delta
	
	return result
#endregion methods


#region virtual
func _process(delta: float) -> void:
	if !move_in__process: return
	velocity = calculate_velocity(delta)
	move_and_slide()

func _physics_process(delta: float) -> void:
	if !move_in__physics_process: return
	velocity = calculate_velocity(delta)
	move_and_slide()

func _get_configuration_warnings() -> PackedStringArray:
	var warnings: PackedStringArray
	if (walk_enabled
		and !StringLib.is_valid_action(walk_left_action)
		and !StringLib.is_valid_action(walk_right_action)
		and !StringLib.is_valid_action(walk_up_action)
		and !StringLib.is_valid_action(walk_down_action)):
			warnings.append("Can't walk, all input actions are empty.")
	return warnings
#endregion virtual
