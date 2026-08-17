extends GutTest


#region variables
## Info about all files this test cares about. Key is filename.
var files: Dictionary[StringName, FileInfo] = {}
#endregion variables


#region methods
## Populates [member files].
func populate_files():
	for path in Helper.get_dir_children(GConst.SHORT_PATH, GConst.RECURSIVE).files:
		if !path.get_extension() == "gd": continue
		var new_file_info := FileInfo.new()
		new_file_info.filename = path.get_file().trim_suffix(".%s" % path.get_extension())
		new_file_info.path_short = path
		new_file_info.functions_short = StringLib.get_function_names(FileAccess.get_file_as_string(path))
		files[new_file_info.filename] = new_file_info
	for path in Helper.get_dir_children(GConst.TESTS_PATH, GConst.RECURSIVE).files:
		if !path.get_extension() == "gd": continue
		var filename := path.get_file().trim_prefix("test_").trim_suffix(".%s" % path.get_extension())
		if !files.has(filename): continue
		files[filename].path_tests = path
		files[filename].functions_tests = StringLib.get_function_names(FileAccess.get_file_as_string(path))
#region methods


#region virtual
func before_all():
	populate_files()
#endregion virtual


#region tests
func test_all_scripts_have_tests():
	## Filenames of all addon scripts with missing test scripts.
	var missing_script_names: Array[String] = []
	for filename in files:
		if filename == "plugin": continue
		elif files[filename].path_short.is_empty() or files[filename].path_tests.is_empty():
			missing_script_names.append(filename)
	assert_eq(missing_script_names, [], "All scripts have corresponding test scripts.")

func test_all_functions_have_tests():
	var missing_functions: Array[String] = []
	for filename in files:
		if filename == "plugin": continue
		for function in files[filename].functions_short:
			if !files[filename].functions_tests.has("test_%s" % function):
				missing_functions.append("%s/%s" % [filename, function])
	assert_eq(missing_functions, [], "All fumctions have corresponding tests.")
#endregion tests


#region classes
class FileInfo:
	## The name of the file without an extension.
	var filename: StringName
	## The filepath in short.
	var path_short: String
	## The filepath in tests.
	var path_tests: String
	## All function names in short.
	var functions_short: PackedStringArray
	## All function names in tests.
	var functions_tests: PackedStringArray
#endregion classes
