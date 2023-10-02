extends Area2D

@export var enemy = true
@export var can_hit_enemy = false
var projectile = false

func _on_body_entered(body):
	print(body)
	if(!enemy):
		return
	
	if body is Player:
		get_tree().reload_current_scene()
	
	if body is Sword or (body is Laser and not body.enemy) and not projectile:
		get_parent().queue_free()
		if body is Laser:
			body.queue_free()
