extends GutTest


#region tests
func test_time_conversions():
	assert_eq(Convert.sec_to_msec(25), 25_000.0, "Milliseconds is seconds * 1000.")
	assert_eq(Convert.sec_to_usec(999), 999_000_000.0, "Microseconds is seconds * 1000_000.")
	assert_eq(Convert.msec_to_sec(999), 0.999, "Seconds is milliseconds / 1000.")
	assert_eq(Convert.usec_to_sec(80_200), 0.080_2, "Seconds is microseconds / 1000_000.")

func test_proportion_conversions():
	assert_eq(Convert.unit_to_percent(1.75), 175.0, "Percentages are units * 100.")
	assert_eq(Convert.percent_to_unit(0.5), 0.005, "Units are percentages / 100.")

func test_distance_conversions():
	assert_eq(Convert.meter_to_mm(0.5), 500.0, "Millimeters are meters * 1000.")
	assert_eq(Convert.mm_to_meter(10.0), 0.01, "Meters are millimeters / 1000.")
	assert_eq(Convert.mm_to_inch(25.4), 1.0, "Inches are millimeters / 25.4.")
	assert_eq(Convert.inch_to_mm(2.0), 50.8, "Millimeters are inches * 25.4.")

func test_speed_conversions():
	assert_eq(Convert.ms_to_kmh(100.0), 360.0, "Km/h are meters/second * 3.6.")
	assert_eq(Convert.kmh_to_ms(360.0), 100.0, "Meters/second are km/h / 3.6.")
	assert_eq(Convert.kmh_to_mph(100.0), 62.13712, "Mph are km/h * 0.6213712.")
	assert_eq(Convert.mph_to_kmh(20.0), 32.18688, "Km/h are mph * 1.609344.")
#endregion tests
