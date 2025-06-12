# TODO:
# - test regen more
# - test get_seconds_for_full_regen, interrupt_regen, regen_interruption_length, regen_interruption_time, is_regen_interrupted

extends GutTest

var health: HealthPlus


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
	health.damage(90)
	health.regen_per_second = 90.0
	assert_eq(health.health, 10.0, "Took 90 damage.")
	assert_false(health.is_regen_interrupted(), "Regen is not interrupted.")
	await get_tree().create_timer(1.0).timeout
	assert_true(health.health == health.max_health, "Fully regenerated.")

func test_regen_interrupt():
	health.regen_interruption_length = 1.0
	health.damage(50)
	health.regen_per_second = 50.0
	assert_eq(health.health, 50.0, "Took 50 damage.")
	assert_true(health.is_regen_interrupted(), "Regen is interrupted for 1 second.")
	await get_tree().create_timer(0.9).timeout
	assert_true(health.is_regen_interrupted(), "Regen is still interrupted.")
	assert_eq(health.health, 50.0, "Health didn't change.")
	await get_tree().create_timer(0.5).timeout
	assert_false(health.is_regen_interrupted(), "Regen is not interrupted since 0.4 seconds.")
	assert_between(health.health, 69.0, 71.0, "Half regenerated to 70 (50 + 50 * 0.4).")
	await get_tree().create_timer(0.65).timeout
	assert_false(health.is_regen_interrupted(), "Regen is not interrupted.")
	assert_eq(health.health, health.max_health, "Fully regenerated.")
#endregion tests
