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
## Returns [param vector_a] projected on [param vector_b].
static func get_projected_vector(vector_a, vector_b):
	return vector_b.normalized() * vector_a.dot(vector_b.normalized())
#endregion methods
