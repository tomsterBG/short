# TODO

## State machine

- Needs very good planning to be done properly in a widely applicable way that wouldn't limit me.

## Spawner and Spawnable

- Needs figuring out how to better do timed tests.

## Change map

- A node which changes the current scene with the given PackedScene.
- Lets you execute custom code before that, and maybe after? Like how the state machine has an exiting function.

## Trigger gates

- Single trigger gate may be useless.
- Dual trigger gate however, that's interesting!

## Messages

- Needs better planning for cleaner code and a wider range of usecases. Also needs proper timed testing.
- It's just a message scene with internal stack and a helper method add_message("text", seconds), intended to streamline development of showing messages one after another for the chosen amount of time.
- The script should be decoupled from the style, so i can style the scene however i want and use the script for the functionality.

## CI

- Create a Github workflow that will spit out a downloadable artifact, ready for the asset lib.
