## Print project statistics.

@tool
class_name LinesOfCode extends EditorScript


#region variables
## Count these filepaths.
var starting_points: Array[String] = [
	"res://addons/short/", ## My custom addon.
	"res://tests/", ## My test suite.
]

## Include these filepaths.
var whitelist: Array[String] = [
]

## Ignore these filepaths.
var blacklist: Array[String] = [
]
#endregion variables


#region virtual
func _run() -> void:
	print_project_stats()
#endregion virtual


#region methods
func print_project_stats() -> void:
	var start_time: int = Time.get_ticks_usec()
	for starting_point: String in starting_points:
		var lines: int = 0
		var scripts: int = 0
		var resources: int = 0
		var scenes: int = 0
		
		for path: String in Helper.get_dir_children(starting_point, true).files:
			if is_blacklisted(path) and !is_whitelisted(path): continue
			if path.get_extension() == "tres": resources += 1; continue
			if path.get_extension() == "tscn": scenes += 1; continue
			if path.get_extension() != "gd": continue
			
			lines += StringLib.get_lines_in_file(path)
			scripts += 1
		
		print("\n", starting_point, " has:")
		print(lines, " lines, ", scripts, " scripts, ", resources, " resources, ", scenes, " scenes")
		if scripts > resources + scenes: printerr("Scripts are more than resources + scenes. This may indicate too much code and too little content.")
	print("execution time: %.3f ms" % Convert.usec_to_msec(Time.get_ticks_usec() - start_time))


func is_whitelisted(path: String) -> bool:
	for whitelist_path: String in whitelist:
		if path.contains(whitelist_path): return true
	return false


func is_blacklisted(path: String) -> bool:
	for blacklist_path: String in blacklist:
		if path.contains(blacklist_path): return true
	return false
#endregion methods
