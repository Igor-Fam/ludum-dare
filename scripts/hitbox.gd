extends Area2D

var projectile = false

@export var enemy = true
@export var can_hit_enemy = false

@onready var sword = get_parent() is EnemySword

func _on_body_entered(body):
	if(!enemy):
		return
	
	if body is Player:
		get_tree().reload_current_scene()
	
	if body is Sword or (body is Laser and not body.enemy) and not projectile and not sword:
		get_parent().die()
		if body is Laser:
			body.queue_free()
