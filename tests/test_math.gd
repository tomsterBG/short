extends GutTest


#region constants
const ERROR_INTERVAL := 0.000_001
#endregion constants


#region tests
func test_constants():
	assert_almost_eq(Math.PHI, 1.618_033, ERROR_INTERVAL)

func test_circle_area():
	assert_almost_eq(Math.circle_area(6.0), 113.097_335, ERROR_INTERVAL)

func test_circle_circumference():
	assert_almost_eq(Math.circle_circumference(7.0), 43.982_297, ERROR_INTERVAL)

func test_cylinder_volume():
	assert_almost_eq(Math.cylinder_volume(4.0, 7.0), 351.858_377, ERROR_INTERVAL)

func test_triangle_area():
	assert_eq(Math.triangle_area_from_base_and_height(5.0, 5.0), 12.5)
	assert_almost_eq(Math.triangle_area_from_three_sides(5.0, 7.0, 11.090_076), 12.500_002, ERROR_INTERVAL)
	assert_almost_eq(Math.triangle_area_from_two_sides_and_angle_between(5.0, 7.0, deg_to_rad(45.585)), 12.500_066, ERROR_INTERVAL)
	assert_almost_eq(Math.triangle_area_from_side_and_adjacent_angles(5.0, deg_to_rad(51.0), deg_to_rad(63.0)), 9.474_653, ERROR_INTERVAL)

func test_get_projected_vector():
	assert_eq(Math.get_projected_vector(Vector2(3, 0), Vector2(3, 0)), Vector2(3, 0), "No change.")
	assert_eq(Math.get_projected_vector(Vector3(3, 2, 0), Vector3(3, 0, 0)), Vector3(3, 0, 0), "Flatten.")
	assert_eq(Math.get_projected_vector(Vector2(0, 3), Vector2(3, 0)), Vector2(0, 0), "Perpendicular.")
	assert_eq(Math.get_projected_vector(Vector3(-4, 2, 0), Vector3(3, 0, 0)), Vector3(-4, 0, 0), "Reverse.")

func test_is_vector2_within_angle():
	assert_eq(Math.is_vector2_within_angle(Vector2(10, 0), Vector2(0, 10), deg_to_rad(91.0)), true, "Vector is within angle.")
	assert_eq(Math.is_vector2_within_angle(Vector2(10, 0), Vector2(0, 10), deg_to_rad(89.0)), false, "Vector isn't within angle.")
	assert_eq(Math.is_vector2_within_angle(Vector2(10, 10), Vector2(0, 10), deg_to_rad(46.0)), true, "Vector is within angle.")
	assert_eq(Math.is_vector2_within_angle(Vector2(10, 10), Vector2(0, 10), deg_to_rad(44.0)), false, "Vector isn't within angle.")
#endregion tests
