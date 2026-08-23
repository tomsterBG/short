extends GutTest


#region tests
func test_constants():
	assert_eq(Physics.GRAVITY_CONSTANT, 6.6743e-11, "6.6743e-11 ((N * m^2)/(kg^2))")
	assert_eq(Physics.GAS_CONSTANT, 8.314_462_618_153_24, "8.314_462_618_153_24 (J * (mol * K))")
	assert_eq(Physics.DRY_AIR_MOLAR_MASS, 0.028_946, "0.028_946 (kg/mol)")
	assert_eq(Physics.EARTH_GRAVITY, 9.80665, "Gravity (Earth) = 9.80665 (m/s^2)")
	assert_eq(Physics.EARTH_RADIUS, 6371_000.0, "Radius (Earth) = 6371_000 (m)")
	assert_eq(Physics.EARTH_MASS, 5.972e24, "Mass (Earth) = 5.972e24 (kg)")
	assert_eq(Physics.EARTH_AIR_PRESSURE, 1.0, "Pressure (Earth) = 1 (atm)")
	assert_eq(Physics.EARTH_AIR_TEMPERATURE_LAPSE_RATE, 0.0065, "Temperature (Earth) = 0.0065 (K/m)")
	assert_eq(Physics.MARS_GRAVITY, 3.728, "Gravity (Mars) = 3.728 (m/s^2)")
	assert_eq(Physics.MARS_MASS, 6.41693e23, "Mass (Mars) = 6.41693e23 (kg)")

func test_gravity_between():
	assert_almost_eq(Physics.gravity_between(50.0, 80.0, 2.0), 6.6743e-8, 1.0e-20, "Force between 2 point masses.")

func test_earth_gravity():
	assert_eq(Physics.earth_gravity(0.0), Physics.EARTH_GRAVITY, "Gravity at sea level.")
	assert_almost_eq(Physics.earth_gravity(1000_000.0), 7.326_272, GConst.ERROR_INTERVAL, "Gravity at 1000 km.")

func test_earth_air_pressure():
	assert_eq(Physics.earth_air_pressure(0.0, 15.0), 1.0, "Standard atmosphere assumes 15°C.")
	assert_almost_eq(Physics.earth_air_pressure(5_000.0, 15.0), 0.533_353, GConst.ERROR_INTERVAL, "At 5km summit.")
	assert_almost_eq(Physics.earth_air_pressure(11_000.0, 15.0), 0.223_579, GConst.ERROR_INTERVAL, "At 11km jet cruise.")
#endregion tests
