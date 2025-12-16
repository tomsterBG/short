# NOTE:
# The timing accuracy greatly increased when i replaced awaits with gut's wait methods and used Time.get_ticks_usec() to account for code execution delays.
# TODO:
# - Test regen more.
# IDEAS:
# - Time-dependent testing should happen with Time.get_ticks_msec() for a solid timeframe, preventing accumulation of per-frame delay.

extends GutTest


#region variables
var health: Health
var health_regen: HealthRegen
#endregion variables


#region virtual
func before_each():
	health = Health.new()
	health_regen = HealthRegen.new()
	add_child_autofree(health)
	add_child_autofree(health_regen)
	watch_signals(health)
	watch_signals(health_regen)
	
	health_regen.health = health
#endregion virtual


#region tests
func test_initial_values():
	assert_eq(health_regen.health, health, "Health from before each.")
	assert_eq(health_regen.regen_enabled, true, "Regen is on.")
	assert_eq(health_regen.regen_in_editor, false, "Regen in editor is off.")
	assert_eq(health_regen.regen_in__process, true, "Regen in _process is on.")
	assert_eq(health_regen.regen_per_second, 0.0, "Regen per second is 0.")
	assert_eq(health_regen.regen_pause_for, 0.0, "Regen pause for 0.")
	assert_eq(health_regen.regen_paused_at, -1_000_000_000_000_000, "Regen paused at -1_000_000_000_000_000.")
	assert_eq(health_regen.regen_pause_when_damaged, true, "Regen pauses when health is damaged.")

func test_initial_method_values():
	assert_eq(health_regen.get_seconds_for_full_regen(), INF, "Won't regen.")
	assert_false(health_regen.is_regen_paused(), "Regen is not paused.")
	assert_eq(health_regen.get_pause_time_left(), 0.0, "No pause time.")

func test_regen_paused_at():
	health_regen.regen_pause_for = 1.0
	health_regen.pause_regen()
	assert_eq(health_regen.regen_paused_at, Time.get_ticks_msec(), "Paused now.")

func test_get_seconds_for_full_regen():
	health_regen.regen_per_second = health.max_health / 2.0
	assert_eq(health_regen.get_seconds_for_full_regen(), 2.0, "Full in 2 seconds.")
	health_regen.regen_enabled = false
	assert_eq(health_regen.get_seconds_for_full_regen(), INF, "Won't regen.")

func test_get_time_since_pause():
	health_regen.regen_pause_for = 1.0
	health_regen.pause_regen()
	assert_eq(health_regen.get_time_since_pause(), 0.0, "No time since pause.")
	health_regen.regen_per_second = 1.0
	health_regen.simulate_regen(1.0)
	assert_eq(health_regen.get_time_since_pause(), Convert.sec_to_msec(1.0), "A second since pause.")

func test_is_regen_paused():
	health_regen.pause_regen()
	assert_false(health_regen.is_regen_paused(), "Regen is not paused.")
	health_regen.regen_per_second = 1.0
	health_regen.regen_pause_for = 1.0
	health_regen.pause_regen()
	assert_true(health_regen.is_regen_paused(), "Regen is paused.")
	health_regen.simulate_regen(2.0)
	assert_false(health_regen.is_regen_paused(), "Regen is not paused.")

func test_regen_per_second():
	health_regen.regen_in__process = false
	health_regen.regen_per_second = 90.0
	health.damage(90)
	health_regen.simulate_regen(0.5)
	assert_eq(health.health, 55.0, "Half regenerated.")
	health_regen.simulate_regen(0.5)
	assert_eq(health.health, health.max_health, "Fully regenerated.")

func test_regen_enabled():
	health_regen.regen_enabled = false
	health_regen.regen_per_second = 80.0
	health.damage(80)
	health_regen.simulate_regen(100.0)
	assert_eq(health.health, 20.0, "Health didn't change.")

func test_regen_pause_for():
	health_regen.regen_in__process = false
	health_regen.regen_per_second = 60.0
	health_regen.regen_pause_for = 2.0
	health.damage(60)
	assert_eq(health_regen.get_pause_time_left(), 2.0, "Regen is paused for 2 seconds.")
	health_regen.simulate_regen(1.5)
	assert_eq(health.health, 40.0, "Health didn't change.")
	assert_eq(health_regen.get_pause_time_left(), 0.5, "Regen is paused for 0.5 seconds.")
	health_regen.simulate_regen(1.0)
	assert_eq(health.health, 70.0, "Half regenerated to 70.")
	assert_eq(health_regen.get_pause_time_left(), 0.0, "Regen is not paused since 0.5 seconds.")

func test_regen_pause_when_damaged():
	health_regen.regen_in__process = false
	health_regen.regen_per_second = 40.0
	health_regen.regen_pause_for = 100.0
	health_regen.regen_pause_when_damaged = false
	health.damage(40)
	assert_eq(health_regen.get_pause_time_left(), 0.0, "Regen is not paused.")
	health_regen.simulate_regen(1.0)
	assert_eq(health.health, health.max_health, "Fully regenerated.")

func test_health_goes_null():
	health_regen.regen_per_second = 10.0
	var disposable_health = Health.new()
	health_regen.health = disposable_health
	disposable_health.free()
	assert_false(is_instance_valid(disposable_health), 'Health is "previously freed".')
	var result := health_regen.simulate_regen(1.0)
	assert_false(result.success, "Failed, health is freed.")
	assert_null(result.heal_result, "No healing occurred.")
#endregion tests
