# About

Custom nodes, components and globals designed to seamlessly integrate with Godot for easier game development.

This project is designed to be high quality (as much as i can, but nobody is perfect), to adhere to Godot standards and style guides, and to be useful to everyone, not just me.

Contents include:
- The GUT addon by bitwes for unit testing.
- Globals: Helper methods.
- Components: Designed like Godot nodes.
- Tests for globals and components.

# How to use

Download the project and delete anything you don't need.
- Everything you need is in two folders: globals and components. Everything else is just helping me develop this project.

Copy-paste whatever you want in your project.

# License

This project is licensed under MIT which basically means you can do absolutely everything, except sue me.

My goal is not to limit people which is why i changed it from my original choice which was GPL V3. It makes a lot of sense to use GPL for FOSS, such as preventing distributors from taking away one's freedom to access the source code. However with games this just doesn't make much sense and most Godot tools are MIT for a good reason, which is why i switch now when it's still possible.

If you want to use this and the license is incompatible, feel free to contact me. Though what are you doing if MIT is incompatible?

GUT has its own MIT license, respect it.

# Convention

I try to be as consistent as possible.

Each script must follow rules that make it extendable, simple and understandable.

These rules include, but are not limited to:
- Full in-engine documentation with doc comments.
- Strict order of comments at the beginning of a script.
	- Order: IMPORTANT, INFO, NOTE, TODO, IDEAS, BAD IDEAS.
- Strict order of regions, wrapped by region comments and separated by 2 lines.
	- Order: signals, enums, classes, constants, variables, setters, getters, methods, virtual methods, tests, internal.
- Everything within a region, with some exceptions, is to be separated by 1 line.
- Instead of var with getter, only make a getter function if it's modifying something.
	- This just looks like bloat: `get_health() -> float: return health`
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
