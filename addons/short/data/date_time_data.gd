# IDEAS:
# - Constructors: from_datetime_dict().
# - Converters: to_timestamp().
# BAD IDEAS:
# - Use now_utc(), now_local() only in TimestampData to incentivize correct class usage.

## @experimental: This class could change.
## Some datetime that can be passed as function argument and returned as function result.
##
##[br][br][b]Note:[/b] It is recommended to use this for functions that require datetime data. If you want to save this data, [TimestampData] is much more efficient.
##[br][br][b]Note:[/b] This assumes that the [DateData] and [TimeData] classes exist.

class_name DateTimeData extends Resource


#region variables
@export var date: DateData
@export var time: TimeData
#endregion variables
