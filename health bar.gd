extends ProgressBar

@export var health: Health = null


func _enter_tree() -> void:
	health.health_changed.connect(on_health_changed)

func on_health_changed(difference: float):
	value = health.health
