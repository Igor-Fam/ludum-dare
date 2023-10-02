extends CharacterBody2D

const DROP = preload("res://nodes/modules/double_jump_item.tscn")
const SPEED = 35.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = 1
var jump_timer = 2
var double_jump_timer = 0.35
var can_jump = true
var can_double_jump = false

@onready var animatedSprite = $AnimatedSprite2D
@onready var visibleNotifier = $VisibleOnScreenNotifier2D

func _init():
	add_to_group("Enemies")

func _physics_process(delta):
	if(!visibleNotifier.is_on_screen()):
		return
	
	if is_on_floor():
		can_double_jump = true
		
		double_jump_timer = 0.35
		jump_timer -= delta
		
		if(jump_timer < 0):
			jump()
			jump_timer = 2
	else:
		double_jump_timer -= delta
		if(double_jump_timer < 0 and can_double_jump):
			jump()
			can_double_jump = false
		
		velocity.y += gravity * delta
	
	if is_on_wall():
		direction *= -1;
	
	velocity.x = direction * SPEED
	
	animatedSprite.flip_h = direction < 0
	
	move_and_slide()

func jump():
	velocity.y = JUMP_VELOCITY

func die():
	var drop = DROP.instantiate()
	get_tree().get_nodes_in_group("World")[0].add_child(drop)
	drop.position = position
	queue_free()
