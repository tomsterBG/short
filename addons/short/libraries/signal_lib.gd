# INFO:
# - Logic for managing signal flow and timing.
# - Provides safe connection utilities to prevent "already connected" errors.
# IDEAS:
# - batch_connect(source: Object, connections: Dictionary) -> void: connections = { "signal_name": callable }

## @experimental: This class could change.
## Utilities for flow control and signal management.
##
## Available in all scripts without any setup.

@abstract class_name SignalLib extends Object


#region methods
## Connects a signal only if it isn't already connected.
static func safe_connect(source: Object, signal_name: StringName, callable: Callable) -> void:
	if !source or !source.has_signal(signal_name): return
	
	if !source.is_connected(signal_name, callable):
		source.connect(signal_name, callable)


## Disconnects a signal only if it is currently connected.
static func safe_disconnect(source: Object, signal_name: StringName, callable: Callable) -> void:
	if !source or !source.has_signal(signal_name): return
	
	if source.is_connected(signal_name, callable):
		source.disconnect(signal_name, callable)


## Safely swaps a connection from [param old_object] to [param new_object].
static func reconnect(old_object: Object, new_object: Object, signal_name: StringName, callable: Callable) -> void:
	safe_disconnect(old_object, signal_name, callable)
	safe_connect(new_object, signal_name, callable)
#endregion methods
