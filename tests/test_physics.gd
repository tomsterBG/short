extends GutTest


#region tests
func test_constants():
	assert_eq(Physics.EARTH_GRAVITY, 9.80665, "Gravity (Earth) = 9.80665 (m/s^2)")
	assert_eq(Physics.EARTH_RADIUS, 6_371_000, "Radius (Earth) = 6_371_000 (m)")
	assert_eq(Physics.EARTH_MASS, 5.972 * pow(10, 24), "Mass (Earth) = 5.972 * pow(10, 24) (kg)")
#endregion tests
