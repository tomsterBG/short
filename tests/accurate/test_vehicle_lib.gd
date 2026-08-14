extends GutTest


#region tests
func test_wheel_slip_ratiof():
	assert_eq(VehicleLib.wheel_slip_ratiof(100.0, 100.0, 1.0), 0.0, "Not slipping.")
	assert_eq(VehicleLib.wheel_slip_ratiof(100.0, 0.0, 1.0), -1.0, "Locked up.")
	assert_eq(VehicleLib.wheel_slip_ratiof(0.0, 0.0, 1.0), 0.0, "Stopped, not slipping.")
	assert_eq(VehicleLib.wheel_slip_ratiof(100.0, 50.0, 1.0), -0.5, "Half locked.")
	assert_eq(VehicleLib.wheel_slip_ratiof(100.0, 150.0, 1.0), 0.5, "Wheelspin.")
	assert_eq(VehicleLib.wheel_slip_ratiof(1.0, 10.0, 1.0), 9.0, "Slow wheelspin.")
#endregion tests
