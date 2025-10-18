# TODO:
# - geometry
# 	- get_sphere_volume(radius)
# 	- get_sphere_area(radius)
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
	#endregion geometry

## Returns [param vector_a] projected on [param vector_b].
static func get_projected_vector(vector_a, vector_b):
	return vector_b.normalized() * vector_a.dot(vector_b.normalized())

## Returns [code]true[/code] if [param vector_a]'s direction relative to [param vector_b] is within [param max_angle_rad] radians.
static func is_vector2_within_angle(vector_a: Vector2, vector_b: Vector2, max_angle_rad: float) -> bool:
	var angle_to = absf(vector_a.angle_to(vector_b))
	return angle_to <= max_angle_rad
#endregion methods
