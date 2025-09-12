# SOURCES:
# - https://www.youtube.com/watch?v=lt7iUBE3_AE
# 	- Torque = Force * Radius, Force = Torque / Radius
# 	- Velocity = Distance * Time
# 	- Power = Force * Velocity
# - https://whycalculator.com
# TODO:
# BAD IDEAS:
# - Move Helper.EARTH_GRAVITY here? Not really, it's not a conversion.

## @experimental: This class is immature.
## Value conversion methods.
##
## Available in all scripts without any setup.
##[br][br]A conversion script full of methods to make value conversions easy, and to improve readability.

@abstract class_name Convert extends Node


#region methods
	#region time
## Converts a time from seconds to milliseconds.
static func sec_to_msec(sec: float) -> float:
	return sec * 1_000.0

## Converts a time from milliseconds to seconds.
static func msec_to_sec(msec: float) -> float:
	return msec / 1_000.0

## Converts a time from seconds to microseconds.
static func sec_to_usec(sec: float) -> float:
	return sec * 1_000_000.0

## Converts a time from microseconds to seconds.
static func usec_to_sec(usec: float) -> float:
	return usec / 1_000_000.0
	#endregion time

	#region proportion
## Converts a proportion from units to percentages. Units are from [code]0[/code] to [code]1[/code]. Percentages are from [code]0[/code] to [code]100[/code]. See [method percent_to_unit].
static func unit_to_percent(unit: float) -> float:
	return unit * 100.0

## Converts a proportion from percentages to units. Percentages are from [code]0[/code] to [code]100[/code]. Units are from [code]0[/code] to [code]1[/code]. See [method unit_to_percent].
static func percent_to_unit(percent: float) -> float:
	return percent / 100.0
	#endregion proportion

	#region distance
## Converts a distance from meters to millimeters.
static func meter_to_mm(meter: float) -> float:
	return meter * 1000.0

## Converts a distance from millimeters to meters.
static func mm_to_meter(mm: float) -> float:
	return mm / 1000.0

## Converts a distance from millimeters to inches.
static func mm_to_inch(mm: float) -> float:
	return mm / 25.4

## Converts a distance from inches to millimeters.
static func inch_to_mm(inch: float) -> float:
	return inch * 25.4
	#endregion distance

	#region speed
## Converts a speed from [code]meters/second[/code] to [code]km/h[/code]. See also [url=https://www.youtube.com/watch?v=wFV3ycTIfn0]Converting m/s to km/h[/url].
static func ms_to_kmh(ms: float) -> float:
	return ms * 3.6

## Converts a speed from [code]km/h[/code] to [code]meters/second[/code]. See also [url=https://www.youtube.com/watch?v=ahDfIu1kxCU]Converting km/h to m/s[/url].
static func kmh_to_ms(kmh: float) -> float:
	return kmh / 3.6

## Converts a speed from [code]km/h[/code] to [code]miles/h[/code].
static func kmh_to_mph(kmh: float) -> float:
	return kmh * 0.6213712

## Converts a speed from [code]miles/h[/code] to [code]km/h[/code].
static func mph_to_kmh(mph: float) -> float:
	return mph * 1.609344
	#endregion speed

	#region angular speed
static func rads_to_rpm(rads: float) -> float:
	return rads * (60.0 / TAU)
	#endregion angular speed

# IMPORTANT: More than one type of unit. Force, angular speed and power.
## @experimental: Untested.
static func tq_lbft_to_hp(tq_lbft: float, rpm: float) -> float:
	return (tq_lbft * rpm) / 5252.0
#endregion methods
