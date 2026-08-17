## A procedurally generated circle.

@tool
class_name CirclePoly2D extends ProceduralPoly2D


#region variables
@export_group("Shape Parameters")

## Radius from the center (in pixels). Can't be negative.
@export var radius: float = 20.0:
	set(value):
		radius = maxf(value, 0.0)
		call_remake_polygon()

## Vertices of the circle itself. You can think of it as the sides of an n-gon. Can't be negative.
@export var vertices: int = 6:
	set(value):
		vertices = maxi(value, 0)
		call_remake_polygon()

## Local offset, visual only.
@export var offset_position: Vector2 = Vector2.ZERO:
	set(value):
		offset_position = value
		call_remake_polygon()

## Starting angle (in radians). When this is [code]0[/code], the start is towards [constant Vector2.RIGHT].
@export var from_angle: float = 0.0:
	set(value):
		from_angle = value
		call_remake_polygon()
#endregion variables


#region virtual
func _generate_poly() -> PackedVector2Array:
	return PolyLib.circle(radius, vertices, offset_position, from_angle)
#endregion virtual
