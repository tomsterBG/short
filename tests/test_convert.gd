extends GutTest


#region tests
func test_time():
	assert_eq(Convert.sec_to_msec(25.0), 25_000.0)
	assert_eq(Convert.sec_to_usec(999.0), 999_000_000.0)
	assert_eq(Convert.msec_to_sec(999.0), 0.999)
	assert_eq(Convert.usec_to_sec(80_200.0), 0.080_2)

func test_proportion():
	assert_eq(Convert.unit_to_percent(1.75), 175.0)
	assert_eq(Convert.percent_to_unit(0.5), 0.005)

func test_distance():
	assert_eq(Convert.meter_to_mm(0.5), 500.0)
	assert_eq(Convert.mm_to_meter(10.0), 0.01)
	assert_eq(Convert.mm_to_inch(25.4), 1.0)
	assert_eq(Convert.inch_to_mm(2.0), 50.8)

func test_speed():
	assert_eq(Convert.ms_to_kmh(100.0), 360.0)
	assert_eq(Convert.kmh_to_ms(360.0), 100.0)
	assert_eq(Convert.kmh_to_mph(100.0), 62.137_120)
	assert_eq(Convert.mph_to_kmh(20.0), 32.186_880)

func test_angular_speed():
	assert_almost_eq(Convert.rads_to_rpm(2.0), 19.098_593, 0.000_001)

func test_torque():
	assert_almost_eq(Convert.nm_to_lbft(13.0), 9.588_307, 0.000_001)
#endregion tests
