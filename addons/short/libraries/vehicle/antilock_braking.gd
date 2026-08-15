# INFO:
# https://www.youtube.com/watch?v=98DXe3uKwfc - ABS concept
# - Wheel velocity at the contact point is always 0, assuming no slipping and a stationary surface.
# 	- If you're on a flexible bridge, the contact point velocity for both suraces is the same, but non-0.
# 	  Not accounting for this may lead to the wheel thinking that it is slipping while it isn't.
# 	- Additionally, the sum of linear and angular wheel velocity at the contact point is 0, same assumptions.
# - Goal of ABS is to reach a slip ratio that maximizes friction.
# - EBD - Electronic Braking Distribution, an ABS subsystem to prevent spin out under braking on different frictions.
# 	- Monitors yaw and relative wheel slip. Reduces brake pressure to equalize grip.
# https://www.youtube.com/watch?v=G-GEUkiMuLk - Threshold braking < ABS
# - Slip is the ratio between tyre and vehicle velocity. (car_velocity - wheel_velocity) / car_velocity
# - Calculate braking distance: car_velocity^2 / 2 * friction_coefficient * gravity_acceleration
# - ABS bounces between a different percentage of brake pressure depending on its quality. Better ABS: more accurate.
# - What affects tyre grip (friction): surface, temperature, pressure, wear, suspension position, load, alignment
# - You can't beat ABS because you have 1 brake pedal, modern ABS has one channel per wheel.
# - ABS cycles seem to range from 15 to 100. This is literally perfect for accurate 60 FPS simulation.
# - Brake bias: best bias is equal to your front/rear weight distribution, which changes under braking.
# - ABS flaws: surfaces where max grip is at max slip
# 	- Gravel and unpacked snow accumulate in front of the tyre, giving you the best grip when you lock up.
# - Race mode ABS seems to trade off everything in the name of shortest stopping distance.
# - Sport ABS prevents stuff like rear wheel lifting on BMW bikes, trading away some stopping distance.
# IDEAS:
# - Add slip ratio / friction coefficient curves for different surfaces. May be better off in a template.
# - Input brake ratio and output brake ratio that can't be more than the input.
# - hydraulic_channels() -> int - returns how many channels the ABS system has.
# - signal cycled() - Emitted when this ABS goes through a cycle.

## @experimental: This class could change.
## Anti-lock braking system (ABS).
##
## Applicable to any vehicle. See also [url=https://en.wikipedia.org/wiki/Anti-lock_braking_system]Anti-lock braking system[/url] and [VehicleLib].
##[br][br][b]Note:[/b] Can't be called ABS because that confuses it with [method @GlobalScope.abs].

@tool
class_name AntilockBraking extends Node


#region enums
## Defines different ABS cycle types to be used for each sensor.
enum ABSCycle {
	PASS, ## The sensor is currently doing nothing, letting brake pressure pass through.
	DECREASE, ## The sensor is currently decreasing brake pressure.
	HOLD, ## The sensor is currently holding brake pressure.
	INCREASE, ## The sensor is currently increasing brake pressure.
}
#endregion enums


#region variables
@export_group("ABS")

## Target slip ratio. See [method VehicleLib.wheel_slip_ratiof] for more info on slip ratio.
##[br][br][b]Note:[/b] Tarmac usually has best wheel grip at [code]-0.12[/code] slip. Gravel at [code]-1.0[/code].
##[br][br][b]Note:[/b] To simulate modern ABS surface modes, you may want to change this value to the best slip ratio for each surface.
@export_range(-1.0, 0.0, 0.001) var target_slip := -0.12: set = set_target_slip

## How often the ABS tries to adjust in [code]cycles per second (cps, or Hz)[/code]. Older systems have less cycles, like [code]2-8[/code] while modern systems have more cycles, like [code]15[/code], some even claim to go up to [code]100[/code].
@export var cycles_per_second := 10

## Sensor readings from all sensors.
var sensor_info: Array[SensorInfo] = []

## Seconds until abs cycle ends.
var cycle_time_left: float = 0.0: set = set_cycle_time_left
#endregion variables


#region setters
func set_target_slip(value: float) -> void:
	target_slip = clampf(value, -1.0, 0.0)

func set_cycle_time_left(value: float) -> void:
	cycle_time_left = fposmod(value, cycle_time())
#endregion setters


#region methods
## Time between each cycle in [code]seconds[/code].
func cycle_time() -> float:
	return Convert.hz_to_delta_sec(cycles_per_second)

## Simulate ABS for [param delta] seconds.
func simulate_abs(delta: float) -> void:
	if cycle_time_left - delta < 0.0: # NOTE: Doesn't account for multiple cycles per simulation step.
		for info: SensorInfo in sensor_info:
			info.simulate_cycle()
	cycle_time_left -= delta
#endregion methods


#region classes
## Contains all necessary sensor data. Older systems have less sensors while newer systems have one per wheel.
class SensorInfo:
	## Average slip ratio of the wheel(s) this sensor is looking at. Set this value.
	var slip_ratio: float = 0.0: set = set_slip_ratio
	## Average input brake ratio of the wheel(s) this sensor is looking at. Set this value.
	var input_brake_ratio: float = 0.0: set = set_input_brake_ratio
	## ABS cycle last chosen by this sensor.
	var abs_cycle: ABSCycle = ABSCycle.PASS
	## Average output brake ratio of the wheel(s) this sensor is controlling.
	var output_brake_ratio: float = 0.0: set = set_output_brake_ratio
	
	func set_slip_ratio(value: float) -> void:
		slip_ratio = clampf(value, -1.0, 0.0)
	
	func set_input_brake_ratio(value: float) -> void:
		input_brake_ratio = clampf(value, 0.0, 1.0)
	
	func set_output_brake_ratio(value: float) -> void:
		output_brake_ratio = clampf(value, 0.0, 1.0)
	
	##@experimental: Untested.
	## Simulate a sensor cycle.
	func simulate_cycle() -> void:
		#if slip_ratio > target_slip:
			#abs_cycle = ABSCycle.DECREASE
		#elif slip_ratio < target_slip:
			#abs_cycle = ABSCycle.PASS
		pass
#endregion classes
