## A procedurally generated thick arc.

@tool
class_name ThickArcPoly2D extends ProceduralPoly2D


#region variables
@export_group("Shape Parameters")

## Starting angle (in radians). When this is [code]0[/code], the start is towards [constant Vector2.RIGHT].
@export var from_angle: float = 0.0:
	set(value):
		from_angle = value
		call_remake_polygon()

## Ending angle (in radians). When this is [code]PI / 2[/code], the end is towards [constant Vector2.DOWN].
@export var to_angle: float = PI / 2.0:
	set(value):
		to_angle = value
		call_remake_polygon()

## Outer radius (in pixels). Can't be negative.
@export var outer_radius: float = 40.0:
	set(value):
		outer_radius = maxf(value, 0.0)
		call_remake_polygon()

## Inner radius (in pixels). Can't be negative.
@export var inner_radius: float = 20.0:
	set(value):
		inner_radius = maxf(value, 0.0)
		call_remake_polygon()

## Arc radius multiplier via [Curve]. Radius is sampled in the curve domain range of [code][0, 1][/code] and multiplied by [member outer_radius] or [member inner_radius].
@export var radius_curve: Curve:
	set(value):
		radius_curve = value
		call_remake_polygon()

## Vertices of each arc. The total shape vertices are equal to [member vertices] [code]* 2[/code]. Can't be less than [code]1[/code].
@export var vertices: int = 6:
	set(value):
		vertices = maxi(value, 0)
		call_remake_polygon()

## Local offset, visual only.
@export var offset_position: Vector2 = Vector2.ZERO:
	set(value):
		offset_position = value
		call_remake_polygon()
#endregion variables


#region virtual
func _generate_poly() -> PackedVector2Array:
	var context := PolyLib.ThickArcContext.new(
		from_angle,
		to_angle,
		outer_radius,
		inner_radius,
		vertices,
		offset_position
	)
	context.radius_curve = radius_curve
	return PolyLib.thick_arc(context)
#endregion virtual
