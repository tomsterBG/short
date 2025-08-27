# NOTE:
# The timing accuracy greatly increased when i replaced awaits with gut's wait methods and used Time.get_ticks_usec() to account for code execution delays.
# TODO:
# - Test regen more.
# - Test get_seconds_for_full_regen, interrupt_regen, regen_interruption_length, regen_interruption_time.
# IDEAS:
# - Time-dependent testing should happen with Time.get_ticks_msec() for a solid timeframe, preventing accumulation of per-frame delay.
# - Change await for the gut-specific wait.

extends GutTest

var health: HealthPlus

var regen_speed := 3.0
var regen_error := 0.1


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

func test_regen():
	assert_eq(health.health, health.max_health, "Health is full.")
	health.regen_per_second = 90.0 * regen_speed
	health.damage(90)
	assert_eq(health.health, 10.0, "Took 90 damage.")
	assert_false(health.is_regen_interrupted(), "Regen is not interrupted.")
	await wait_seconds(1.0 / regen_speed)
	assert_eq(health.health, health.max_health, "Fully regenerated.")

func test_regen_interrupt():
	health.regen_interruption_length = 1.0 / regen_speed
	
	health.damage(50)
	var start_time = Time.get_ticks_usec()
	health.regen_per_second = 50.0 * regen_speed
	assert_eq(health.health, 50.0, "Took 50 damage.")
	assert_true(health.is_regen_interrupted(), "Regen is interrupted for 1 second.")
	var time_passed = Helpers.usec_to_sec(Time.get_ticks_usec() - start_time)
	
	await wait_seconds(health.regen_interruption_length - time_passed)
	start_time = Time.get_ticks_usec()
	assert_true(health.is_regen_interrupted(), "Regen is still interrupted.")
	assert_eq(health.health, 50.0, "Health didn't change.")
	time_passed = Helpers.usec_to_sec(Time.get_ticks_usec() - start_time)
	
	await wait_seconds(0.5 / regen_speed - time_passed)
	start_time = Time.get_ticks_usec()
	assert_false(health.is_regen_interrupted(), "Regen is not interrupted since 0.5 seconds.")
	assert_between(health.health, 75.0 - (regen_error*regen_speed), 75.0 + (regen_error*regen_speed),\
		"Half regenerated to 75 (50 + 50 * 0.5) +- error.")
	time_passed = Helpers.usec_to_sec(Time.get_ticks_usec() - start_time)
	
	await wait_seconds(0.5 / regen_speed - time_passed)
	assert_false(health.is_regen_interrupted(), "Regen is not interrupted.")
	assert_eq(health.health, health.max_health, "Fully regenerated.")
#endregion tests
