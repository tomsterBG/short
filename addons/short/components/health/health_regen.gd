# TODO:
# IDEAS:
# BAD IDEAS:
# - Signals: is_regenerating_changed.
# - Add paused signal which does not emit if regen_pause_length == 0.

## @experimental: This class is immature.
## Regeneration for [Health].
##
##[br][br][b]Note:[/b] This overwrites [method Node._process] and [method Node._get_configuration_warnings]. Use [code]super()[/code] if you want to extend the same methods.
##[br][br][b]Note:[/b] This assumes that the [Convert] and [Health] classes exist.

@tool
@icon("health.svg")
class_name HealthRegen extends Node


#region classes
## The result returned by [method HealthRegen.simulate_regen].
class SimulateRegenResult:
	## The success or failure of the simulation.
	var success: bool
	## The result from calling [method Health.heal].
	var heal_result: Health.HealResult
#endregion classes


#region variables
## The [Health] this regeneration will work with.
@export var health: Health: set = set_health

@export_group("Regen", "regen_")

## Toggles regen.
@export_custom(PROPERTY_HINT_GROUP_ENABLE, "Regen Enabled") var regen_enabled := true

## Toggles regen in the editor.
@export var regen_in_editor := false

## Toggles regen through [method Node._process].
@export var regen_in__process := true

## Heal this much [member Health.health] each second.
@export_custom(PROPERTY_HINT_NONE, "suffix:hp/s") var regen_per_second := 0.0

@export_subgroup("Pause", "regen_pause")

## Toggles if regen pauses when [member health] is damaged.
@export var regen_pause_when_damaged := true

## Pause regeneration for this many seconds.
@export_custom(PROPERTY_HINT_NONE, "suffix:sec") var regen_pause_length := 0.0

## Seconds until regen pause ends.
var regen_pause_time_left := 0.0: set = set_regen_pause_time_left
#endregion variables


#region setters
func set_health(value: Health) -> void:
	if health:
		health.health_changed.disconnect(_on_health_changed)
	if value:
		value.health_changed.connect(_on_health_changed)
	health = value
	if Engine.is_editor_hint(): update_configuration_warnings()

func set_regen_pause_time_left(value: float) -> void:
	regen_pause_time_left = clamp(value, 0.0, regen_pause_length)
#endregion setters


#region getters
## If [member Health.health] was [code]0[/code], how long until it fully regens to [member Health.max_health]?
func get_seconds_for_full_regen() -> float:
	if !regen_enabled or regen_per_second == 0.0: return INF
	return health.max_health / regen_per_second

## How many seconds since pausing regen?
func get_time_since_pause() -> float:
	return regen_pause_length - regen_pause_time_left
#endregion getters


#region methods
## Pause regeneration.
func pause_regen() -> void:
	if regen_pause_length == 0.0: return
	regen_pause_time_left = regen_pause_length

## Syntax sugar for [member regen_pause_time_left] [code]> 0.0[/code].
func is_regen_paused() -> bool:
	return regen_pause_time_left > 0.0

## Simulate regen for [param delta] seconds.
func simulate_regen(delta: float) -> SimulateRegenResult:
	var result := SimulateRegenResult.new()
	if !health or !regen_enabled or regen_per_second == 0.0:
		result.success = false
		return result
	
	result.success = true
	result.heal_result = health.heal(regen_per_second * (delta - regen_pause_time_left))
	regen_pause_time_left -= delta
	return result
#endregion methods


#region virtual
func _on_health_changed(difference: float) -> void:
	if regen_pause_when_damaged and difference < 0.0: pause_regen()

func _process(delta: float) -> void:
	if !regen_in__process or (Engine.is_editor_hint() and !regen_in_editor): return
	simulate_regen(delta)

func _get_configuration_warnings() -> PackedStringArray:
	var warnings: PackedStringArray
	if !health:
		warnings.append("Health is null.")
	return warnings
#endregion virtual
