extends CharacterBody2D


const SPEED = 35.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = 1

@onready var animatedSprite = $AnimatedSprite2D
@onready var ledgeCheckRight = $LedgeCheckRight
@onready var ledgeCheckLeft = $LedgeCheckLeft
@onready var visibleNotifier = $VisibleOnScreenNotifier2D

func _init():
	add_to_group("Enemies")

func _physics_process(delta):
	if(!visibleNotifier.is_on_screen()):
		return
		
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if is_on_wall() || !(ledgeCheckRight.is_colliding() && ledgeCheckLeft.is_colliding()):
		direction *= -1;
	
	velocity.x = direction * SPEED
	
	animatedSprite.flip_h = direction < 0
	
	move_and_slide()

func die():
	SoundPlayer.play(SoundPlayer.ENEMY_HURT)
	queue_free()
