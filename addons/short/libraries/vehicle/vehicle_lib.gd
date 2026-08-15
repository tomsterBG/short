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
#endregion methods
