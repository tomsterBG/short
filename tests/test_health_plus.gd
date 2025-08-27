# NOTE:
# The timing accuracy greatly increased when i replaced awaits with gut's wait methods and used Time.get_ticks_usec() to account for code execution delays.
# TODO:
# - Test regen more.
# IDEAS:
# - Time-dependent testing should happen with Time.get_ticks_msec() for a solid timeframe, preventing accumulation of per-frame delay.

extends GutTest

var health: HealthPlus

var regen_error := 0.001


#region virtual methods
func before_each():
	health = HealthPlus.new()
	add_child_autofree(health)
	watch_signals(health)
#endregion virtual methods


#region tests
func test_initial_values():
	assert_eq(health.regen_per_second, 0.0, "Regen per second is 0.")
	assert_eq(health.regen_interruption_length, 0.0, "Regen interruption length is 0.")
	assert_eq(health.regen_interruption_time, 0, "Regen interruption time starts at 0.")

func test_initial_method_values():
	assert_eq(health.get_seconds_for_full_regen(), INF, "Full regen won't be reached.")
	assert_false(health.is_regen_interrupted(), "Regen is not interrupted.")
	assert_eq(health.get_interruption_time_left(), 0.0, "Regen is not interrupted.")

func test_regen():
	assert_eq(health.health, health.max_health, "Health is full.")
	health.regen_per_second = 90.0
	health.damage(90)
	assert_eq(health.health, 10.0, "Took 90 damage.")
	assert_false(health.is_regen_interrupted(), "Regen is not interrupted.")
	health.simulate_regen(1.0)
	assert_eq(health.health, health.max_health, "Fully regenerated.")

func test_regen_interrupt():
	health.regen_interruption_length = 1.0
	health.regen_per_second = 50.0
	
	health.damage(50)
	assert_eq(health.health, 50.0, "Took 50 damage.")
	assert_true(health.is_regen_interrupted(), "Regen is interrupted.")
	assert_almost_eq(health.get_interruption_time_left(), 1.0, regen_error, "Regen is interrupted for 1 second.")
	
	health.simulate_regen(0.5)
	assert_eq(health.health, 50.0, "Health didn't change.")
	assert_true(health.is_regen_interrupted(), "Regen is still interrupted.")
	assert_almost_eq(health.get_interruption_time_left(), 0.5, regen_error, "Regen is still interrupted for 0.5 seconds.")
	
	health.simulate_regen(1.0)
	assert_almost_eq(health.health, 75.0, regen_error, "Half regenerated to 75.")
	assert_false(health.is_regen_interrupted(), "Regen is not interrupted.")
	assert_eq(health.get_interruption_time_left(), 0.0, "Regen is not interrupted since 0.5 seconds.")
	
	health.simulate_regen(0.5)
	assert_eq(health.health, health.max_health, "Fully regenerated.")
	assert_false(health.is_regen_interrupted(), "Regen is not interrupted.")
	assert_eq(health.get_interruption_time_left(), 0.0, "Regen is not interrupted.")
#endregion tests
