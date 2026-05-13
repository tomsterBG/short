# IDEAS:
# - Constructors: now_utc(), now_local().
# - Converters: to_datetime(), to_date(), to_time().

## @experimental: This class could change.
## Some timestamp that can be saved to disk, or passed as function argument and returned as function result.
##
##[br][br][b]Note:[/b] Excellent for being saved to disk and for doing date math.

class_name TimestampData extends Resource


#region variables
@export var timestamp := 0.0
#endregion variables
