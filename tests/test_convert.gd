extends GutTest


#region constants
const ERROR_INTERVAL := 0.000_001
#endregion constants


#region tests
func test_time():
	assert_eq(Convert.sec_to_msec(25.0), 25_000.0)
	assert_eq(Convert.sec_to_usec(999.0), 999_000_000.0)
	assert_eq(Convert.msec_to_sec(999.0), 0.999)
	assert_eq(Convert.usec_to_sec(80_200.0), 0.080_2)
	assert_eq(Convert.sec_to_min(90.0), 1.5)
	assert_eq(Convert.min_to_sec(60.0), 3600.0)
	assert_eq(Convert.min_to_h(45.0), 0.75)
	assert_eq(Convert.h_to_min(2.2), 132.0)
	assert_eq(Convert.sec_to_h(1800.0), 0.5)
	assert_eq(Convert.h_to_sec(0.25), 900.0)
	assert_eq(Convert.sec_to_day(21600.0), 0.25)
	assert_eq(Convert.day_to_sec(0.5), 43200.0)
	assert_eq(Convert.sec_to_week(756000.0), 1.25)
	assert_eq(Convert.week_to_sec(0.7), 423360.0)
	assert_eq(Convert.day_to_week(21.0), 3.0)
	assert_eq(Convert.week_to_day(4.0), 28.0)
	assert_eq(Convert.day_to_year(730.5), 2.0)
	assert_eq(Convert.year_to_day(0.5), 182.625)

func test_proportion():
	assert_eq(Convert.unit_to_percent(1.75), 175.0)
	assert_eq(Convert.percent_to_unit(0.5), 0.005)

func test_number_base():
	assert_eq(Convert.bin_to_dec("11001"), 25)

func test_distance():
	assert_eq(Convert.meter_to_mm(0.5), 500.0)
	assert_eq(Convert.mm_to_meter(10.0), 0.01)
	assert_eq(Convert.mm_to_inch(25.4), 1.0)
	assert_eq(Convert.inch_to_mm(2.0), 50.8)
	assert_eq(Convert.meter_to_inch(50.8), 2000.0)
	assert_eq(Convert.inch_to_meter(291.0), 7.3914)
	assert_eq(Convert.radius_to_diameter(68.0), 136.0)
	assert_eq(Convert.diameter_to_radius(54.0), 27.0)

func test_speed():
	assert_eq(Convert.ms_to_kmh(100.0), 360.0)
	assert_eq(Convert.kmh_to_ms(360.0), 100.0)
	assert_almost_eq(Convert.kmh_to_mph(100.0), 62.137_119, ERROR_INTERVAL)
	assert_almost_eq(Convert.mph_to_kmh(20.0), 32.186_88, ERROR_INTERVAL)

func test_angular_speed():
	assert_eq(Convert.rads_to_rpm(TAU), 60.0)
	assert_eq(Convert.rpm_to_rads(30.0), PI)
	assert_eq(Convert.hz_to_rpm(90.0), 5400.0)
	assert_eq(Convert.rpm_to_hz(720.0), 12.0)

func test_acceleration():
	assert_eq(Convert.ms2_to_kms2(98.0), 0.098)
	assert_eq(Convert.kms2_to_ms2(0.21), 210.0)

func test_torque():
	assert_almost_eq(Convert.nm_to_lbft(13.0), 9.588_307, ERROR_INTERVAL)
	assert_almost_eq(Convert.lbft_to_nm(3.0), 4.067_453, ERROR_INTERVAL)

func test_power():
	assert_eq(Convert.w_to_kw(995.0), 0.995)
	assert_eq(Convert.kw_to_w(0.69), 690.0)
	assert_eq(Convert.kw_to_mw(41.0), 0.041)
	assert_eq(Convert.mw_to_kw(0.13), 130.0)
	assert_almost_eq(Convert.hp_to_kw(37.0), 27.590_895, ERROR_INTERVAL)
	assert_almost_eq(Convert.kw_to_hp(75.0), 100.576_656, ERROR_INTERVAL)
	assert_almost_eq(Convert.hp_to_w(37.0), 27590.895_249, ERROR_INTERVAL)
	assert_almost_eq(Convert.w_to_hp(75.0), 0.100_576, ERROR_INTERVAL)

func test_energy():
	assert_eq(Convert.j_to_kwh(63459.0), 0.0176275)
	assert_eq(Convert.kwh_to_j(0.041), 147600.0)

func test_temperature():
	assert_eq(Convert.c_to_k(50.0), 323.15)
	assert_eq(Convert.k_to_c(303.15), 30.0)
	assert_eq(Convert.c_to_f(10.0), 50.0)
	assert_eq(Convert.f_to_c(122.0), 50.0)

func test_mass():
	assert_eq(Convert.kg_to_t(43.0), 0.043)
	assert_eq(Convert.t_to_kg(2.41), 2410.0)
	assert_eq(Convert.kg_to_g(0.2), 200.0)
	assert_eq(Convert.g_to_kg(184.0), 0.184)

func test_multiple_units():
	assert_almost_eq(Convert.lbft_rpm_to_hp(100.0, 60.0), 1.142_421, ERROR_INTERVAL)
	assert_almost_eq(Convert.nm_rpm_to_w(10.0, 1.0), 1.047_252, ERROR_INTERVAL)
	assert_eq(Convert.w_sec_to_j(6.0, 3.0), 18.0)

func test_convert_and_back():
	# time
	assert_eq(Convert.sec_to_msec(Convert.msec_to_sec(23.4)), 23.4)
	assert_eq(Convert.sec_to_usec(Convert.usec_to_sec(23.4)), 23.4)
	assert_eq(Convert.sec_to_min(Convert.min_to_sec(41.5)), 41.5)
	assert_eq(Convert.min_to_h(Convert.h_to_min(17.4)), 17.4)
	assert_eq(Convert.sec_to_h(Convert.h_to_sec(741.2)), 741.2)
	assert_eq(Convert.sec_to_day(Convert.day_to_sec(8241.0)), 8241.0)
	assert_eq(Convert.sec_to_week(Convert.week_to_sec(941.0)), 941.0)
	assert_eq(Convert.day_to_week(Convert.week_to_day(284.0)), 284.0)
	assert_eq(Convert.day_to_year(Convert.year_to_day(718.0)), 718.0)
	# proportion
	assert_eq(Convert.unit_to_percent(Convert.percent_to_unit(23.4)), 23.4)
	# distance
	assert_eq(Convert.meter_to_mm(Convert.mm_to_meter(52.9)), 52.9)
	assert_eq(Convert.mm_to_inch(Convert.inch_to_mm(23.4)), 23.4)
	assert_eq(Convert.meter_to_inch(Convert.inch_to_meter(68.1)), 68.1)
	assert_eq(Convert.radius_to_diameter(Convert.diameter_to_radius(49.1)), 49.1)
	# speed
	assert_eq(Convert.ms_to_kmh(Convert.kmh_to_ms(23.4)), 23.4)
	assert_eq(Convert.kmh_to_mph(Convert.mph_to_kmh(100.0)), 100.0)
	# angular_speed
	assert_eq(Convert.rads_to_rpm(Convert.rpm_to_rads(3.12)), 3.12)
	assert_eq(Convert.rpm_to_hz(Convert.hz_to_rpm(8.31)), 8.31)
	# acceleration
	assert_eq(Convert.ms2_to_kms2(Convert.kms2_to_ms2(17.3)), 17.3)
	# torque
	assert_eq(Convert.nm_to_lbft(Convert.lbft_to_nm(40.8)), 40.8)
	# power
	assert_eq(Convert.w_to_kw(Convert.kw_to_w(23.4)), 23.4)
	assert_eq(Convert.kw_to_mw(Convert.mw_to_kw(72.1)), 72.1)
	assert_eq(Convert.hp_to_kw(Convert.kw_to_hp(28.2)), 28.2)
	assert_eq(Convert.hp_to_w(Convert.w_to_hp(99.9)), 99.9)
	# energy
	assert_eq(Convert.j_to_kwh(Convert.kwh_to_j(742.1)), 742.1)
	# temperature
	assert_eq(Convert.c_to_k(Convert.k_to_c(23.0)), 23.0)
	assert_eq(Convert.c_to_f(Convert.f_to_c(94.2)), 94.2)
	# mass
	assert_eq(Convert.kg_to_t(Convert.t_to_kg(831.14)), 831.14)
	assert_eq(Convert.kg_to_g(Convert.g_to_kg(74.12)), 74.12)
#endregion tests
