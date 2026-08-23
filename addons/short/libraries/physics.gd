# INFO:
# - Distance (m) = Velocity (m/s) * Time (s)
# - Distance (m) = Initial distance (m) + Initial velocity (m/s) * Time (s) + ((Acceleration (m/s^2) * Time^2 (s^2)) / (2))
# - Distance (m) = Area (m^2) / Distance (m)
# - Area (m^2) = Distance (m) * Distance (m)
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
# - Power (W = J/s = kg * m^2/s^3) = Work (J) / Time (s)
# - Power (W) = Potential (V) * Current (A)
# - Potential (V) = Current (A) * Resistance (ohm)
#
# Some methods that were useless, were simply removed or not implemented. That was abstraction for the sake of abstraction. Such as:
# - get_distance_at_constant_speed, get_velocity_at_constant_acceleration
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
# - earth_air_density(altitude, temp_c)

## @experimental: This class could change.
## Work with physics.
##
## Available in all scripts without any setup.
##[br][br][b]Note:[/b] This assumes that the [Convert] class exists.

@abstract class_name Physics extends Object


#region constants
## The newtonian gravity constant in [code](N * m^2)/(kg^2)[/code]. See [url=https://en.wikipedia.org/wiki/Gravitational_constant]Gravitational constant[/url].
const GRAVITY_CONSTANT := 6.6743e-11

## The gas constant in [code]J * (mol * K)[/code]. See [url=https://en.wikipedia.org/wiki/Gas_constant]Gas constant[/url].
const GAS_CONSTANT := 8.314_462_618_153_24

## Dry air molar mass in [code]kg/mol[/code]. See [url=https://en.wikipedia.org/wiki/Atmosphere_of_Earth]Atmosphere of Earth[/url].
const DRY_AIR_MOLAR_MASS := 0.028_946

## Earth's surface gravity in [code]meters/second^2[/code]. According to Wikipedia, gravity varies by 0.7% depending on your location.
const EARTH_GRAVITY := 9.806_65

## Earth's radius in meters. According to Wikipedia, the radius varies by 0.3% depending on your distance from the equator.
const EARTH_RADIUS := 6_371_000.0

## Earth's mass in kg.
const EARTH_MASS := 5.972e24

## Earth's sea level air pressure in [code]atmospheres[/code]. This assumes a temperature of 15°C.
const EARTH_AIR_PRESSURE := 1.0

## Earth's temperature lapse rate per meter in the standard troposphere in [code]kelvin/meter[/code]. See [url=https://en.wikipedia.org/wiki/Lapse_rate]Lapse rate[/url].
const EARTH_AIR_TEMPERATURE_LAPSE_RATE := 0.0065

## Mars' surface gravity in [code]meters/second^2[/code].
const MARS_GRAVITY := 3.728

## Mars' mass in kg.
const MARS_MASS := 6.41693e23
#endregion constants


#region methods
## Returns force in [code]newtons[/code] between two point masses. See also [url=https://www.omnicalculator.com/physics/gravitational-force]Gravitational force calculator[/url].
static func gravity_between(mass_1_kg: float, mass_2_kg: float, distance_m: float) -> float:
	return GRAVITY_CONSTANT * ((mass_1_kg * mass_2_kg) / pow(distance_m, 2))

## Returns gravity in [code]meters/second^2[/code] at [param height_m] from sea level in [code]meters[/code]. Ignores spin.
static func earth_gravity(height_m: float) -> float:
	return EARTH_GRAVITY * pow((EARTH_RADIUS) / (EARTH_RADIUS + height_m), 2)

## Returns air pressure in [code]atmospheres[/code] at [param height_m] from sea level in [code]meters[/code] and [param temperature_c] at sea level in [code]celsius[/code].
static func earth_air_pressure(height_m: float, temperature_c: float) -> float:
	return EARTH_AIR_PRESSURE * pow(
		1 - EARTH_AIR_TEMPERATURE_LAPSE_RATE * height_m / Convert.c_to_k(temperature_c),
		EARTH_GRAVITY * DRY_AIR_MOLAR_MASS / (GAS_CONSTANT * EARTH_AIR_TEMPERATURE_LAPSE_RATE))
#endregion methods
