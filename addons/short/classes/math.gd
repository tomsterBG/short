# SOURCES:
# - https://www.omnicalculator.com
# TODO:
# - geometry
# 	- get_rectangle_area(side_x, side_y)
# 	- get_rectangle_perimeter(side_x, side_y)
# 	- get_rectangle_diagonal(side_x, side_y)
# 	- get_sphere_volume(radius)
# 	- get_square_area(side_length)
# 	- get_square_perimeter(side_length)
# 	- get_square_diagonal(side_length)
# IDEAS:
# - class or class_name Matrix to more easily define what a matrix is
# - add_matrix(matrix_a, matrix_b)
# - multiply_matrix(matrix_a, matrix_b)

## @experimental: This class is immature.
## Work with math.
##
## Available in all scripts without any setup.

@abstract class_name Math extends Node


#region methods
	#region geometry
## Returns the area of a circle.
static func get_circle_area(radius: float) -> float:
	return PI * pow(radius, 2)

## Returns the circumference of a circle.
static func get_circle_circumference(radius: float) -> float:
	return TAU * radius

## Returns the volume of a cylinder.
static func get_cylinder_volume(radius: float, height: float) -> float:
	return get_circle_area(radius) * height

## Returns the area of a triangle, given base and height.
static func get_triangle_area_from_base_and_height(base: float, height: float) -> float:
	return 0.5 * base * height

## Returns the area of a triangle, given three sides.
static func get_triangle_area_from_three_sides(a: float, b: float, c: float) -> float:
	return 0.25 * sqrt( (a + b + c) * (-a + b + c) * (a - b + c) * (a + b - c) )

## Returns the area of a triangle, given two sides and [param angle_between_rad] them in [code]radians[/code].
static func get_triangle_area_from_two_sides_and_angle_between(a: float, b: float, angle_between_rad: float) -> float:
	return 0.5 * a * b * sin(angle_between_rad)

## Returns the area of a triangle, given a side and two adjacent angles in [code]radians[/code].
static func get_triangle_area_from_side_and_adjacent_angles(side_between: float, angle_a_rad: float, angle_b_rad: float) -> float:
	return pow(side_between, 2) * sin(angle_a_rad) * sin(angle_b_rad) / (2.0 * sin(angle_a_rad + angle_b_rad))
	#endregion geometry

## Returns [param vector_a] projected on [param vector_b].
static func get_projected_vector(vector_a, vector_b):
	return vector_b.normalized() * vector_a.dot(vector_b.normalized())

## Returns [code]true[/code] if [param vector_a]'s direction relative to [param vector_b] is within [param max_angle_rad] radians.
static func is_vector2_within_angle(vector_a: Vector2, vector_b: Vector2, max_angle_rad: float) -> bool:
	var angle_to = absf(vector_a.angle_to(vector_b))
	return angle_to <= max_angle_rad
#endregion methods
