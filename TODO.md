# TODO

## Weighted list

An abstract system for weighted elements and a list with methods to control these elements.
- Element class with value and weight.
- Pick a random element by accounting for the weight, or 1 by default.
- Filter duplicate values.

## Camera switcher

A Node that holds references to cameras and provides useful ways to switch between them.
- Shortcut to cycle cameras.
- Shortcut for each specific camera view.
- Enable, disable, change and rebind each shortcut.

## State machine

- Needs very good planning to be done properly in a widely applicable way that wouldn't limit me.

## Spawner and Spawnable

- Needs figuring out how to better do timed tests.

## Change map

- A node which changes the current scene with the given PackedScene.
- Lets you execute custom code before that, and maybe after? Like how the state machine has an exiting function.
- An option to just replace a map instead of the whole scene. This may need it to become more abstract.

## Trigger gates

- Single trigger gate may be useless.
- Dual trigger gate however, that's interesting!

## Messages

- Needs better planning for cleaner code and a wider range of usecases. Also needs proper timed testing.
- It's just a message scene with internal stack and a helper method add_message("text", seconds), intended to streamline development of showing messages one after another for the chosen amount of time.
- The script should be decoupled from the style, so i can style the scene however i want and use the script for the functionality.

## CI

- Create a Github workflow that will spit out a downloadable artifact, ready for the asset lib.

## Templates

Specific scripts that are game-specific and aren't suitable for this because you HAVE to modify them. However, instead of writing one from scratch, you can just copy the template.
- Signal bus.
- Constants.
- Magic numbers.

It must be well distinct that these scripts are supposed to be edited by you per-game and aren't just black boxes.

They support good coding practices.

# Ideas

## CameraZoom

Holds a simple variable that can increase or decrease when you call zoom_in() and zoom_out().
The idea is that the camera would hold a reference to this zoom component and use its variable in its own calculations.
This may just be useless because the component is too narrow and of low use.

## LogicGate

Choose type and number of inputs, evaluate output.
