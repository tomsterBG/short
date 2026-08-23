extends GutTest


#region tests
func test_constants():
	assert_eq(Physics.GRAVITY_CONSTANT, 6.6743e-11, "6.6743e-11 ((N * m^2)/(kg^2))")
	assert_eq(Physics.EARTH_GRAVITY, 9.80665, "Gravity (Earth) = 9.80665 (m/s^2)")
	assert_eq(Physics.EARTH_RADIUS, 6371_000.0, "Radius (Earth) = 6371_000 (m)")
	assert_eq(Physics.EARTH_MASS, 5.972e24, "Mass (Earth) = 5.972e24 (kg)")
	assert_eq(Physics.EARTH_AIR_PRESSURE, 1.0, "Pressure (Earth) = 1 (atm)")
	assert_eq(Physics.MARS_GRAVITY, 3.728, "Gravity (Mars) = 3.728 (m/s^2)")
	assert_eq(Physics.MARS_MASS, 6.41693e23, "Mass (Mars) = 6.41693e23 (kg)")

func test_gravity_between():
	assert_almost_eq(Physics.gravity_between(50.0, 80.0, 2.0), 6.6743e-8, 1.0e-20, "Force between 2 point masses.")

func test_earth_gravity():
	assert_eq(Physics.earth_gravity(0.0), Physics.EARTH_GRAVITY, "Gravity at sea level.")
	assert_almost_eq(Physics.earth_gravity(1000_000.0), 7.326_272, GConst.ERROR_INTERVAL, "Gravity at 1000 km.")
#endregion tests
