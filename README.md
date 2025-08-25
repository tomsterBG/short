# About

Custom nodes, classes and globals designed to seamlessly integrate with Godot for easier game development.

This project is designed to be high quality (as much as i can, but nobody is perfect), to adhere to Godot standards and style guides, and to be useful to everyone, not just me.

Contents include:
- The GUT addon by bitwes for unit testing.
- Globals: Helper methods.
- Classes: Primarily components designed like default Godot nodes.
- Tests for globals and classes.

# How to use

Download the project and delete anything you don't need.
- Everything you need is in two folders: globals and classes. Everything else is just helping me develop this project.

Copy-paste whatever you want in your project.

# License

This project is licensed under GNU GPL v3 which basically means you can do absolutely everything, except take away people's freedom to access the source code.

My goal is not to limit people, but to ensure the code is always accessible. If you want to use this and the license is incompatible, feel free to contact me.

GUT has its own license, respect it.

# Convention

I try to be as consistent as possible.

Each script must follow rules that make it extendable, simple and understandable.

These rules include, but are not limited to:
- Full in-engine documentation with doc comments.
- Strict order of comments at the beginning of a script.
	- Order: IMPORTANT, INFO, TODO, IDEAS, BAD IDEAS.
- Strict order of regions, wrapped by region comments and separated by 2 lines.
	- Order: signals, enums, classes, constants, variables, setters, getters, methods, virtual methods, tests, internal.
- Everything within a region, with some exceptions, is to be separated by 1 line.
- Instead of var with getter, make getter functions separate. (this may change)
- If a func returns void, it mutates state. If it returns non-void, it doesn't mutate state, with some exceptions.
	- Exceptions are recognized by their name.
- If it starts with is_ or has_, it returns a bool.

Rules for test scripts:
- Each unit test should build on top of the ones before it, for easier troubleshooting.
	- Order each testcase in each script.
	- Order each test script.
	- As the Factorio devs have found, first run the tests that cover less dependent code. This way the first error will lead you closer to where the real problem is.
		- Say you test HealthPlus before Health and there's an error in HealthPlus. This error may be because of Health, but that isn't clear. Ordering tests makes it clearer.
- If a test makes an assumption, test the assumption before, or put a WARNING comment.

If in doubt, just write code however you want. Then look at how i've done it in other scripts and refactor your code. The health script is by far the best representative of how it should be done.
