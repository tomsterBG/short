# INFO:
# - Hz and rps are the same thing, but one represents frequency, the other represents angular speed. Frequency is wave per second, angular speed is rotation per second.
# SOURCES:
# - https://www.youtube.com/watch?v=lt7iUBE3_AE
# 	- Torque = Force * Radius, Force = Torque / Radius
# 	- Velocity = Distance * Time
# 	- Power = Force * Velocity
# - https://whycalculator.com
# - https://www.unitconverters.net
# - https://www.omnicalculator.com
# 	- Mechanical hp l aka imperial, the default.
# TODO:
# - 
# IDEAS:
# - data size: bytes_to_mib
# - world_to_chunk(world_pos: Vector3, chunk_size := 16) -> Vector3i, chunk_to_world_pos(chunk_pos: Vector3i, chunk_size := 16) -> Vector3
# BAD IDEAS:
# - Move Helper.EARTH_GRAVITY here? Not really, it's not a conversion.
# - Add angular speed rads_to_degs and rads_to_degs? No, you can just use rad_to_deg and deg_to_rad.

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

## Converts a time from seconds to minutes.
static func sec_to_min(sec: float) -> float:
	return sec / 60.0

## Converts a time from minutes to seconds.
static func min_to_sec(min: float) -> float:
	return min * 60.0
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

## Converts a distance from meters to inches.
static func meter_to_inch(meter: float) -> float:
	return mm_to_inch(meter_to_mm(meter))

## Converts a distance from inches to meters.
static func inch_to_meter(inch: float) -> float:
	return mm_to_meter(inch_to_mm(inch))
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
	return kmh * 0.6213711922

## Converts a speed from [code]miles/h[/code] to [code]km/h[/code].
static func mph_to_kmh(mph: float) -> float:
	return mph / 0.6213711922
	#endregion speed

	#region angular speed
## Converts an angular speed from [code]radians/s[/code] to [code]rpm[/code].
static func rads_to_rpm(rads: float) -> float:
	return rads * (60.0 / TAU)

## Converts an angular speed from [code]rpm[/code] to [code]radians/s[/code].
static func rpm_to_rads(rpm: float) -> float:
	return rpm * (TAU / 60.0)

## Converts a frequency from [code]hz[/code] to an angular speed of [code]rpm[/code].
static func hz_to_rpm(hz: float) -> float:
	return hz * 60.0

## Converts an angular speed from [code]rpm[/code] to a frequency of [code]hz[/code].
static func rpm_to_hz(rpm: float) -> float:
	return rpm / 60.0
	#endregion angular speed

	#region torque
## Converts a torque from [code]n*m[/code] to [code]lb-ft[/code].
static func nm_to_lbft(nm: float) -> float:
	return nm * 0.7375621493

## Converts a torque from [code]lb-ft[/code] to [code]n*m[/code].
static func lbft_to_nm(lbft: float) -> float:
	return lbft / 0.7375621493
	#endregion torque

	#region power
## Converts a power from [code]watt[/code] to [code]kw[/code].
static func w_to_kw(watt: float) -> float:
	return watt / 1_000

## Converts a power from [code]kw[/code] to [code]watt[/code].
static func kw_to_w(kw: float) -> float:
	return kw * 1_000

## Converts a power from [code]kw[/code] to [code]mw[/code].
static func kw_to_mw(kw: float) -> float:
	return kw / 1_000

## Converts a power from [code]mw[/code] to [code]kw[/code].
static func mw_to_kw(mw: float) -> float:
	return mw * 1_000

## Converts a power from [code]hp[/code] to [code]watt[/code].
static func w_to_hp(watt: float) -> float:
	return kw_to_hp(w_to_kw(watt))

## Converts a power from [code]watt[/code] to [code]hp[/code].
static func hp_to_w(hp: float) -> float:
	return kw_to_w(hp_to_kw(hp))

## Converts a power from [code]kw[/code] to [code]hp[/code].
static func kw_to_hp(kw: float) -> float:
	return kw / 0.7456998716

## Converts a power from [code]hp[/code] to [code]kw[/code].
static func hp_to_kw(hp: float) -> float:
	return hp * 0.7456998716
	#endregion power

	#region temperature
## Converts a temperature from [code]celsius[/code] to [code]kelvin[/code].
static func c_to_k(celsius: float) -> float:
	return celsius + 273.15

## Converts a temperature from [code]kelvin[/code] to [code]celsius[/code].
static func k_to_c(kelvin: float) -> float:
	return kelvin - 273.15

## Converts a temperature from [code]celsius[/code] to [code]fahrenheit[/code].
static func c_to_f(celsius: float) -> float:
	return (9.0/5.0) * celsius + 32.0

## Converts a temperature from [code]fahrenheit[/code] to [code]celsius[/code].
static func f_to_c(fahrenheit: float) -> float:
	return (5.0/9.0) * (fahrenheit - 32.0)
	#endregion temperature

	#region multiple units
## Converts from [code]Torque (lb-ft)[/code] and [code]rpm[/code] to [code]Power (hp mechanical)[/code].
static func lbft_rpm_to_hp(tq_lbft: float, rpm: float) -> float:
	return (tq_lbft * rpm) / 5252.0

## Converts from [code]Torque (nm)[/code] and [code]rpm[/code] to [code]Power (watt)[/code].
static func nm_rpm_to_w(tq_nm: float, rpm: float) -> float:
	return (tq_nm * rpm) / 9.5488
	#endregion multiple units
#endregion methods
