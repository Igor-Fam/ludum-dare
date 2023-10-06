extends CharacterBody2D
class_name Sword

var direction
var swing_time = 0.23

@onready var collision = $CollisionShape2D
@onready var sprite = $Sprite2D
@onready var player = get_parent()

func _physics_process(delta):
	direction = -1 if sprite.flip_h else 1
	sprite.flip_h = player.animatedSprite.flip_h
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

	
	if(Input.is_action_just_pressed("ui_right_click")):
		sprite.animation = "swing"
		sprite.play("swing")
		SoundPlayer.play(SoundPlayer.SWORD)
		
	move_and_slide()

