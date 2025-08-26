# INFO:
# When adding new test scripts, add them here.
# First are global scripts. If a script has a dependency, its dependency must be tested first.
# TODO:
# - Add a system to append unadded scripts and tell me about it.
# - Turn this into a dependency table.

extends GutHookScript


#region virtual methods
func run():
	var ordered_tests := [
		# Globals:
		"res://tests/test helpers.gd",
		# Components:
		"res://tests/test health.gd",
		"res://tests/test health plus.gd",
	]
	
	gut.logger.info("Pre-run hook is re-ordering the tests.")
	
	for test_script in gut.get_test_collector().scripts:
		if ordered_tests.has(test_script.path): continue
		ordered_tests.append(test_script.path)
		push_warning(str(test_script.path) + " is not added to pre-run order.")
	
	gut.get_test_collector().clear()
	for test_path in ordered_tests:
		gut.add_script(test_path)
	
	gut.logger.info("Hook has finished re-ordering tests.")
#endregion virtual methods
