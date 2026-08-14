extends GutTest


#region variables
var antilock_braking: AntilockBraking
#endregion variables


#region virtual
func before_each():
	antilock_braking = AntilockBraking.new()
	add_child_autofree(antilock_braking)
	watch_signals(antilock_braking)
#endregion virtual


#region tests
func test_initial_values():
	assert_eq(antilock_braking.target_slip, -0.12, "Target slip is 12%.")
	assert_eq(antilock_braking.cycles_per_second, 10, "Cycles per second are 10.")

func test_initial_method_values():
	assert_eq(antilock_braking.cycle_time(), 0.1, "Cycle time is 1/10.")
#endregion tests
