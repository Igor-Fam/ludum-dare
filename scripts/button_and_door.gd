extends Node2D

var button_pressed

@onready var door = $Door
@onready var door_sprite = door.get_node("AnimatedSprite2D")
@onready var button_sprite = $Button.get_node("AnimatedSprite2D")

func _physics_process(delta):
	if(door_sprite.frame_progress == 1):
		door.process_mode = PROCESS_MODE_DISABLED

func open_door():
	door_sprite.play("default")


func _on_button_body_entered(body):
	if not body is Player or button_pressed:
		return
	
	SoundPlayer.play(SoundPlayer.BUTTON)
	button_sprite.frame = 1
	button_pressed = true
	open_door()
