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
# - https://www.youtube.com/watch?v=jkCXdDmP618 and https://www.youtube.com/watch?v=LUgjpDMcwpI
# 	- Torque = Force * Radius, Torque = Force * Distance
# 	- Power = Force * Velocity, Power = Torque / Time, Power = Torque * Frequency
# - https://whycalculator.com
# - https://www.unitconverters.net
# - https://www.omnicalculator.com
# 	- Mechanical hp l aka hp imperial, the default.
# TODO:
# - time
# 	- h_to_day, day_to_h
# - distance
# 	- radius_to_circumference, circumference_to_radius
# - area
# 	- meter2_to_um2, um2_to_meter2
# 	- km2_to_megam2, megam2_to_km2
# - volume
# 	- meter3_to_um3, um3_to_meter3
# 	- km3_to_megam3, megam3_to_km3
# 	- meter3_to_l, l_to_meter3
# 	- l_to_ml, ml_to_l
# 	- l_to_cl, cl_to_l
# 	- l_to_dl, dl_to_l
# - volume consumption / liquid flow
# 	- l_per_100km_to_mpg, mpg_to_l_per_100km
# - power
# 	- w_to_milliwatt, milliwatt_to_w
# - torque
# 	- nm_to_kgm, kgm_to_nm
# - angle
# - speed
# 	- ms_to_mph, mph_to_ms
# - acceleration
# 	- ms2_to_earth_g, earth_g_to_ms2
# - temperature
# 	- k_to_f, f_to_k
# - mass
# 	- kg_to_lb, lb_to_kg
# - data size
# 	- b_to_kb, kb_to_b
# 	- kb_to_mb, mb_to_kb
# 	- mb_to_gb, gb_to_mb
# 	- gb_to_tb, tb_to_gb
# - other
# 	- ms_sec_to_m - meters/sec in t seconds to meters
# - Change torque to energy and multiple units to correspond to their own unit because unit incompatibility makes conversions inaccurate.
# IDEAS:
# - follow a consistent convention where there is no confusion between the prefix M for mega and m for milli
# - world_to_chunk(world_pos: Vector3, chunk_size := 16) -> Vector3i, chunk_to_world_pos(chunk_pos: Vector3i, chunk_size := 16) -> Vector3
# - deg_to_dot_product
# BAD IDEAS:
# - Add angular speed rads_to_degs and rads_to_degs? No, you can just use rad_to_deg and deg_to_rad.
# - power
# 	- hp_to_bhp - they are the same unit, measuring is different

## Convert between units.
##
## Available in all scripts without any setup.
##[br][br]Convert between units while having more readable code.

@abstract class_name Convert extends Object


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

## Converts a time from [code]milliseconds[/code] to [code]microseconds[/code].
static func msec_to_usec(msec: float) -> float:
	return msec * 1.0e3

## Converts a time from [code]microseconds[/code] to [code]milliseconds[/code].
static func usec_to_msec(usec: float) -> float:
	return usec / 1.0e3

## Converts a time from [code]seconds[/code] to [code]minutes[/code].
static func sec_to_min(sec: float) -> float:
	return sec / 60.0

## Converts a time from [code]minutes[/code] to [code]seconds[/code].
static func min_to_sec(minutes: float) -> float:
	return minutes * 60.0

## Converts a time from [code]minutes[/code] to [code]hours[/code].
static func min_to_h(minutes: float) -> float:
	return minutes / 60.0

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
## Converts a proportion from ratio to percentage. Ratio is from [code]0[/code] to [code]1[/code]. Percentage is from [code]0[/code] to [code]100[/code]. See [method percent_to_ratio].
static func ratio_to_percent(ratio: float) -> float:
	return ratio * 100.0

## Converts a proportion from percentage to ratio. Percentage is from [code]0[/code] to [code]100[/code]. Ratio is from [code]0[/code] to [code]1[/code]. See [method ratio_to_percent].
static func percent_to_ratio(percent: float) -> float:
	return percent / 100.0
	#endregion proportion

	#region distance
## Converts a distance from [code]meters[/code] to [code]micrometers[/code].
static func meter_to_um(meter: float) -> float:
	return meter * 1.0e6

## Converts a distance from [code]micrometers[/code] to [code]meters[/code].
static func um_to_meter(um: float) -> float:
	return um / 1.0e6

## Converts a distance from [code]meters[/code] to [code]millimeters[/code].
static func meter_to_mm(meter: float) -> float:
	return meter * 1.0e3

## Converts a distance from [code]millimeters[/code] to [code]meters[/code].
static func mm_to_meter(mm: float) -> float:
	return mm / 1.0e3

## Converts a distance from [code]meters[/code] to [code]centimeters[/code].
static func meter_to_cm(meter: float) -> float:
	return meter * 1.0e2

## Converts a distance from [code]centimeters[/code] to [code]meters[/code].
static func cm_to_meter(cm: float) -> float:
	return cm / 1.0e2

## Converts a distance from [code]meters[/code] to [code]decimeters[/code].
static func meter_to_dm(meter: float) -> float:
	return meter * 1.0e1

## Converts a distance from [code]decimeters[/code] to [code]meters[/code].
static func dm_to_meter(dm: float) -> float:
	return dm / 1.0e1

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
	return meter / 0.025_4

## Converts a distance from [code]inches[/code] to [code]meters[/code].
static func inch_to_meter(inch: float) -> float:
	return inch * 0.025_4

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

## Converts a distance from [code]radius[/code] to [code]diameter[/code].
static func radius_to_diameter(radius: float) -> float:
	return radius * 2.0

## Converts a distance from [code]diameter[/code] to [code]radius[/code].
static func diameter_to_radius(diameter: float) -> float:
	return diameter / 2.0

## Converts a distance from [code]meters[/code] to [code]pixels[/code], assuming the Godot convention of 100 pixels per meter.
static func meter_to_px(meter: float) -> float:
	return meter * 100.0

## Converts a distance from [code]pixels[/code] to [code]meters[/code], assuming the Godot convention of 100 pixels per meter.
static func px_to_meter(pixel: float) -> float:
	return pixel / 100.0
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
## Converts a volume from [code]meters^3[/code] to [code]millimeters^3[/code].
static func meter3_to_mm3(meter3: float) -> float:
	return meter3 * 1.0e9

## Converts a volume from [code]millimeters^3[/code] to [code]meters^3[/code].
static func mm3_to_meter3(mm3: float) -> float:
	return mm3 / 1.0e9

## Converts a volume from [code]meters^3[/code] to [code]centimeters^3[/code].
static func meter3_to_cm3(meter3: float) -> float:
	return meter3 * 1.0e6

## Converts a volume from [code]centimeters^3[/code] to [code]meters^3[/code].
static func cm3_to_meter3(cm3: float) -> float:
	return cm3 / 1.0e6

## Converts a volume from [code]meters^3[/code] to [code]decimeters^3[/code].
static func meter3_to_dm3(meter3: float) -> float:
	return meter3 * 1.0e3

## Converts a volume from [code]decimeters^3[/code] to [code]meters^3[/code].
static func dm3_to_meter3(dm3: float) -> float:
	return dm3 / 1.0e3

## Converts a volume from [code]meters^3[/code] to [code]kilometers^3[/code].
static func meter3_to_km3(meter3: float) -> float:
	return meter3 / 1.0e9

## Converts a volume from [code]kilometers^3[/code] to [code]meters^3[/code].
static func km3_to_meter3(km3: float) -> float:
	return km3 * 1.0e9
	#endregion volume

	#region angle
# TODO: Doc these.
static func rad_to_dot(radians: float) -> float:
	return cos(radians)

static func dot_to_rad(dot_product: float) -> float:
	return acos(dot_product)

static func deg_to_dot(degrees: float) -> float:
	return cos(deg_to_rad(degrees))

static func dot_to_deg(dot_product: float) -> float:
	return rad_to_deg(acos(dot_product))
	#endregion angle

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
## Converts a torque from [code]N*m[/code] to [code]Pound-force foot (lb-ft)[/code].
static func nm_to_lbft(nm: float) -> float:
	return nm * 0.7375621493

## Converts a torque from [code]Pound-force foot (lb-ft)[/code] to [code]N*m[/code].
static func lbft_to_nm(lbft: float) -> float:
	return lbft / 0.7375621493

## Converts a torque from [code]N*m[/code] to [code]Kilogram-force meter (kgm)[/code].
static func nm_to_kgm(nm: float) -> float:
	return nm * 0.1019716213

## Converts a torque from [code]Kilogram-force meter (kgm)[/code] to [code]N*m[/code].
static func kgm_to_nm(kgm: float) -> float:
	return kgm / 0.1019716213

## Converts a torque from [code]Pound-force foot (lb-ft)[/code] to [code]Kilogram-force meter (kgm)[/code].
static func lbft_to_kgm(lbft: float) -> float:
	return lbft * 0.1382549596

## Converts a torque from [code]Kilogram-force meter (kgm)[/code] to [code]Pound-force foot (lb-ft)[/code].
static func kgm_to_lbft(kgm: float) -> float:
	return kgm / 0.1382549596
	#endregion torque

	#region power
## Converts a power from [code]watt[/code] to [code]kilowatt[/code].
static func w_to_kw(watt: float) -> float:
	return watt / 1000.0

## Converts a power from [code]kilowatt[/code] to [code]watt[/code].
static func kw_to_w(kw: float) -> float:
	return kw * 1000.0

## Converts a power from [code]kilowatt[/code] to [code]megawatt[/code].
static func kw_to_megaw(kw: float) -> float:
	return kw / 1000.0

## Converts a power from [code]megawatt[/code] to [code]kilowatt[/code].
static func megaw_to_kw(megaw: float) -> float:
	return megaw * 1000.0

## Converts a power from [code]watt[/code] to [code]horsepower (mechanical imperial)[/code].
static func w_to_hp(watt: float) -> float:
	return watt / 745.69987158

## Converts a power from [code]horsepower (mechanical imperial)[/code] to [code]watt[/code].
static func hp_to_w(hp: float) -> float:
	return hp * 745.69987158

## Converts a power from [code]kilowatt[/code] to [code]horsepower (mechanical imperial)[/code].
static func kw_to_hp(kw: float) -> float:
	return kw / 0.74569987158

## Converts a power from [code]horsepower (mechanical imperial)[/code] to [code]kilowatt[/code].
static func hp_to_kw(hp: float) -> float:
	return hp * 0.74569987158

## Converts a power from [code]horsepower (mechanical imperial)[/code] to [code]Pferdestarke (ps)[/code].
static func hp_to_ps(hp: float) -> float:
	return hp * 1.0138696654

## Converts a power from [code]Pferdestarke (ps)[/code] to [code]horsepower (mechanical imperial)[/code].
static func ps_to_hp(ps: float) -> float:
	return ps / 1.0138696654
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
	return (celsius * 1.8) + 32.0

## Converts a temperature from [code]fahrenheit[/code] to [code]celsius[/code].
static func f_to_c(fahrenheit: float) -> float:
	return (fahrenheit - 32.0) / 1.8
	#endregion temperature

	#region pressure
## Converts pressure from [code]pascals[/code] to [code]kilopascals[/code].
static func pa_to_kpa(pascal: float) -> float:
	return pascal / 1000.0

## Converts pressure from [code]kilopascals[/code] to [code]pascals[/code].
static func kpa_to_pa(kilo_pascal: float) -> float:
	return kilo_pascal * 1000.0

## Converts pressure from [code]pascals[/code] to [code]bars[/code].
static func pa_to_bar(pascal: float) -> float:
	return pascal / 100_000.0

## Converts pressure from [code]bars[/code] to [code]pascals[/code].
static func bar_to_pa(bar: float) -> float:
	return bar * 100_000.0

## Converts pressure from [code]bars[/code] to [code]standard atmospheres (atm)[/code].
static func bar_to_atm(bar: float) -> float:
	return bar / 1.01325

## Converts pressure from [code]standard atmospheres (atm)[/code] to [code]bars[/code].
static func atm_to_bar(atmosphere: float) -> float:
	return atmosphere * 1.01325

## Converts pressure from [code]bars[/code] to [code]psi[/code].
static func bar_to_psi(bar: float) -> float:
	return bar * 14.503773773

## Converts pressure from [code]psi[/code] to [code]bars[/code].
static func psi_to_bar(psi: float) -> float:
	return psi / 14.503773773

## Converts pressure from [code]pascals[/code] to [code]psi[/code].
static func pa_to_psi(pascal: float) -> float:
	return pascal / 6894.7572932

## Converts pressure from [code]psi[/code] to [code]pascals[/code].
static func psi_to_pa(psi: float) -> float:
	return psi * 6894.7572932

## Converts pressure from [code]kilopascals[/code] to [code]psi[/code].
static func kpa_to_psi(kilo_pascal: float) -> float:
	return kilo_pascal / 6.8947572932

## Converts pressure from [code]psi[/code] to [code]kilopascals[/code].
static func psi_to_kpa(psi: float) -> float:
	return psi * 6.8947572932
	#endregion pressure

	#region mass
## Converts mass from [code]kilograms[/code] to [code]tons[/code].
static func kg_to_t(kilogram: float) -> float:
	return kilogram / 1000.0

## Converts mass from [code]tons[/code] to [code]kilograms[/code].
static func t_to_kg(ton: float) -> float:
	return ton * 1000.0

## Converts mass from [code]kilograms[/code] to [code]grams[/code].
static func kg_to_g(kilogram: float) -> float:
	return kilogram * 1000.0

## Converts mass from [code]grams[/code] to [code]kilograms[/code].
static func g_to_kg(gram: float) -> float:
	return gram / 1000.0
	#endregion mass

	#region mass flow
## Converts mass flow from [code]kg/second[/code] to [code]kg/hour[/code].
static func kg_sec_to_kg_h(kg_sec: float) -> float:
	return kg_sec * 3600.0

## Converts mass flow from [code]kg/hour[/code] to [code]kg/second[/code].
static func kg_h_to_kg_sec(kg_h: float) -> float:
	return kg_h / 3600.0

## Converts mass flow from [code]kg/hour[/code] to [code]grams/hour[/code].
static func kg_h_to_g_h(kg_h: float) -> float:
	return kg_h * 1000.0

## Converts mass flow from [code]grams/hour[/code] to [code]kg/hour[/code].
static func g_h_to_kg_h(g_h: float) -> float:
	return g_h / 1000.0
	#endregion mass flow

	#region multiple units
## Converts from [code]Torque (lb-ft)[/code] and [code]rpm[/code] to [code]Power (hp mechanical)[/code].
static func lbft_rpm_to_hp(tq_lbft: float, rpm: float) -> float:
	return (tq_lbft * rpm) / 5252.0

## Converts from [code]Torque (N*m)[/code] and [code]rpm[/code] to [code]Power (watt)[/code].
static func nm_rpm_to_w(tq_nm: float, rpm: float) -> float:
	return (tq_nm * rpm) * 0.10471975511966

## Converts from [code]Power (watt)[/code] and [code]Time (sec)[/code] to [code]Energy (joule)[/code].
static func w_sec_to_j(watt: float, sec: float) -> float:
	return watt * sec

## Converts from [code]Frequency (hz)[/code] to delta [code]Time (seconds)[/code].
static func hz_to_delta_sec(hz: float) -> float:
	return 1.0 / hz

## Converts from delta [code]Time (seconds)[/code] to [code]Frequency (hz)[/code].
static func delta_sec_to_hz(delta_sec: float) -> float:
	return 1.0 / delta_sec
	#endregion multiple units
#endregion methods
