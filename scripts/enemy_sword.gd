extends Node2D
class_name EnemySword

var direction
var cooldown = 0
var swing_time = 0.23


@onready var hitbox = $Hitbox
@onready var collision = hitbox.get_child(0)
@onready var sprite = $Sprite2D
@onready var enemy = get_parent()

func _physics_process(delta):
	cooldown -= delta
	
	direction = enemy.direction
	sprite.flip_h = direction < 0
	collision.position.x = 17 * direction
	
	collision.disabled = true
	
	if(sprite.animation == "swing"):
		if(swing_time <= 0.17):
			collision.disabled = false
		
		sprite.position.x = 13 * direction
		
		if swing_time <=0:
			sprite.animation = "idle"
			sprite.position.x = 6 * direction
			swing_time = 0.23
		else:
			swing_time -= delta
	else:
		sprite.position.x = 6 * direction

	
	if(cooldown <= 0 and enemy.player_in_range()):
		SoundPlayer.play(SoundPlayer.SWORD)
		sprite.play("swing")
		cooldown = 1

