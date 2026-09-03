# SOURCES:
# - https://www.omnicalculator.com
# INFO:
# Some methods that were useless, were simply removed or not implemented. That was abstraction for the sake of abstraction. Such as:
# - circle_area, circle_circumference
# - cylinder_volume
# - rectangle_area, rectangle_diagonal, rectangle_perimeter
# - square_area, square_diagonal, square_perimeter
# - triangle_area_from_base_and_height, triangle_area_from_two_sides_and_angle_between, triangle_area_from_side_and_adjacent_angles
# - rand_point_in_circle, rand_point_in_fov
# TODO:
# - SQRT_2 = sqrt(2)
# - geometry
# 	- cone_surface(radius, height)
# 	- cone_volume(radius, height)
# 	- right_triangle_area(side_x, side_y)
# 	- triangle_perimeter(a, b, c)
# IDEAS:
# - nearest_point_on_line2(line_start, line_end, target) -> Vector2
# - nearest_point_on_line3(line_start, line_end, target) -> Vector3
# - reflect2(vector, axis) -> Vector2
# - reflect3(vector, axis) -> Vector3
# - class or class_name Matrix to more easily define what a matrix is
# - add_matrix(matrix_a, matrix_b)
# - multiply_matrix(matrix_a, matrix_b)
# - Instead of get_shape_something, we can make classes of each shape and they can have methods such as Square.perimeter() and Triangle.area().

## @experimental: This class could change.
## Work with math.
##
## Available in all scripts without any setup.

@abstract class_name Math extends Object


#region constants
## The golden ratio.
const PHI = (1.0 + sqrt(5)) / 2.0
#endregion constants


#region getters
## Returns [param vector_a] projected on [param vector_b].
static func get_projected_vector(vector_a: Variant, vector_b: Variant) -> Variant:
	return vector_b.normalized() * vector_a.dot(vector_b.normalized())
#endregion getters


#region methods
## Returns the fibonacci of [param n].
##[br][br][b]Note:[/b] Recursive and expensive. Intended to be implemented with cache, similar to the dynamic programming pattern.
static func fibonacci(n: int) -> int:
	if n == 0: return 0
	elif n == 1: return 1
	elif n == 2: return 1
	return fibonacci(n - 2) + fibonacci(n - 1)

## Returns the factorial of [param n].
##[br][br][b]Note:[/b] Recursive and expensive. Intended to be implemented with cache, similar to the dynamic programming pattern.
static func factorial(n: int) -> int:
	if n == 0: return 1
	elif n == 1: return 1
	elif n == 2: return 2
	return n * factorial(n - 1)

## Returns the pascal triangle value at the [param y]th row and [param x]th column. The position of [code]0, 0[/code] is [code]1[/code] at the tip of the triangle. Each row's beginning starts at [param x] [code]0[/code].
##[br][br][b]Note:[/b] Recursive and expensive. Intended to be implemented with cache, similar to the dynamic programming pattern.
##[br][br][b]Note:[/b] Useful for knowing the ways in which you can achieve a sequence of yes/no outcomes.
static func pascal_triangle(x: int, y: int) -> int:
	assert(x >= 0, "There are no numbers to the left of x == 0.")
	assert(x <= y, "There are no numbers to the right of x == y.")
	assert(y >= 0, "There are no numbers above y == 0.")
	if x == 0: return 1 # left border of 1s
	elif x == y: return 1 # right border of 1s
	return pascal_triangle(x - 1, y - 1) + pascal_triangle(x, y - 1)

	#region geometry
## Returns the surface of a sphere.
static func sphere_surface(radius: float) -> float:
	return 4.0 * PI * pow(radius, 2)

## Returns the volume of a sphere.
static func sphere_volume(radius: float) -> float:
	return (4.0/3.0) * PI * pow(radius, 3)

## Returns the area of a triangle, given three sides.
static func triangle_area_from_three_sides(a: float, b: float, c: float) -> float:
	assert(a + b > c and b + c > a and c + a > b, "Triangle inequality theorem failed: The sum of any 2 sides must be > than the 3rd.")
	return 0.25 * sqrt( (a + b + c) * (-a + b + c) * (a - b + c) * (a + b - c) )

## Returns [code]true[/code] if [param vector_a]'s direction relative to [param vector_b] is within [param max_angle_rad] radians.
static func is_vector2_within_angle(vector_a: Vector2, vector_b: Vector2, max_angle_rad: float) -> bool:
	var angle_to := absf(vector_a.angle_to(vector_b))
	return angle_to <= max_angle_rad
	#endregion geometry
#endregion methods
