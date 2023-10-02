extends CharacterBody2D
class_name Laser

var enemy = false
var speed
var target

func _physics_process(delta):
	if velocity.x + velocity.y == 0:
		speed = 150 if enemy else 300
		velocity = speed * position.direction_to(target)
	if move_and_slide():
		queue_free()

