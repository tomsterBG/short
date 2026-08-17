extends GutTest


#region variables
var antilock_braking: AntilockBraking
var sensor_info: AntilockBraking.SensorInfo
#endregion variables


#region virtual
func before_each():
	antilock_braking = AntilockBraking.new()
	add_child_autofree(antilock_braking)
	watch_signals(antilock_braking)
	sensor_info = AntilockBraking.SensorInfo.new()
#endregion virtual


#region tests
func test_initial_values():
	assert_eq(antilock_braking.target_slip, -0.12, "Target slip is 12%.")
	assert_eq(antilock_braking.cycles_per_second, 10, "Cycles per second are 10.")
	assert_eq(antilock_braking.sensor_info, [], "Sensor info is empty.")
	assert_eq(antilock_braking.cycle_time_left, 0.0, "Abs cycle time left is 0.")

func test_initial_method_values():
	assert_eq(antilock_braking.cycle_time(), 0.1, "Cycle time is 1/10.")

func test_sensor_info_initial_values():
	assert_eq(sensor_info.slip_ratio, 0.0, "Not slipping.")
	assert_eq(sensor_info.input_brake_ratio, 0.0, "Not braking.")
	assert_eq(sensor_info.abs_cycle, AntilockBraking.ABSCycle.PASS, "Doing nothing.")
	assert_eq(sensor_info.output_brake_ratio, 0.0, "Not braking.")

func test_value_clamping():
	antilock_braking.target_slip = 1.0
	assert_eq(antilock_braking.target_slip, 0.0, "Target slip can't be positive.")
	antilock_braking.target_slip = -2.0
	assert_eq(antilock_braking.target_slip, -1.0, "Target slip can't be below -1.")
	
	antilock_braking.cycle_time_left = 1.0
	assert_almost_eq(antilock_braking.cycle_time_left, antilock_braking.cycle_time(), GConst.ERROR_INTERVAL, "Cycle time left can't be more than cycle time, wraps to cycle time.")
	antilock_braking.cycle_time_left = -1.0
	assert_almost_eq(antilock_braking.cycle_time_left, 0.0, GConst.ERROR_INTERVAL, "Cycle time left can't be negative, wraps to 0.")
	
	# SensorInfo
	sensor_info.slip_ratio = 1.0
	assert_eq(sensor_info.slip_ratio, 0.0, "Slip ratio can't be positive.")
	sensor_info.slip_ratio = -2.0
	assert_eq(sensor_info.slip_ratio, -1.0, "Slip ratio can't be below -1.")
	
	sensor_info.input_brake_ratio = 2.0
	assert_eq(sensor_info.input_brake_ratio, 1.0, "Input brake ratio can't be above 1.")
	sensor_info.input_brake_ratio = -1.0
	assert_eq(sensor_info.input_brake_ratio, 0.0, "Input brake ratio can't be negative.")
	
	sensor_info.output_brake_ratio = 2.0
	assert_eq(sensor_info.output_brake_ratio, 1.0, "Output brake ratio can't be above 1.")
	sensor_info.output_brake_ratio = -1.0
	assert_eq(sensor_info.output_brake_ratio, 0.0, "Output brake ratio can't be negative.")

func test_cycle_time_left() -> void:
	antilock_braking.simulate_abs(0.015625)
	assert_eq(antilock_braking.cycle_time_left, 0.084375, "Cycle time left becomes 0.084375.")
#endregion tests
