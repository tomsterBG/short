# INFO:
# - Standardizes the connection between Data (Resources) and UI (Nodes).
# - Replaces specific Sync/Update scripts with functional declarations.

## @experimental: This class could change.
## Bind objects' properties.
##
## Available in all scripts without any setup.

@abstract class_name BindLib extends Object


#region methods
## Binds a property from [param context.source] to [param context.target].
##[br]When [param context.source] emits [param context.source_signal] (default "changed"), the [param context.target_property] is updated.
##[br]Use [param context.transformer] to format or logic-gate the value.
static func bind(context: BindContext) -> void:
	var update_func := func(value: Variant = null) -> void:
		if context.bind_mode == BindContext.BindMode.SOURCE_PROPERTY:
			value = context.source.get(context.source_property)
		
		context.target.set(
			context.target_property,
			context.transformer.call(value))
	
	assert(context.source.has_signal(context.source_signal), "Signal %s must exist, but doesn't." % context.source_signal)
	context.source.connect(context.source_signal, update_func)
	
	update_func.call()
#endregion methods


#region classes
## Context for [method bind].
class BindContext:
	## How to bind the objects?
	enum BindMode {
		## Use [member source_property] as value.
		SOURCE_PROPERTY,
		## Use the first argument of the signal as value.
		SIGNAL_ARG_1_IS_VALUE}
	
	## Source object to look at.
	var source: Object
	## Source property to read from.
	var source_property: StringName
	## Source signal to listen to. Updates [member target_property] whenever this signal emits.
	var source_signal: StringName = &"changed"
	## Target object to look at.
	var target: Object
	## Target property to write to.
	var target_property: StringName
	## Transformer to modify the source value from [member source_property].
	var transformer: Callable = func(source_value: Variant) -> Variant: return source_value
	## How to bind the objects?
	var bind_mode := BindMode.SOURCE_PROPERTY
	
	
	func _init(p_source: Object, p_source_property: StringName, p_target: Object, p_target_property: StringName, p_source_signal := &"changed", p_transformer := func(source_value: Variant) -> Variant: return source_value, p_bind_mode := BindMode.SOURCE_PROPERTY) -> void:
		source = p_source
		source_property = p_source_property
		source_signal = p_source_signal
		target = p_target
		target_property = p_target_property
		transformer = p_transformer
		bind_mode = p_bind_mode
#endregion classes
