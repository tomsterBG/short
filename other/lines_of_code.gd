@tool
class_name ProjectLines extends EditorScript


var whitelist: Array[String] = [ ## Include these filepaths.
	#"res://addons/short",
]
var blacklist: Array[String] = [ ## Ignore these filepaths.
	"res://addons/gut",
	"res://addons/kanban_tasks",
	#"res://other/",
	#"res://tests/",
]


func _run() -> void:
	print(get_all_script_lines(), " lines")


func get_all_script_lines() -> int:
	var lines := 0
	var scripts := 0
	for path: String in Helper.get_dir_children("res://", true).files:
		if is_blacklisted(path) and !is_whitelisted(path): continue
		if path.get_extension() != "gd": continue
		lines += StringLib.get_lines_in_file(path)
		scripts += 1
		print(path + " has " + str(StringLib.get_lines_in_file(path)) + " lines")
	print(scripts, " scripts")
	return lines


func is_whitelisted(path: String) -> bool:
	for whitelist_path in whitelist:
		if path.contains(whitelist_path): return true
	return false


func is_blacklisted(path: String) -> bool:
	for blacklist_path in blacklist:
		if path.contains(blacklist_path): return true
	return false
