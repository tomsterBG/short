# TODO:
# IDEAS:
# BAD IDEAS:
# - Signals: is_regenerating_changed.
# - Add paused signal which does not emit if regen_pause_for == 0.

## @experimental: This class is immature.
## Regeneration for [Health].
##
##[br][br][b]Note:[/b] This overwrites [method Node._process] and [method Node._get_configuration_warnings]. Use [code]super()[/code] if you want to extend the same methods.
##[br][br][b]Note:[/b] This assumes that the [Convert] and [Health] classes exist.

@tool
@icon("health.svg")
class_name HealthRegen extends Node


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
@export var regen_per_second := 0.0

## Pause regeneration for this many seconds.
@export var regen_pause_for := 0.0

## Toggles if regen pauses when [member health] is damaged.
@export var regen_pause_when_damaged := true

## Timestamp of when regen was paused, using [method Time.get_ticks_msec].
var regen_paused_at := -1_000_000_000_000_000
#endregion variables


#region setters
func set_health(value: Health):
	if value:
		value.health_changed.connect(_on_health_changed)
	elif health:
		health.health_changed.disconnect(_on_health_changed)
	health = value
	update_configuration_warnings()
#endregion setters


#region getters
## If [member Health.health] was [code]0[/code], how long until it fully regens to [member Health.max_health]?
func get_seconds_for_full_regen() -> float:
	if !regen_enabled or regen_per_second == 0.0: return INF
	return health.max_health / regen_per_second

## How many seconds until pause ends?
func get_pause_time_left() -> float:
	return max(0.0, regen_pause_for - Convert.msec_to_sec(get_time_since_pause()))

## How many msec since pausing regen?
func get_time_since_pause() -> float:
	return Time.get_ticks_msec() - regen_paused_at
#endregion getters


#region methods
## Pause regeneration.
func pause_regen() -> void:
	if regen_pause_for == 0.0: return
	regen_paused_at = Time.get_ticks_msec()

## Is time since pause more than [member regen_pause_for]?
func is_regen_paused() -> bool:
	return get_time_since_pause() < Convert.sec_to_msec(regen_pause_for)

## Simulate regen for [param delta] seconds.
func simulate_regen(delta: float) -> void:
	if !health or !regen_enabled or regen_per_second == 0.0: return
	health.heal(regen_per_second * (delta - get_pause_time_left()))
	regen_paused_at -= int(Convert.sec_to_msec(delta))
#endregion methods


#region internal
func _on_health_changed(difference: float) -> void:
	if regen_pause_when_damaged and difference < 0.0: pause_regen()

func _process(delta: float) -> void:
	if !regen_in__process or (Engine.is_editor_hint() and !regen_in_editor): return
	simulate_regen(delta)

func _get_configuration_warnings() -> PackedStringArray:
	var warnings: PackedStringArray
	if !health:
		warnings.append("Choose a Health.")
	return warnings
#endregion internal
