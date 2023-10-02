extends Area2D

var projectile = false

@export var enemy = true
@export var can_hit_enemy = false
@export var can_be_hit = true

@onready var sword = get_parent() is EnemySword

func _on_body_entered(body):
	if(!enemy):
		return
	
	if body is Player:
		SoundPlayer.play(SoundPlayer.PLAYER_HURT)
		get_tree().reload_current_scene()
		
	if(not can_be_hit):
		return
		
	if body is Sword or (body.name == "Laser" and not body.enemy) and not projectile and not sword:
		get_parent().die()
		if body is Laser:
			body.queue_free()

func _on_area_entered(area):
	print(area)
	var parent = area.get_parent()
	if(parent && parent is Spikes):
		get_parent().die()
