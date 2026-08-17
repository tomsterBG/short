# INFO:
# Convention:
# - Tyre, not tire because tire also means to tire somebody, as in to make them tired.
# SOURCES:
# https://www.engineeringtoolbox.com/fuels-higher-calorific-values-d_169.html#gsc.tab=0
# IDEAS:
# - max_shear_force(): Calculates max contact patch shear force. The force a tyre or any other object can generate on a surface. It depends on multiple things, such as contact patch area (which depends on other things), friction of both surfaces (which depends on many other things), load (which depends on other things)

## @experimental: This class could change.
## Work with vehicles.
##
## Available in all scripts without any setup.
##[br][br]Work with the complex math required to implement vehicles.
##[br][br][b]Note:[/b] It is assumed that 2D forward is [Vector2.RIGHT] and all unrotated objects point that way.

@abstract class_name VehicleLib extends Object


#region methods
## Returns wheel slip ratio. This is [code]0.0[/code] when the wheel is not slipping, [code]-1.0[/code] when the wheel is fully locked up and positive when the wheel is spinning faster than [param wheel_linear_velocity]. See [url=https://en.wikipedia.org/wiki/Slip_ratio]Slip ratio[/url].
##[br][br][b]Note:[/b] You can use [param wheel_linear_velocity] and [code]vehicle_linear_velocity[/code] interchangeably.
##[br][br][b]Note:[/b] Velocities are usually in [code]meters/second[/code] and distances in [code]meters[/code]. Make sure units match up.
##[br][br][b]Note:[/b] This method is purely scalar and will not give accurate results when vector directions are important.
static func wheel_slip_ratiof(wheel_linear_velocity: float, wheel_angular_velocity: float, effective_wheel_radius: float) -> float:
	assert(wheel_linear_velocity >= 0.0, "Velocity can't be negative.")
	assert(wheel_angular_velocity >= 0.0, "Velocity can't be negative.")
	assert(effective_wheel_radius >= 0.0, "Radius can't be negative.")
	if is_equal_approx(wheel_linear_velocity, 0.0):
		return 0.0
	return (wheel_angular_velocity * effective_wheel_radius) / wheel_linear_velocity - 1.0

## Returns brake specific fuel consumption. A measure of how much power you make per unit of consumed fuel.
##[br][br][b]Note:[/b] [param fuel_mass_flow] is in units of mass/time (g/hr, kg/hr, etc.).
##[br][br][b]Note:[/b] Typically [param fuel_mass_flow] is in g/hr and [param power] is in kW, meaning you get g/kWh.
static func bsfc(fuel_mass_flow: float, power: float) -> float:
	return fuel_mass_flow / power

## Returns the instantaneous center of rotation.
##[br][br] [param radius] is the desired turning radius measured from the [param ackermann_point]. A positive [param radius] turns right, negative turns left.
static func icr2(ackermann_point: Transform2D, radius: float) -> Vector2:
	return ackermann_point.origin + ackermann_point.y * radius

## Returns the instantaneous center of rotation as a [Vector2].
##[br][br] [param steering_point] is the [Transform2D] (position and rotation) at a wheel (or the average of multiple wheels). If [param steering_point] has the same angle as [param ackermann_point], both axles are parallel, resulting [code]null[/code].
static func icr2_from_steering_point(ackermann_point: Transform2D, steering_point: Transform2D) -> Variant:
	return Geometry2D.line_intersects_line(ackermann_point.origin, ackermann_point.y, steering_point.origin, steering_point.y)

## Returns an array of steering angles (in radians) for the given [param wheel_positions].
##[br][br] [param ackermann_point] is the center of the rear axle(s), or the vehicle pivot point. Its x axis is pointing at the vehicle's forward and its y axis is pointing at the vehicle's right.
##[br][br] [param radius] is the desired turning radius measured from the [param ackermann_point]. A positive [param radius] turns right, negative turns left.
##[br][br][b]Note:[/b] [param ackermann_point] and all [param wheel_positions] must have the same origin.
static func ackermann2(ackermann_point: Transform2D, wheel_positions: Array[Vector2], radius: float) -> Array[float]:
	var result: Array[float] = []
	result.resize(len(wheel_positions))
	if is_inf(radius):
		return result
	for i in range(len(wheel_positions)):
			result[i] = icr2(ackermann_point, radius).direction_to(ackermann_point.origin).angle_to(icr2(ackermann_point, radius).direction_to(wheel_positions[i]))
	return result
#endregion methods
