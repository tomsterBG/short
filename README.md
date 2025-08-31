# Godot short - Code shortening scripts for Godot 4.

# About

Various scripts designed to make your code shorter and more elegant.

These scripts are like black boxes. No need to worry about what's inside. Everything is documented. They are also tested, so no need to worry about bugs.
- Using this allows you to write less code, yet focus on more complex features.

This project is designed to...
...be high quality (as much as i can, but nobody is perfect).
...seamlessly integrate with the engine.
...adhere to Godot standards and style guides.
...be as simple as possible.
...be useful to everyone, not just me.
...achieve more with less.

# Content

- The GUT addon by bitwes for unit testing.
- Classes: Helper methods.
- Components: Designed like Godot nodes. Health.
- Tests for the above.
- Other things. Either unused or specific to this project.

# Why use this?

Before even stepping forward, you should know why you're using this.

## Shorter code

Personally i don't find writing to be a problem. Autocompletion exists.
However when reading code, i would do everything i can to help my brain see less, because that lets me focus on what's truly important.
I don't want to figure out...
...a math formula and every time i read it again, ask myself "What does this do here?".
...how to access files every time i need file access.
All that slows me down.

Long story *short*, hehe, figuring things out once is faster than dealing with them multiple times.
- **Note:** If you're new to programming, this might be too much of a power tool for you. Consider using it later.

# How to use?

Download the project and delete anything you don't need.
- Everything you need is in two folders: classes and components. Everything else is just helping me develop this project.
- Careful with deleting things in the two folders. Some scripts depend on each other. You can see which script depends on which by looking at `script_order_hook.gd`.

# License

This project is licensed under MIT which basically means you can do absolutely everything, except sue me.

My goal is not to limit people which is why i changed it from my original choice which was GPL V3. It makes a lot of sense to use GPL for FOSS, such as preventing distributors from taking away one's freedom to access the source code. However with games this just hurts the wrong people by preventing you from exporting to closed platforms like IOS.

If you want to use this and the license is incompatible, feel free to contact me. Though what are you doing if MIT is incompatible?

GUT has its own MIT license, respect it. I recommend just deleting my copy of GUT and using one from the asset library.

# Convention

I try to be as consistent as possible.

Each script must follow rules that make it extendable, simple and understandable.

## These rules include, but are not limited to

**Regions:**
- Strict order of regions, wrapped by region comments and separated by 2 lines.
	- Order: signals, enums, classes, constants, variables, setters, getters, methods, virtual methods, tests, internal.
- Everything within a region, with some exceptions, is to be separated by 1 line.
- Each nested region comment must be indented correctly.

**Other:**
- Full in-engine documentation with doc comments.
- Strict order of comments at the beginning of a script.
	- Order: IMPORTANT, INFO, NOTE, TODO, IDEAS, BAD IDEAS.
- Getter functions usually don't need a variable associated with them.
	- This getter is useless: `get_health() -> float: return health`.
	- This doesn't need a health_ratio var: `get_health_ratio() -> float: return health / max_health`.
- If a func returns void, it mutates state. If it returns non-void, it doesn't mutate state, with some exceptions.
	- Exceptions are recognized by their name.
	- If the func returns self or a class inside self, it mutates state. Like `Health.damage()`.
- If it starts with is_ or has_, it returns a bool.
- If an inherited method is overwritten, ensure to note that in the description of the class.

## Rules for test scripts

- Each unit test should build on top of the ones before it, for easier troubleshooting.
	- Order each testcase in each script.
	- Order each test script.
	- As the Factorio devs have found, first run the tests that cover less dependent code. This way the first error will lead you closer to where the real problem is.
		- If Health has a bug, the error will also show up in HealthPlus. If you don't have a strict order for the tests, how do you determine which error to fix?
- Tests should only assume already asserted facts.
	- If a test makes an assumption, that wasn't asserted earlier, put a WARNING comment.
- If something is untested, add "@experimental: Untested." where it is defined, not where it is tested.

If in doubt, just write code however you want. Then look at how i've done it in other scripts and refactor your code. The health script is by far the best representative of how it should be done.
