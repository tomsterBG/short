# TODO:
# - kinematics
# 	- speed_for_time_to_distance(meters_second, seconds)
# IDEAS:
# - get_earth_radius_at(degrees_from_pole) - returns an idealized stretched sphere
# - get_earth_gravity_at(height)
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
## Earth's surface gravity in [code]meters/second^2[/code]. According to Wikipedia, gravity varies by 0.7% depending on your location.
const EARTH_GRAVITY = 9.80665

## Earth's radius in meters. According to Wikipedia, the radius varies by 0.3% depending on your distance from the equator.
const EARTH_RADIUS = 6_371_000

## Earth's mass in kg.
const EARTH_MASS = 5.972 * pow(10, 24)
#endregion constants
