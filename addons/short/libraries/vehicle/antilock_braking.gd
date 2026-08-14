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
# - sensor_info: Array[SensorInfo] - contains any sensor readings necessary.
# - hydraulic_channels() -> int - returns how many channels the ABS system has.

## @experimental: This class could change.
## Anti-lock braking system (ABS).
##
## Applicable to any vehicle. See also [url=https://en.wikipedia.org/wiki/Anti-lock_braking_system]Anti-lock braking system[/url] and [VehicleLib].
##[br][br][b]Note:[/b] Can't be called ABS because that confuses it with [method @GlobalScope.abs].

class_name AntilockBraking extends Node


#region variables
@export_group("ABS")

# IDEAS: Clamp to 0 and 1 with a small step like 0.01 or 0.001 in export. Also clamp with set_target_slip.
## Target slip ratio. See [method VehicleLib.wheel_slip_ratiof] for more info on slip ratio.
##[br][br][b]Note:[/b] Tarmac usually has best wheel grip at [code]-0.12[/code] slip. Gravel at [code]-1.0[/code].
##[br][br][b]Note:[/b] To simulate modern ABS surface modes, you may want to change this value to the best slip ratio for each surface.
@export var target_slip := -0.12

## How often the ABS tries to adjust in [code]cycles per second (cps, or Hz)[/code]. Older systems have less cycles, like [code]2-8[/code] while modern systems have more cycles, like [code]15[/code], some even claim to go up to [code]100[/code].
@export var cycles_per_second := 10
#endregion variables


#region methods
## Time between each cycle in [code]seconds[/code].
func cycle_time() -> float:
	return Convert.hz_to_delta_sec(cycles_per_second)
#endregion methods
