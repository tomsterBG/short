# INFO:
# - Distance (m) = Velocity (m/s) * Time (s)
# - Distance (m) = Initial distance (m) + Initial velocity (m/s) * Time (s) + ((Acceleration (m/s^2) * Time^2 (s^2)) / (2))
# - Velocity (m/s) = Distance (m) / Time (s)
# - Velocity (m/s) = Initial velocity (m/s) + Acceleration (m/s^2) * Time (s)
# 	- For constant acceleration.
# - Acceleration (m/s^2) = Velocity (m/s) / Time (s)
# - Acceleration (m/s^2) = Force (N) / Mass (kg)
# - Momentum (P = kg*m/s) = Mass (kg) * Velocity (m/s)
# - Force (N = kg*m/s^2) = Mass (kg) * Acceleration (m/s^2)
# - Force (N) = Momentum (P) / Time (s)
# - Weight (G) = Force (N) = Mass (kg) * Gravity (g = m/s^2)
# 	- Weight is a force, but force may refer to things that are not a weight.
# - Gravity (g) = GRAVITY_CONSTANT ((N * m^2)/(kg^2)) * (Mass (kg) / Radius^2 (m^2))
# 	- For finding planet gravity. It's so cool to see how the units match!
# - Work (J = N*m) = Force (N) * Distance (m)
# - Energy (J) = Power (W) * Time (s)
# - Kinetic energy (J = kg * m^2/s^2) = (1/2) * Mass (kg) * Velocity^2 ((m/s)^2)
# - Potential energy (J) = Mass (kg) * Gravity (g) * Height (m)
# - Power (W = J/s =  kg * m^2/s^3) = Work (J) / Time (s)
# TODO:
# - kinematics
# 	- speed_for_time_to_distance(meters_second, seconds)
# IDEAS:
# - get_earth_radius_at(degrees_from_pole) - returns an idealized stretched sphere
# - get_earth_air_density_at(height) - ignores wind speed
# - EARTH_AIR_DENSITY - at sea level
# - get_gravity_between(mass_1, mass_2, distance) - assume point passes
# - mars, moon, sun, jupiter, saturn - gravity, radius, mass
# - get_air_drag(speed, air_density, ...)
# - get_water_drag(speed, water_density, ...)

## @experimental: This class is immature.
## Work with physics.
##
## Available in all scripts without any setup.

@abstract class_name Physics extends Node


#region constants
## The newtonian gravity constant in [code](N * m^2)/(kg^2)[/code]. See [url=https://en.wikipedia.org/wiki/Gravitational_constant]Gravitational constant[/url].
const GRAVITY_CONSTANT := 6.674 * pow(10, -11)

## Earth's surface gravity in [code]meters/second^2[/code]. According to Wikipedia, gravity varies by 0.7% depending on your location.
const EARTH_GRAVITY := 9.80665

## Earth's radius in meters. According to Wikipedia, the radius varies by 0.3% depending on your distance from the equator.
const EARTH_RADIUS := 6_371_000.0

## Earth's mass in kg.
const EARTH_MASS := 5.972 * pow(10, 24)
#endregion constants


#region methods
## Returns gravity in [code]meters/second^2[/code] at [param height] from sea level in [code]meters[/code]. Ignores spin.
static func get_earth_gravity(height_m: float) -> float:
	return EARTH_GRAVITY * pow((EARTH_RADIUS) / (EARTH_RADIUS + height_m), 2)

## Returns force in [code]newtons[/code] between two point masses. See also [url=https://www.omnicalculator.com/physics/gravitational-force]Gravitational force calculator[/url].
static func get_gravity_between(mass_1_kg: float, mass_2_kg: float, distance_m: float) -> float:
	return GRAVITY_CONSTANT * ((mass_1_kg * mass_2_kg) / pow(distance_m, 2))

## Returns distance in [code]meters[/code] after some time under constant speed.
static func get_distance_at_constant_speed(speed_ms: float, time_sec: float) -> float:
	return speed_ms * time_sec

## Returns velocity in [code]meters/sec[/code] after some time under constant acceleration.
static func get_velocity_at_constant_acceleration(initial_velocity_ms: float, acceleration_ms2: float, time_sec: float) -> float:
	return initial_velocity_ms + acceleration_ms2 * time_sec
#endregion methods
