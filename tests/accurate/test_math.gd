extends GutTest


#region tests
func test_constants():
	assert_almost_eq(Math.PHI, 1.618_033, GConst.ERROR_INTERVAL)

func test_fibonacci():
	assert_eq(Math.fibonacci(0), 0)
	assert_eq(Math.fibonacci(1), 1)
	assert_eq(Math.fibonacci(2), 1)
	assert_eq(Math.fibonacci(3), 2)
	assert_eq(Math.fibonacci(4), 3)
	assert_eq(Math.fibonacci(5), 5)

func test_factorial():
	assert_eq(Math.factorial(0), 1)
	assert_eq(Math.factorial(1), 1)
	assert_eq(Math.factorial(2), 2)
	assert_eq(Math.factorial(3), 6)
	assert_eq(Math.factorial(4), 24)
	assert_eq(Math.factorial(5), 120)

func test_pascal_triangle():
	assert_eq(Math.pascal_triangle(0, 0), 1)
	assert_eq(Math.pascal_triangle(0, 1), 1)
	assert_eq(Math.pascal_triangle(1, 1), 1)
	assert_eq(Math.pascal_triangle(0, 2), 1)
	assert_eq(Math.pascal_triangle(1, 2), 2)
	assert_eq(Math.pascal_triangle(2, 2), 1)
	assert_eq(Math.pascal_triangle(2, 4), 6)

func test_sphere():
	assert_almost_eq(Math.sphere_surface(9.0), 1017.876_020, GConst.ERROR_INTERVAL)
	assert_almost_eq(Math.sphere_volume(9.0), 3053.628_059, GConst.ERROR_INTERVAL)

func test_triangle_area():
	assert_almost_eq(Math.triangle_area_from_three_sides(5.0, 7.0, 11.090_076), 12.500_002, GConst.ERROR_INTERVAL)

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
