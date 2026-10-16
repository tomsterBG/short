## @experimental: This class could change.
## Work with audio.
##
## Available in all scripts without any setup.

@abstract class_name AudioLib extends Object


#region constants
## A scene containing an untouched [AudioStreamPlayer].
##[br][br][b]Note:[/b] Useful for [method play_persistent]'s [param scene] parameter default.
const AUDIO_STREAM_PLAYER_SCENE: PackedScene = preload("uid://ba8ngs2g857pm")
#endregion constants


#region methods
## Plays a stream that persists through scene changes. Use [param scene] to change the [AudioStreamPlayer] that will be used. See also [method AudioStreamPlayer.play].
##[br][br][b]Note:[/b] Useful for sounds triggered right before the scene will change.
static func play_persistent(stream: AudioStream, from_position: float = 0.0, scene: PackedScene = AUDIO_STREAM_PLAYER_SCENE) -> void:
	assert(stream, "Missing stream.")
	var player: AudioStreamPlayer = scene.instantiate()
	player.stream = stream
	(Engine.get_main_loop() as SceneTree).root.add_child(player)
	player.finished.connect(player.queue_free)
	player.play(from_position)
#endregion methods
