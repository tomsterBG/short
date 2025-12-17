# INFO:
# Each unit test should build on top of the ones before it, for easier troubleshooting.
# TODO:
# - More shield testing, i'm not convinced in its robustness.
# - Testing can_die feels insufficient.
# - Test when all shields die and get revived.
# - Refactor tests. Break them up. Make them more atomic and focused on less things.

extends GutTest


#region constants
const IS_RECURSIVE = true
#endregion constants


#region variables
var health: Health
#endregion variables


#region virtual
func before_each():
	health = Health.new()
	add_child_autofree(health)
	watch_signals(health)
#endregion virtual


#region tests
func test_initial_values():
	assert_eq(health.health, 100.0, "Health is 100.")
	assert_eq(health.max_health, 100.0, "Max_health is 100.")
	assert_eq(health.can_die, true, "Can_die is true.")
	assert_eq(health.is_dead, false, "Is_dead is false.")
	assert_eq(health.is_alive, true, "Is_alive is true.")
	assert_eq(health.resistance_enabled, false, "Resistance is off.")
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
	assert_eq(health.health, health.max_health, "Health can't be above max_health.")
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

func test_signal_not_emitted():
	assert_signal_not_emitted(health, "died")
	assert_signal_not_emitted(health, "health_changed")
	assert_signal_not_emitted(health, "max_health_changed")
	assert_signal_not_emitted(health, "health_reached_max")

func test_init():
	var new_health := Health.new(150.0)
	assert_eq(new_health.health, 150.0, "Health is 150.")
	assert_eq(new_health.max_health, 150.0, "Max_health is 150.")
	new_health.free()
	new_health = Health.new(50.0)
	assert_eq(new_health.health, 50.0, "Health is 50.")
	assert_eq(new_health.max_health, 50.0, "Max_health is 50.")
	new_health.free()
	new_health = Health.new(-50.0)
	assert_eq(new_health.health, 0.0, "Health is 0.")
	assert_eq(new_health.max_health, 0.0, "Max_health is 0.")
	new_health.free()

func test_health_ratio_and_percent():
	health.max_health = 50.0
	assert_eq(health.get_health_ratio(), 1.0, "Full health.")
	assert_eq(health.get_health_percent(), 100.0, "Full health.")
	health.max_health = 100.0
	assert_eq(health.get_health_ratio(), 0.5, "Half health.")
	assert_eq(health.get_health_percent(), 50.0, "Half health.")
	health.max_health = 0.0
	assert_eq(health.get_health_ratio(), 0.0, "No health.")
	assert_eq(health.get_health_percent(), 0.0, "No health.")

func test_get_damage_after_resistance():
	assert_eq(health.get_damage_after_resistance(50.0), 50.0, "No resistance.")
	health.resistance_flat = 10.0
	assert_eq(health.get_damage_after_resistance(50.0), 50.0, "No resistance.")
	health.resistance_enabled = true
	assert_eq(health.get_damage_after_resistance(50.0), 40.0, "Flat resistance.")
	health.resistance_flat = 0.0
	health.resistance_percent = 50.0
	assert_eq(health.get_damage_after_resistance(50.0), 25.0, "Percent resistance.")

func test_damage():
	var result := health.damage(10.0)
	assert_eq(health.health, health.max_health - 10.0, "Take full damage.")
	assert_eq(result.taken_damage, 10.0, "Take full damage.")
	assert_eq(result.remaining_damage, 0.0, "No damage remains.")
	result = health.damage(-10.0)
	assert_eq(health.health, health.max_health - 10.0, "Don't take negative damage.")
	assert_eq(result.taken_damage, 0.0, "Don't take negative damage.")
	assert_eq(result.remaining_damage, 0.0, "No damage remains.")
	result = health.damage(health.max_health * 2)
	assert_eq(health.health, 0.0, "Take damage to 0 health.")
	assert_eq(result.taken_damage, 90.0, "Take damage to 0 health.")
	assert_eq(result.remaining_damage, health.max_health * 2 - result.taken_damage, "Some damage remains.")

func test_heal():
	var result := health.heal(10.0)
	assert_eq(health.health, health.max_health, "Health doesn't change.")
	assert_eq(result.healed_health, 0.0, "Health doesn't change.")
	assert_eq(result.remaining_heal, 10.0, "Some heal remains.")
	health.damage(50.0)
	result = health.heal(20.0)
	assert_eq(health.health, 70.0, "Heal by 20 after taking 50 damage.")
	assert_eq(result.healed_health, 20.0, "Heal by 20.")
	assert_eq(result.remaining_heal, 0.0, "No heal remains.")
	result = health.heal(-20.0)
	assert_eq(health.health, 70.0, "Don't heal negative health.")
	assert_eq(result.healed_health, 0.0, "Don't heal negative health.")
	assert_eq(result.remaining_heal, 0.0, "No heal remains.")

func test_health_changed():
	health.health -= 40.0
	assert_signal_emitted_with_parameters(health, "health_changed", [-40.0])
	health.health = 60.0
	assert_signal_emit_count(health, "health_changed", 1, "Health didn't change.")
	health.damage(30.0)
	assert_signal_emitted_with_parameters(health, "health_changed", [-30.0])
	health.health = 40.0
	assert_signal_emitted_with_parameters(health, "health_changed", [10.0])
	health.heal(20.0)
	assert_signal_emitted_with_parameters(health, "health_changed", [20.0])
	health.damage(health.max_health * 2)
	assert_signal_emitted_with_parameters(health, "health_changed", [-60.0])
	health.heal(health.max_health * 2)
	assert_signal_emitted_with_parameters(health, "health_changed", [100.0])

func test_max_health_changed():
	health.max_health -= 40.0
	assert_signal_emitted_with_parameters(health, "max_health_changed", [-40.0])
	health.max_health = 60.0
	assert_signal_emit_count(health, "max_health_changed", 1, "Max health didn't change.")
	health.max_health = -100.0
	assert_signal_emitted_with_parameters(health, "max_health_changed", [-60.0])
	health.max_health = 200.0
	assert_signal_emitted_with_parameters(health, "max_health_changed", [200.0])

func test_health_reached_max():
	health.health = 50.0
	assert_signal_emit_count(health, "health_reached_max", 0)
	health.health = 75.0
	assert_signal_emit_count(health, "health_reached_max", 0)
	health.health = health.max_health
	assert_signal_emit_count(health, "health_reached_max", 1)

func test_is_dead():
	health.health = 0.0
	assert_true(health.is_dead, "Health is dead.")

func test_is_alive():
	health.health = 0.0
	assert_false(health.is_alive, "Health isn't alive.")

func test_died():
	health.health = 0.0
	assert_signal_emit_count(health, "died", 1, "Health died.")
	health.health = 1.0
	health.health = 0.0
	assert_signal_emit_count(health, "died", 1, "Health was already dead.")

func test_kill():
	health.kill()
	assert_true(health.is_dead, "Health is dead.")
	assert_false(health.is_alive, "Health isn't alive.")
	assert_eq(health.health, health.max_health, "Health is full.")
	assert_signal_emit_count(health, "died", 1, "Health died.")
	health.kill(true)
	assert_true(health.is_dead, "Health was already dead.")
	assert_false(health.is_alive, "Health was already not alive.")
	assert_eq(health.health, 0.0, "Health is empty.")
	assert_signal_emit_count(health, "died", 1, "Health did not die.")

func test_revive():
	health.kill()
	health.revive()
	assert_false(health.is_dead, "Health isn't dead.")
	assert_true(health.is_alive, "Health is alive.")
	assert_eq(health.health, health.max_health, "Health is full.")
	health.kill(true)
	assert_eq(health.health, 0.0, "Health is empty.")
	health.revive(true)
	assert_eq(health.health, health.max_health, "Health is full.")

func test_kill_revive_kill():
	health.kill()
	health.revive()
	health.kill()
	assert_true(health.is_dead, "Health is dead.")
	assert_false(health.is_alive, "Health isn't alive.")
	assert_signal_emit_count(health, "died", 2, "Health died twice.")

func test_can_die():
	health.can_die = false
	health.kill()
	assert_false(health.is_dead, "Health can't die.")
	assert_true(health.is_alive, "Health is alive.")
	assert_eq(health.health, health.max_health, "Health is full.")
	assert_signal_emit_count(health, "died", 0, "Health did not die.")
	health.kill(true)
	assert_false(health.is_dead, "Health can't die.")
	assert_true(health.is_alive, "Health is alive.")
	assert_eq(health.health, 0.0, "Health is empty.")
	assert_signal_emit_count(health, "died", 0, "Health did not die.")

func test_resistance_off():
	var damage := 10.0
	health.resistance_flat = 10.0
	health.health -= damage
	assert_eq(health.health, health.max_health - damage, "Take full damage.")
	health.damage(damage)
	assert_eq(health.health, health.max_health - damage * 2, "Take full damage.")
	health.resistance_flat = 0.0
	health.resistance_percent = 50.0
	health.damage(damage)
	assert_eq(health.health, health.max_health - damage * 3, "Take full damage.")

func test_resistance_flat():
	health.resistance_enabled = true
	health.resistance_flat = 10.0
	health.health -= 10.0
	assert_eq(health.health, health.max_health - 10.0, "Take full damage.")
	var result := health.damage(11.0)
	assert_eq(health.health, health.max_health - 10.0 - 1.0, "Take resisted damage.")
	assert_eq(result.taken_damage, 1.0, "Take resisted damage.")
	health.health = health.max_health
	result = health.damage(105.0)
	assert_eq(health.health, health.max_health - 95.0, "Take resisted damage.")
	assert_eq(result.taken_damage, 95.0, "Take resisted damage.")
	health.resistance_flat = 200.0
	health.health = health.max_health
	result = health.damage(250.0)
	assert_eq(health.health, 50.0, "Take resisted damage.")
	assert_eq(result.taken_damage, 50.0, "Take resisted damage.")
	assert_false(health.is_dead, "Don't die when raw damage is more than max_health.")
	result = health.damage(-240.0)
	assert_eq(health.health, 50.0, "Don't take negative damage.")
	assert_eq(result.taken_damage, 0.0, "Don't take negative damage.")

func test_resistance_percent():
	health.resistance_enabled = true
	health.resistance_percent = 10.0
	health.health -= 50.0
	assert_eq(health.health, health.max_health - 50.0, "Take full damage.")
	var result := health.damage(50.0)
	assert_eq(health.health, health.max_health - 50.0 - 45.0, "Take resisted damage.")
	assert_eq(result.taken_damage, 45.0, "Take resisted damage.")
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
	health.resistance_enabled = true
	health.resistance_order = health.ResistanceOrder.PERCENT_FLAT
	health.resistance_flat = 10.0
	health.resistance_percent = 50.0
	health.health -= 50.0
	assert_eq(health.health, health.max_health - 50.0, "Take 50 damage.")
	var result := health.damage(50.0)
	assert_eq(health.health, health.max_health - 50.0 - 15.0, "Take 15 damage.")
	assert_eq(result.taken_damage, 15.0, "Take 15 damage.")
	result = health.damage(-110.0)
	assert_eq(health.health, health.max_health - 50.0 - 15.0, "Don't take negative damage.")
	assert_eq(result.taken_damage, 0.0, "Don't take negative damage.")

func test_inverted_resistances():
	health.resistance_enabled = true
	health.resistance_order = health.ResistanceOrder.FLAT_PERCENT
	health.resistance_flat = 10.0
	health.resistance_percent = 50.0
	health.health -= 50.0
	assert_eq(health.health, health.max_health - 50.0, "Take 50 damage.")
	var result := health.damage(50.0)
	assert_eq(health.health, health.max_health - 50.0 - 20.0, "Take 20 damage.")
	assert_eq(result.taken_damage, 20.0, "Take 20 damage.")
	result = health.damage(-110.0)
	assert_eq(health.health, health.max_health - 50.0 - 20.0, "Don't take negative damage.")
	assert_eq(result.taken_damage, 0.0, "Don't take negative damage.")

func test_make_shield_without_method():
	var shield := Health.new()
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
	shield.resistance_enabled = true
	shield.resistance_flat = 10.0
	health.resistance_enabled = true
	health.resistance_flat = 10.0
	health.resistance_percent = 25.0
	assert_eq(shield.health, 50.0, "Clamp health down to max_health to stay within limits.")
	assert_false(health.are_shields_cyclic(), "Shields are not cyclic.")
	var result := health.damage(20.0, IS_RECURSIVE)
	assert_eq(shield.health, 40.0, "Absorb 10 damage, take 10.")
	assert_eq(health.health, 100.0, "Don't take damage if the shield can absorb it.")
	assert_eq(result.shield_result.taken_damage, 10.0, "Shield took 10 damage.")
	assert_eq(result.shield_result.remaining_damage, 0.0, "No remaining damage past the shield.")
	result = health.damage(80.0, IS_RECURSIVE)
	assert_eq(shield.health, 0.0, "Absorb 10 damage, take 40, 30 remains.")
	assert_eq(health.health, 100.0 - 12.5, "Absorb 7.5 percent and 10 flat damage, take 12.5 damage.")
	assert_eq(result.shield_result.taken_damage, 40.0, "Shield took 40 damage.")
	assert_eq(result.shield_result.remaining_damage, 30.0, "30 damage remains.")
	assert_eq(result.taken_damage, 12.5, "Health took 12.5 damage.")
	assert_signal_emit_count(shield, "died", 0, "Shield can't die.")

func test_shielded_shield():
	var shield1 := Health.new()
	add_child_autofree(shield1)
	watch_signals(shield1)
	health.shield = shield1
	var shield2 := Health.new()
	add_child_autofree(shield2)
	watch_signals(shield2)
	shield1.shield = shield2
	shield2.max_health = 20.0
	shield1.max_health = 50.0
	assert_false(health.are_shields_cyclic(), "Shields are not cyclic.")
	health.damage(30.0, IS_RECURSIVE)
	assert_true(shield2.is_dead, "Last shield died.")
	assert_eq(shield1.health, shield1.max_health - 10.0, "First shield took 10 damage.")
	assert_eq(health.health, health.max_health, "Health is untouched.")
	shield2.revive()
	shield2.heal(shield2.max_health)
	shield1.heal(shield1.max_health)
	health.damage(80.0, IS_RECURSIVE)
	assert_true(shield2.is_dead, "Last shield died.")
	assert_true(shield1.is_dead, "First shield died.")
	assert_eq(health.health, health.max_health - 10.0, "Health took 10 damage.")

func test_cyclic_shields():
	var shield1 := Health.new()
	add_child_autofree(shield1)
	watch_signals(shield1)
	health.shield = shield1
	var shield2 := Health.new()
	add_child_autofree(shield2)
	watch_signals(shield2)
	shield1.shield = shield2
	shield2.shield = health
	assert_false(health.are_shields_cyclic(), "Shields aren't cyclic.")
	assert_eq(shield2.shield, null, "The shield reverted itself.")
	health.damage(1.0, IS_RECURSIVE)
	health.kill(false, IS_RECURSIVE)
	health.revive(false, IS_RECURSIVE)
	# Test shield reverting itself:
	shield1.shield = shield1
	assert_eq(shield1.shield, shield2, "The shield reverted itself.")
	pass_test("The stack didn't overflow.")

func test_kill_recursive():
	var shield1 := health.make_shield()
	shield1.can_die = true
	var shield2 := shield1.make_shield()
	shield2.can_die = true
	assert_false(health.is_dead, "Health isn't dead.")
	assert_false(shield1.is_dead, "Shield1 isn't dead.")
	assert_false(shield2.is_dead, "Shield2 isn't dead.")
	shield1.kill(false, IS_RECURSIVE)
	assert_false(health.is_dead, "Health isn't dead.")
	assert_true(shield1.is_dead, "Shield1 is dead.")
	assert_true(shield2.is_dead, "Shield2 is dead.")

func test_revive_recursive():
	var shield1 := health.make_shield()
	shield1.can_die = true
	var shield2 := shield1.make_shield()
	shield2.can_die = true
	health.kill(false, IS_RECURSIVE)
	assert_true(health.is_dead, "Health is dead.")
	assert_true(shield1.is_dead, "Shield1 is dead.")
	assert_true(shield2.is_dead, "Shield2 is dead.")
	shield1.revive(false, IS_RECURSIVE)
	assert_true(health.is_dead, "Health is dead.")
	assert_false(shield1.is_dead, "Shield1 isn't dead.")
	assert_false(shield2.is_dead, "Shield2 isn't dead.")
#endregion tests
