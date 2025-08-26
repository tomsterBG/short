# NOTE:
# This assumes that the Helpers global exists.
# TODO:
# - In-engine errors for relevant things.
# IDEAS:
# - Update health from regeneration only when script tries to read health. Know when the health was last updated and calculate delta time * regen to get how much regen must be applied.
# BAD IDEAS:
# - Disable regen in the editor.
# - Emit reneration signals for when regen state changes (is_regenerating), when fully regenerated (ensure this one doesn't emit when manually fully regenerating).
# - Free_owner_on_death, might be useless and more complex than needed.
# - Can add an immunity to damage like the Roblox shield system, but it feels like unnecessary jank.
# - Negative resistance adds effective damage (for brittle stuff), for example 1 damage with -10 means 11 effective damage, 1 with -100% means 2 effective, 1 damage with -1 flat and -100% means 4 effective damage.
# - Signal on_fully_regenerated or on_max_health_reached.
# - Get remaining time until full regen.
# - Add interrupted signal which does not emit if length is 0.
# - Don't set interruption time if length is 0.
# - Add HealResult returned by heal().

## @experimental: This class will be changed.
## [Health] with extra functionality.
##
## Less widely applicable. An overhead class used for janky, but much needed functionality.

@tool
class_name HealthPlus
extends Health


#region variables
@export_group("Regen", "regen_")

## The amount of [member Health.health] healed each second.
@export var regen_per_second := 0.0

## The time to pause regeneration for, when [Health] takes damage, in seconds.
@export var regen_interruption_length := 0.0

## The time when an interruption happened, using [method Time.get_ticks_msec].
var regen_interruption_time := 0
#endregion variables


#region methods
## If [member Health.health] was [code]0[/code], how long until it fully regens to [member Health.max_health]?
func get_seconds_for_full_regen() -> float:
	return max_health / regen_per_second

## Cause an interruption to regeneration.
func interrupt_regen() -> void:
	regen_interruption_time = Time.get_ticks_msec()

## Is time since interruption more than [member regen_interruption_length]?
func is_regen_interrupted() -> bool:
	var time_since_interruption := Time.get_ticks_msec() - regen_interruption_time
	return time_since_interruption < Helpers.sec_to_msec(regen_interruption_length)
#endregion methods


#region internal
# CRITICAL: This is bad, do not overwrite internal methods in custom components. What happens if you extend the class and need the method? You overwrite it again.
func _ready() -> void:
	health_changed.connect(_on_health_changed)

func _process(delta: float) -> void:
	if regen_per_second == 0.0 or is_regen_interrupted(): return
	heal(regen_per_second * delta)

func _on_health_changed(difference: float) -> void:
	if difference < 0.0: interrupt_regen()
#endregion internal
