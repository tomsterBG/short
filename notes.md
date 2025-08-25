# Noticed things about the engine

```gdscript
class_name Health extends Node
# works

extends Node
class_name Health
# works

extends Node class_name Health
# errors
```

```gdscript
## [param 0]
# looks good

## [param [0]]
# looks bad

## [param [0\]]
# looks bad

## [param [0[rb]]
# looks bad
```

```gdscript
# - emit reneration signals for when regen state changes (is_regenerating), when fully regenerated (ensure this one doesn't emit when manually fully regenerating) <- shows red only if cursor is after ) because wrapped line can't see the previous line
```

When i have doc comments after a region comment, the collapse triangle for the doc comments disappears if there isn't an empty line.

# GUT

https://github.com/bitwes/Gut

# My first experience with health using GUT

It is amazing and the code ends up very short and readable for the component while the test suite explains what the code should do.

# Factorio

https://www.factorio.com/blog/post/fff-366

Test order: First run the tests that cover less dependent code. In my case i first want to test Health and then HealthPlus. This way the first error will lead me closer to where the real problem is.
- Also order each testcase in each script.

# Code

Instead of var with getter, only make a getter function.
