# INFO:
# Each unit test should build on top of the ones before it, for easier troubleshooting.
# TODO:
# - More shield testing, i'm not convinced in its robustness.
# - Testing can_die feels insufficient.
# - Test when all shields die and get revived.

extends GutTest

var health: Health


#region virtual methods
func before_each():
	health = Health.new()
	add_child_autofree(health)
	watch_signals(health)
#endregion virtual methods


#region tests
func test_initial_values():
	assert_eq(health.health, 100.0, "Health is 100.")
	assert_eq(health.max_health, 100.0, "Max_health is 100.")
	assert_eq(health.can_die, true, "Can_die is true.")
	assert_eq(health.is_dead, false, "Is_dead is false.")
	assert_eq(health.resistance_flat, 0.0, "Flat resistance is 0.")
	assert_eq(health.resistance_percent, 0.0, "Percent resistance is 0.")
	assert_eq(health.resistance_order, health.ResistanceOrder.PERCENT_FLAT, "Resistance order is percent flat.")
	assert_eq(health.shield, null, "Shield is null as it is optional.")

func test_initial_method_values():
	assert_eq(health.get_health_ratio(), 1.0, "Health ratio is 1.")
	assert_eq(health.get_health_percent(), 100.0, "Health percent is 100.")
	assert_false(health.are_shields_cyclic(), "Shields aren't cyclic.")

func test_value_clamping():
	health.max_health -= 1.0
	assert_eq(health.health, health.max_health, "Clamp health down to max_health to stay within limits.")
	health.health = health.max_health + 1.0
	assert_eq(health.health, health.max_health, "Can't set health above max_health.")
	health.health = -1.0
	assert_eq(health.health, 0.0, "Health can't be negative.")
	health.max_health = -1.0
	assert_eq(health.max_health, 0.0, "Max_health can't be negative.")
	health.resistance_flat = -1.0
	assert_eq(health.resistance_flat, 0.0, "Flat resistance can't be negative.")
	health.resistance_percent = 101.0
	assert_eq(health.resistance_percent, 100.0, "Can't set percent resistance above 100.")
	health.resistance_percent = -1.0
	assert_eq(health.resistance_percent, 0.0, "Percent resistance can't be negative.")

func test_health_percent_and_ratio():
	health.max_health = 90.0
	assert_eq(health.get_health_percent(), 100.0, "Stay at full health.")
	assert_eq(health.get_health_ratio(), 1.0, "Stay at full health.")
	health.max_health = 100.0
	assert_eq(health.get_health_percent(), 90.0, "Now health is at 90%.")
	assert_eq(health.get_health_ratio(), 0.9, "Now health is at 90%.")
	health.max_health = 0.0
	assert_eq(health.get_health_percent(), 0.0, "Now health is at 0%.")
	assert_eq(health.get_health_ratio(), 0.0, "Now health is at 0%.")

func test_damage():
	var result = health.damage(10.0)
	assert_eq(health.health, health.max_health - 10.0, "Take 10 damage.")
	assert_eq(result.taken_damage, 10.0, "Take 10 damage.")
	result = health.damage(80.0)
	assert_eq(health.health, health.max_health - 10.0 - 80.0, "Take 80 damage.")
	assert_eq(result.taken_damage, 80.0, "Take 80 damage.")
	result = health.damage(-10.0)
	assert_eq(health.health, health.max_health - 10.0 - 80.0, "Don't take negative damage.")
	assert_eq(result.taken_damage, 0.0, "Don't take negative damage.")

func test_heal():
	health.heal(10.0)
	assert_eq(health.health, health.max_health, "Healing at max_health doesn't result any changes.")
	health.damage(50.0)
	health.heal(20.0)
	assert_eq(health.health, 70.0, "Heal by 20 after taking 50 damage.")

func test_health_changed_signal():
	assert_signal_not_emitted(health, "health_changed", "Don't emit health_changed initially.")
	health.health -= 2.0
	assert_signal_emitted(health, "health_changed", "Emit health_changed with difference -2.")
	assert_signal_emitted_with_parameters(health, "health_changed", [-2.0])
	health.health = 98.0
	assert_signal_emit_count(health, "health_changed", 1, "Don't emit health_changed if difference is 0.")
	health.damage(7.0)
	assert_signal_emit_count(health, "health_changed", 2, "Emit health_changed with difference -7.")
	assert_signal_emitted_with_parameters(health, "health_changed", [-7.0])
	health.health = 95.0
	assert_signal_emit_count(health, "health_changed", 3, "Emit health_changed with difference 4.")
	assert_signal_emitted_with_parameters(health, "health_changed", [4.0])
	health.heal(3.0)
	assert_signal_emit_count(health, "health_changed", 4, "Emit health_changed with difference 3.")
	assert_signal_emitted_with_parameters(health, "health_changed", [3.0])
	health.damage(200.0)
	assert_signal_emit_count(health, "health_changed", 5, "Emit health_changed with difference -98.")
	assert_signal_emitted_with_parameters(health, "health_changed", [-98.0])
	health.heal(200.0)
	assert_signal_emit_count(health, "health_changed", 6, "Emit health_changed with difference 100.")
	assert_signal_emitted_with_parameters(health, "health_changed", [100.0])

func test_is_dead_and_died_signal():
	assert_signal_not_emitted(health, "died", "Don't emit died initially.")
	health.health = 0.0
	assert_eq(health.is_dead, true, "Die when health is 0.")
	assert_signal_emitted(health, "died", "Should also emit died.")
	health.health = 1.0
	health.health = 0.0
	assert_signal_emit_count(health, "died", 1, "If already dead, don't emit died even when health is 0.")
	health.is_dead = false
	health.health = 1.0
	health.health = 0.0
	assert_signal_emit_count(health, "died", 2, "If not dead, emit died again.")

func test_kill_and_revive():
	health.kill()
	assert_eq(health.is_dead, true, "Health is killed.")
	assert_signal_emit_count(health, "died", 1, "Health died.")
	health.revive()
	assert_eq(health.is_dead, false, "Health is revived.")
	health.kill()
	assert_eq(health.is_dead, true, "Health is killed again.")
	assert_signal_emit_count(health, "died", 2, "Health died twice.")
	health.kill()
	assert_eq(health.is_dead, true, "Health was already killed.")
	assert_signal_emit_count(health, "died", 2, "Health died only twice.")
	health.health = 0.0
	health.revive()
	health.kill()
	assert_eq(health.is_dead, true, "Health is killed again despite health being 0.")
	assert_signal_emit_count(health, "died", 3, "Health died thrice.")
	health.can_die = false
	assert_eq(health.is_dead, false, "Health can't die.")
	assert_signal_emit_count(health, "died", 3, "Health died only thrice.")
	health.revive()
	health.kill()
	assert_eq(health.is_dead, false, "Health can't die.")
	assert_signal_emit_count(health, "died", 3, "Health died only thrice.")
	health.can_die = true
	assert_eq(health.health, 0.0, "Health.health is 0.")
	health.revive(true)
	assert_eq(health.is_dead, false, "Health is revived.")
	assert_eq(health.health, health.max_health, "Revive set health to max_health.")
	health.kill(true)
	assert_eq(health.is_dead, true, "Health is killed again.")
	assert_signal_emit_count(health, "died", 4, "Health died 4 times.")
	assert_eq(health.health, 0.0, "Kill set health to 0.")

func test_resistance_flat():
	health.resistance_flat = 10.0
	health.health -= 10.0
	assert_eq(health.health, health.max_health - 10.0, "Take 10 damage.")
	var result = health.damage(11.0)
	assert_eq(health.health, health.max_health - 10.0 - 1.0, "Take 1 damage.")
	assert_eq(result.taken_damage, 1.0, "Take 1 damage.")
	health.health = health.max_health
	result = health.damage(105.0)
	assert_eq(health.health, health.max_health - 95.0, "Take 95 damage.")
	assert_eq(result.taken_damage, 95.0, "Take 95 damage.")
	health.resistance_flat = 200.0
	health.health = health.max_health
	result = health.damage(250.0)
	assert_eq(health.health, 50.0, "Take 50 damage.")
	assert_eq(result.taken_damage, 50.0, "Take 50 damage.")
	assert_false(health.is_dead, "Don't die when raw damage is more than max_health.")
	result = health.damage(-240.0)
	assert_eq(health.health, 50.0, "Don't take negative damage.")
	assert_eq(result.taken_damage, 0.0, "Don't take negative damage.")

func test_resistance_percent():
	health.resistance_percent = 10.0
	health.health -= 50.0
	assert_eq(health.health, health.max_health - 50.0, "Take 50 damage.")
	var result = health.damage(50.0)
	assert_eq(health.health, health.max_health - 50.0 - 45.0, "Take 45 damage at half health.")
	assert_eq(result.taken_damage, 45.0, "Take 45 damage at half health.")
	health.health = health.max_health
	result = health.damage(50.0)
	assert_eq(health.health, health.max_health - 45.0, "Take 45 damage at full health.")
	assert_eq(result.taken_damage, 45.0, "Take 45 damage at full health.")
	health.health = health.max_health
	health.resistance_percent = 50.0
	result = health.damage(160.0)
	assert_eq(health.health, health.max_health - 80.0, "Take 80 damage.")
	assert_eq(result.taken_damage, 80.0, "Take 80 damage.")
	assert_false(health.is_dead, "Don't die when raw damage is more than max_health.")
	result = health.damage(-140.0)
	assert_eq(health.health, health.max_health - 80.0, "Don't take negative damage.")
	assert_eq(result.taken_damage, 0.0, "Don't take negative damage.")
	health.health = health.max_health
	health.resistance_percent = 100.0
	result = health.damage(1000000.0)
	assert_eq(health.health, health.max_health, "Don't take damage at full percent resistance.")
	assert_eq(result.taken_damage, 0.0, "Don't take damage at full percent resistance.")

func test_both_resistances():
	health.resistance_order = health.ResistanceOrder.PERCENT_FLAT
	health.resistance_flat = 10.0
	health.resistance_percent = 50.0
	health.health -= 50.0
	assert_eq(health.health, health.max_health - 50.0, "Take 50 damage.")
	var result = health.damage(50.0)
	assert_eq(health.health, health.max_health - 50.0 - 15.0, "Take 15 damage.")
	assert_eq(result.taken_damage, 15.0, "Take 15 damage.")
	result = health.damage(-110.0)
	assert_eq(health.health, health.max_health - 50.0 - 15.0, "Don't take negative damage.")
	assert_eq(result.taken_damage, 0.0, "Don't take negative damage.")

func test_inverted_resistances():
	health.resistance_order = health.ResistanceOrder.FLAT_PERCENT
	health.resistance_flat = 10.0
	health.resistance_percent = 50.0
	health.health -= 50.0
	assert_eq(health.health, health.max_health - 50.0, "Take 50 damage.")
	var result = health.damage(50.0)
	assert_eq(health.health, health.max_health - 50.0 - 20.0, "Take 20 damage.")
	assert_eq(result.taken_damage, 20.0, "Take 20 damage.")
	result = health.damage(-110.0)
	assert_eq(health.health, health.max_health - 50.0 - 20.0, "Don't take negative damage.")
	assert_eq(result.taken_damage, 0.0, "Don't take negative damage.")

func test_make_shield_without_method():
	var shield: Health = Health.new()
	add_child_autofree(shield)
	watch_signals(shield)
	shield.can_die = false
	health.shield = shield
	shield.max_health = 50.0
	_test_shield(shield)

func test_make_shield():
	var shield := health.make_shield(50.0)
	autofree(shield)
	watch_signals(shield)
	_test_shield(shield)

func _test_shield(shield: Health):
	assert_eq(shield.max_health, 50.0, "Shield max_health is 50.")
	assert_eq(shield.health, 50.0, "Shield health is 50.")
	assert_false(shield.can_die, "Shield can't die.")
	shield.resistance_flat = 10.0
	health.resistance_flat = 10.0
	health.resistance_percent = 25.0
	assert_eq(shield.health, 50.0, "Clamp health down to max_health to stay within limits.")
	assert_false(health.are_shields_cyclic(), "Shields are not cyclic.")
	var result = health.damage(20.0)
	assert_eq(shield.health, 40.0, "Absorb 10 damage, take 10.")
	assert_eq(health.health, 100.0, "Don't take damage if the shield can absorb it.")
	assert_eq(result.shield_result.taken_damage, 10.0, "Shield took 10 damage.")
	assert_eq(result.shield_result.remaining_damage, 0.0, "No remaining damage past the shield.")
	result = health.damage(80.0)
	assert_eq(shield.health, 0.0, "Absorb 10 damage, take 40, 30 remains.")
	assert_eq(health.health, 100.0 - 12.5, "Absorb 7.5 percent and 10 flat damage, take 12.5 damage.")
	assert_eq(result.shield_result.taken_damage, 40.0, "Shield took 40 damage.")
	assert_eq(result.shield_result.remaining_damage, 30.0, "30 damage remains.")
	assert_eq(result.taken_damage, 12.5, "Health took 12.5 damage.")
	assert_signal_emit_count(shield, "died", 0, "Shield can't die.")

func test_shielded_shield():
	var shield1 = Health.new()
	add_child_autofree(shield1)
	watch_signals(shield1)
	health.shield = shield1
	var shield2 = Health.new()
	add_child_autofree(shield2)
	watch_signals(shield2)
	shield1.shield = shield2
	shield2.max_health = 20.0
	shield1.max_health = 50.0
	assert_false(health.are_shields_cyclic(), "Shields are not cyclic.")
	health.damage(30.0)
	assert_true(shield2.is_dead, "Last shield died.")
	assert_eq(shield1.health, shield1.max_health - 10.0, "First shield took 10 damage.")
	assert_eq(health.health, health.max_health, "Health is untouched.")
	shield2.revive()
	shield2.heal(shield2.max_health)
	shield1.heal(shield1.max_health)
	health.damage(80.0)
	assert_true(shield2.is_dead, "Last shield died.")
	assert_true(shield1.is_dead, "First shield died.")
	assert_eq(health.health, health.max_health - 10.0, "Health took 10 damage.")

func test_cyclic_shields():
	var shield1 = Health.new()
	add_child_autofree(shield1)
	watch_signals(shield1)
	health.shield = shield1
	var shield2 = Health.new()
	add_child_autofree(shield2)
	watch_signals(shield2)
	shield1.shield = shield2
	shield2.shield = health
	assert_true(health.are_shields_cyclic(), "Shields are cyclic.")
	health.damage(1.0)
	pass_test("The stack didn't overflow.")
#endregion tests
