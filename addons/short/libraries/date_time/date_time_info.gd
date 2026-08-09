# IDEAS:
# - Constructors: from_datetime_dict()
# - Converters: to_timestamp(), to_datetime_dict()
# BAD IDEAS:
# - Use now() only in TimestampData to incentivize correct class usage.

## @experimental: This class could change.
## Some datetime that can be passed as function argument and returned as function result.
##
##[br][br][b]Note:[/b] It is recommended to use this for functions that require datetime data. If you want to save this data, use [TimestampData].
##[br][br][b]Note:[/b] This assumes that the [DateInfo] and [TimeInfo] classes exist.

class_name DateTimeInfo extends RefCounted


#region variables
var date: DateInfo
var time: TimeInfo
#endregion variables
