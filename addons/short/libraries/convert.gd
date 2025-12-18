# INFO:
# - Hz and rps are the same thing, but one represents frequency, the other represents angular speed. Frequency is wave per second, angular speed is rotation per second.
# - Torque (N*m) is the same unit as Energy (J).
# - 1.0e2 = 100.0
# - t - tera
# - g - giga
# - M - mega
# - k - kilo
# - d - deci
# - c - centi
# - m - milli
# - u - micro
# SOURCES:
# - TU Sofia
# 	- Velocity = Distance / Time
# 	- Acceleration = Velocity / Time
# 	- Force = Mass * Acceleration
# - https://www.youtube.com/watch?v=lt7iUBE3_AE
# - https://www.youtube.com/watch?v=jkCXdDmP618
# 	- Torque = Force * Radius, Torque = Force * Distance
# 	- Power = Force * Velocity, Power = Torque / Time, Power = Torque * RPM
# - https://whycalculator.com
# - https://www.unitconverters.net
# - https://www.omnicalculator.com
# 	- Mechanical hp l aka imperial, the default.
# TODO:
# - distance
# 	- meter_to_um
# 	- um_to_meter
# 	- radius_to_circumference, circumference_to_radius
# - area
# 	- meter2_to_um2
# 	- um2_to_meter2
# 	- km2_to_megam2
# 	- megam2_to_km2
# - volume
# 	- meter3_to_um3
# 	- um3_to_meter3
# 	- km3_to_megam3
# 	- megam3_to_km3
# 	- l_to_ml
# 	- ml_to_l
# 	- l_to_dl
# 	- dl_to_l
# 	- l_to_cl
# 	- cl_to_l
# - power
# 	- w_to_milliwatt
# 	- milliwatt_to_w
# - other
# 	- ms_sec_to_m - meters/sec in t seconds to meters
# - Change torque to energy and multiple units to correspond to their own unit because unit incompatibility makes conversions inaccurate.
# IDEAS:
# - follow a consistent convention where there is no confusion between the prefix m for mega or for milli
# - data size: mb_to_kb, kb_to_mb, mb_to_gb, gb_to_mb, mb_to_tb, tb_to_mb
# - world_to_chunk(world_pos: Vector3, chunk_size := 16) -> Vector3i, chunk_to_world_pos(chunk_pos: Vector3i, chunk_size := 16) -> Vector3
# - deg_to_dot_product
# BAD IDEAS:
# - Add angular speed rads_to_degs and rads_to_degs? No, you can just use rad_to_deg and deg_to_rad.

## @experimental: This class is immature.
## Convert between units.
##
## Available in all scripts without any setup.
##[br][br]Convert between units while having more readable code.
##[br][br][b]Note:[/b] This assumes that the [Helper] class exists.

@abstract class_name Convert extends Node


#region methods
	#region time
## Converts a time from [code]seconds[/code] to [code]milliseconds[/code].
static func sec_to_msec(sec: float) -> float:
	return sec * 1.0e3

## Converts a time from [code]milliseconds[/code] to [code]seconds[/code].
static func msec_to_sec(msec: float) -> float:
	return msec / 1.0e3

## Converts a time from [code]seconds[/code] to [code]microseconds[/code].
static func sec_to_usec(sec: float) -> float:
	return sec * 1.0e6

## Converts a time from [code]microseconds[/code] to [code]seconds[/code].
static func usec_to_sec(usec: float) -> float:
	return usec / 1.0e6

## Converts a time from [code]seconds[/code] to [code]minutes[/code].
static func sec_to_min(sec: float) -> float:
	return sec / 60.0

## Converts a time from [code]minutes[/code] to [code]seconds[/code].
static func min_to_sec(min: float) -> float:
	return min * 60.0

## Converts a time from [code]minutes[/code] to [code]hours[/code].
static func min_to_h(min: float) -> float:
	return min / 60.0

## Converts a time from [code]hours[/code] to [code]minutes[/code].
static func h_to_min(hour: float) -> float:
	return hour * 60.0

## Converts a time from [code]seconds[/code] to [code]hours[/code].
static func sec_to_h(sec: float) -> float:
	return sec / 3600.0

## Converts a time from [code]hours[/code] to [code]seconds[/code].
static func h_to_sec(hour: float) -> float:
	return hour * 3600.0

## Converts a time from [code]seconds[/code] to [code]days[/code].
static func sec_to_day(sec: float) -> float:
	return sec / 86_400.0

## Converts a time from [code]days[/code] to [code]seconds[/code].
static func day_to_sec(day: float) -> float:
	return day * 86_400.0

## Converts a time from [code]seconds[/code] to [code]weeks[/code].
static func sec_to_week(sec: float) -> float:
	return sec / 604_800.0

## Converts a time from [code]weeks[/code] to [code]seconds[/code].
static func week_to_sec(week: float) -> float:
	return week * 604_800.0

## Converts a time from [code]days[/code] to [code]weeks[/code].
static func day_to_week(day: float) -> float:
	return day / 7.0

## Converts a time from [code]weeks[/code] to [code]days[/code].
static func week_to_day(week: float) -> float:
	return week * 7.0

## Converts a time from [code]days[/code] to [code]years[/code].
static func day_to_year(day: float) -> float:
	return day / 365.25

## Converts a time from [code]years[/code] to [code]days[/code].
static func year_to_day(year: float) -> float:
	return year * 365.25
	#endregion time

	#region proportion
## Converts a proportion from units to percentages. Units are from [code]0[/code] to [code]1[/code]. Percentages are from [code]0[/code] to [code]100[/code]. See [method percent_to_unit].
static func unit_to_percent(unit: float) -> float:
	return unit * 100.0

## Converts a proportion from percentages to units. Percentages are from [code]0[/code] to [code]100[/code]. Units are from [code]0[/code] to [code]1[/code]. See [method unit_to_percent].
static func percent_to_unit(percent: float) -> float:
	return percent / 100.0
	#endregion proportion

	#region number base
## Converts an [code]unsigned binary integer[/code] to an [code]unsigned decimal integer[/code]. Asserts [method Helper.is_binary] in debug builds.
static func bin_to_dec(binary: String) -> int:
	assert(Helper.is_binary(binary), "Parameter binary is not a binary string.")
	binary = binary.reverse()
	var decimal := 0
	for idx in range(binary.length()):
		decimal += int(binary[idx]) * pow(2, idx)
	return decimal
	#endregion number base

	#region distance
## Converts a distance from [code]meters[/code] to [code]decimeters[/code].
static func meter_to_dm(meter: float) -> float:
	return meter * 1.0e1

## Converts a distance from [code]decimeters[/code] to [code]meters[/code].
static func dm_to_meter(dm: float) -> float:
	return dm / 1.0e1

## Converts a distance from [code]meters[/code] to [code]centimeters[/code].
static func meter_to_cm(meter: float) -> float:
	return meter * 1.0e2

## Converts a distance from [code]centimeters[/code] to [code]meters[/code].
static func cm_to_meter(cm: float) -> float:
	return cm / 1.0e2

## Converts a distance from [code]meters[/code] to [code]millimeters[/code].
static func meter_to_mm(meter: float) -> float:
	return meter * 1.0e3

## Converts a distance from [code]millimeters[/code] to [code]meters[/code].
static func mm_to_meter(mm: float) -> float:
	return mm / 1.0e3

## Converts a distance from [code]meters[/code] to [code]kilometers[/code].
static func meter_to_km(meter: float) -> float:
	return meter / 1.0e3

## Converts a distance from [code]kilometers[/code] to [code]meters[/code].
static func km_to_meter(km: float) -> float:
	return km * 1.0e3

## Converts a distance from [code]millimeters[/code] to [code]inches[/code].
static func mm_to_inch(mm: float) -> float:
	return mm / 25.4

## Converts a distance from [code]inches[/code] to [code]millimeters[/code].
static func inch_to_mm(inch: float) -> float:
	return inch * 25.4

## Converts a distance from [code]meters[/code] to [code]inches[/code].
static func meter_to_inch(meter: float) -> float:
	return mm_to_inch(meter_to_mm(meter))

## Converts a distance from [code]inches[/code] to [code]meters[/code].
static func inch_to_meter(inch: float) -> float:
	return mm_to_meter(inch_to_mm(inch))

## Converts a distance from [code]kilometers[/code] to [code]megameters[/code].
static func km_to_megameter(km: float) -> float:
	return km / 1.0e3

## Converts a distance from [code]megameters[/code] to [code]kilometers[/code].
static func megameter_to_km(megameter: float) -> float:
	return megameter * 1.0e3

## Converts a distance from [code]kilometers[/code] to [code]astronomical units[/code].
static func km_to_au(km: float) -> float:
	return km / 1.495979e8

## Converts a distance from [code]astronomical units[/code] to [code]kilometers[/code].
static func au_to_km(au: float) -> float:
	return au * 1.495979e8

## Converts a distance from radius to diameter.
static func radius_to_diameter(radius: float) -> float:
	return radius * 2.0

## Converts a distance from diameter to radius.
static func diameter_to_radius(diameter: float) -> float:
	return diameter / 2.0
	#endregion distance

	#region area
## Converts an area from [code]meters^2[/code] to [code]decimeters^2[/code].
static func meter2_to_dm2(meter2: float) -> float:
	return meter2 * 1.0e2

## Converts an area from [code]decimeters^2[/code] to [code]meters^2[/code].
static func dm2_to_meter2(dm2: float) -> float:
	return dm2 / 1.0e2

## Converts an area from [code]meters^2[/code] to [code]centimeters^2[/code].
static func meter2_to_cm2(meter2: float) -> float:
	return meter2 * 1.0e4

## Converts an area from [code]centimeters^2[/code] to [code]meters^2[/code].
static func cm2_to_meter2(cm2: float) -> float:
	return cm2 / 1.0e4

## Converts an area from [code]meters^2[/code] to [code]millimeters^2[/code].
static func meter2_to_mm2(meter2: float) -> float:
	return meter2 * 1.0e6

## Converts an area from [code]millimeters^2[/code] to [code]meters^2[/code].
static func mm2_to_meter2(mm2: float) -> float:
	return mm2 / 1.0e6

## Converts an area from [code]meters^2[/code] to [code]kilometers^2[/code].
static func meter2_to_km2(meter2: float) -> float:
	return meter2 / 1.0e6

## Converts an area from [code]kilometers^2[/code] to [code]meters^2[/code].
static func km2_to_meter2(km2: float) -> float:
	return km2 * 1.0e6
	#endregion area

	#region volume
## Converts a volume from [code]meters^3[/code] to [code]decimeters^3[/code].
static func meter3_to_dm3(meter3: float) -> float:
	return meter3 * 1.0e3

## Converts a volume from [code]decimeters^3[/code] to [code]meters^3[/code].
static func dm3_to_meter3(dm3: float) -> float:
	return dm3 / 1.0e3

## Converts a volume from [code]meters^3[/code] to [code]centimeters^3[/code].
static func meter3_to_cm3(meter3: float) -> float:
	return meter3 * 1.0e6

## Converts a volume from [code]centimeters^3[/code] to [code]meters^3[/code].
static func cm3_to_meter3(cm3: float) -> float:
	return cm3 / 1.0e6

## Converts a volume from [code]meters^3[/code] to [code]millimeters^3[/code].
static func meter3_to_mm3(meter3: float) -> float:
	return meter3 * 1.0e9

## Converts a volume from [code]millimeters^3[/code] to [code]meters^3[/code].
static func mm3_to_meter3(mm3: float) -> float:
	return mm3 / 1.0e9

## Converts a volume from [code]meters^3[/code] to [code]kilometers^3[/code].
static func meter3_to_km3(meter3: float) -> float:
	return meter3 / 1.0e9

## Converts a volume from [code]kilometers^3[/code] to [code]meters^3[/code].
static func km3_to_meter3(km3: float) -> float:
	return km3 * 1.0e9
	#endregion volume

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

## Converts from [code]Frequency (hz)[/code] to [code]Angular speed (rpm)[/code].
static func hz_to_rpm(hz: float) -> float:
	return hz * 60.0

## Converts from [code]Angular speed (rpm)[/code] to [code]Frequency (hz)[/code].
static func rpm_to_hz(rpm: float) -> float:
	return rpm / 60.0
	#endregion angular speed

	#region acceleration
## Converts an acceleration from [code]meters/second^2[/code] to [code]km/second^2[/code].
static func ms2_to_kms2(ms2: float) -> float:
	return ms2 / 1000.0

## Converts an acceleration from [code]km/second^2[/code] to [code]meters/second^2[/code].
static func kms2_to_ms2(kms2: float) -> float:
	return kms2 * 1000.0
	#endregion acceleration

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
	return watt / 1000.0

## Converts a power from [code]kw[/code] to [code]watt[/code].
static func kw_to_w(kw: float) -> float:
	return kw * 1000.0

## Converts a power from [code]kw[/code] to [code]mw[/code].
static func kw_to_mw(kw: float) -> float:
	return kw / 1000.0

## Converts a power from [code]mw[/code] to [code]kw[/code].
static func mw_to_kw(mw: float) -> float:
	return mw * 1000.0

## Converts a power from [code]watt[/code] to [code]hp[/code].
static func w_to_hp(watt: float) -> float:
	return watt / 745.6998716

## Converts a power from [code]hp[/code] to [code]watt[/code].
static func hp_to_w(hp: float) -> float:
	return hp * 745.6998716

## Converts a power from [code]kw[/code] to [code]hp[/code].
static func kw_to_hp(kw: float) -> float:
	return kw / 0.7456998716

## Converts a power from [code]hp[/code] to [code]kw[/code].
static func hp_to_kw(hp: float) -> float:
	return hp * 0.7456998716
	#endregion power

	#region energy
## Converts an energy from [code]joules (watt*sec)[/code] to [code]kw*hours[/code].
static func j_to_kwh(joule: float) -> float:
	return joule / 3600_000.0

## Converts an energy from [code]kw*hours[/code] to [code]joules (watt*sec)[/code].
static func kwh_to_j(kwh: float) -> float:
	return kwh * 3600_000.0
	#endregion energy

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

	#region mass
## Converts a mass from [code]kilograms[/code] to [code]tons[/code].
static func kg_to_t(kilogram: float) -> float:
	return kilogram / 1000.0

## Converts a mass from [code]tons[/code] to [code]kilograms[/code].
static func t_to_kg(ton: float) -> float:
	return ton * 1000.0

## Converts a mass from [code]kilograms[/code] to [code]grams[/code].
static func kg_to_g(kilogram: float) -> float:
	return kilogram * 1000.0

## Converts a mass from [code]grams[/code] to [code]kilograms[/code].
static func g_to_kg(gram: float) -> float:
	return gram / 1000.0
	#endregion mass

	#region multiple units
## Converts from [code]Torque (lb-ft)[/code] and [code]rpm[/code] to [code]Power (hp mechanical)[/code].
static func lbft_rpm_to_hp(tq_lbft: float, rpm: float) -> float:
	return (tq_lbft * rpm) / 5252.0

## Converts from [code]Torque (nm)[/code] and [code]rpm[/code] to [code]Power (watt)[/code].
static func nm_rpm_to_w(tq_nm: float, rpm: float) -> float:
	return (tq_nm * rpm) * 0.10471975511966

## Converts from [code]Power (watt)[/code] and [code]Time (sec)[/code] to [code]Energy (joule)[/code].
static func w_sec_to_j(watt: float, sec: float) -> float:
	return watt * sec
	#endregion multiple units
#endregion methods
