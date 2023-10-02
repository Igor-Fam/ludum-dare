extends CharacterBody2D


const SPEED = 35.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = 1

@onready var animatedSprite = $AnimatedSprite2D
@onready var visibleNotifier = $VisibleOnScreenNotifier2D
@onready var player = get_tree().get_nodes_in_group("Player")[0]

func _init():
	add_to_group("Enemies")

func _physics_process(delta):
	if(!visibleNotifier.is_on_screen()):
		return
	
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if(abs(player.position.x - position.x) <= 3):
		velocity.x = 0
	else:
		direction = sign(player.position.x - position.x)
		velocity.x = direction * SPEED
		
	
	animatedSprite.flip_h = direction > 0
	
	move_and_slide()
