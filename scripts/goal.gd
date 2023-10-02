extends Area2D

@export var target_level: String

func _on_body_entered(body):
	if not body is Player or not target_level:
		return
	get_tree().change_scene_to_file(target_level)
