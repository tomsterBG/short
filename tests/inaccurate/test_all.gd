extends GutTest


#region constants
const IS_RECURSIVE := true
#endregion constants


#region virtual
func test_health_many_shields():
	var health := Health.new()
	var start_time := Time.get_ticks_usec()
	var current_shield := health.make_shield()
	for i in 1016:
		current_shield = current_shield.make_shield()
	health.damage(10.0, IS_RECURSIVE)
	assert_lt(Time.get_ticks_usec() - start_time, 20_000, "Performance didn't explode.")
	health.free()
#endregion virtual
