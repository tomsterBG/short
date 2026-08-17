extends GutTest


#region tests
func test_wheel_slip_ratiof():
	assert_eq(VehicleLib.wheel_slip_ratiof(100.0, 100.0, 1.0), 0.0, "Not slipping.")
	assert_eq(VehicleLib.wheel_slip_ratiof(100.0, 0.0, 1.0), -1.0, "Locked up.")
	assert_eq(VehicleLib.wheel_slip_ratiof(0.0, 0.0, 1.0), 0.0, "Stopped, not slipping.")
	assert_eq(VehicleLib.wheel_slip_ratiof(100.0, 50.0, 1.0), -0.5, "Half locked.")
	assert_eq(VehicleLib.wheel_slip_ratiof(100.0, 150.0, 1.0), 0.5, "Wheelspin.")
	assert_eq(VehicleLib.wheel_slip_ratiof(1.0, 10.0, 1.0), 9.0, "Slow wheelspin.")

func test_bsfc():
	assert_eq(VehicleLib.bsfc(10_800.0, 90.0), 120.0, "10_800 g/hr giving 90 kW = 120 g/kWh")

func test_icr2():
	# NOTE: For a transform that looks right, the icr for a right turn with radius of 5 should be 5 to the local right, or 5 to the global down.
	assert_eq(VehicleLib.icr2(Transform2D(0.0, Vector2(12.0, 7.0)), 5.0), Vector2(12.0, 12.0))
	# NOTE: For a transform rotated to look downwards, the icr for a right turn with radius of 5 should be 5 to the local right, or 5 to the global left.
	assert_eq(VehicleLib.icr2(Transform2D(PI / 2, Vector2(12.0, 7.0)), 5.0), Vector2(7.0, 7.0))
	# NOTE: For a transform rotated to look downwards, the icr for a left turn with radius of 5 should be 5 to the local left, or 5 to the global right.
	assert_eq(VehicleLib.icr2(Transform2D(PI / 2, Vector2(12.0, 7.0)), -5.0), Vector2(17.0, 7.0))

func test_icr2_from_steering_point():
	# NOTE: Parallel lines.
	assert_eq(VehicleLib.icr2_from_steering_point(Transform2D(0.0, Vector2.ZERO), Transform2D(0.0, Vector2.RIGHT)), null)
	# NOTE: Right turn.
	assert_eq(VehicleLib.icr2_from_steering_point(Transform2D(0.0, Vector2.ZERO), Transform2D(deg_to_rad(30.0), Vector2.RIGHT)), Vector2.DOWN * sqrt(3))
	# NOTE: Left turn.
	assert_eq(VehicleLib.icr2_from_steering_point(Transform2D(0.0, Vector2.ZERO), Transform2D(deg_to_rad(-30.0), Vector2.RIGHT)), Vector2.UP * sqrt(3))

func test_ackermann2():
	# NOTE: For a transform that looks right and a wheel 1 meter forward, the steering angle for a right turn with radius of 1 should be 45 degrees.
	assert_eq(VehicleLib.icr2(Transform2D(0.0, Vector2(4.0, 5.0)), 1.0), Vector2(4.0, 6.0))
	assert_almost_eq(VehicleLib.ackermann2(Transform2D(0.0, Vector2(4.0, 5.0)), [Vector2(5.0, 5.0)], 1.0)[0], deg_to_rad(45.0), GConst.ERROR_INTERVAL)
	# NOTE: For a transform that looks right and a wheel 1 meter forward, the steering angle for a right turn with radius of INF should be 0.0 degrees.
	assert_almost_eq(VehicleLib.ackermann2(Transform2D(0.0, Vector2(4.0, 5.0)), [Vector2(5.0, 5.0)], INF)[0], deg_to_rad(0.0), GConst.ERROR_INTERVAL)
	# NOTE: For a transform that looks right and a wheel 1 meter forward, the steering angle for a left turn with radius of -INF should be 0.0 degrees.
	assert_almost_eq(VehicleLib.ackermann2(Transform2D(0.0, Vector2(4.0, 5.0)), [Vector2(5.0, 5.0)], -INF)[0], deg_to_rad(0.0), GConst.ERROR_INTERVAL)
	# NOTE: For a transform that looks right and a wheel 1 meter forward, the steering angle for a left turn with radius of -1 should be -45 degrees.
	assert_almost_eq(VehicleLib.ackermann2(Transform2D(0.0, Vector2(4.0, 5.0)), [Vector2(5.0, 5.0)], -1.0)[0], deg_to_rad(-45.0), GConst.ERROR_INTERVAL)
	# NOTE: For a transform that looks up and a wheel 1 meter forward, the steering angle for a left turn with radius of -1 should be -45 degrees.
	assert_almost_eq(VehicleLib.ackermann2(Transform2D(-PI / 2, Vector2(4.0, 5.0)), [Vector2(4.0, 4.0)], -1.0)[0], deg_to_rad(-45.0), GConst.ERROR_INTERVAL)
#endregion tests
