extends CharacterBody2D

const DROP = preload("res://nodes/modules/dash_item.tscn")
const SPEED = 35.0
const DASH_SPEED = 600

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var dash_available = true
var dash_timer = 0
var in_dash = false
var has_dropped = false

@export var dash_cooldown = 2.5
@export var direction = -1

@onready var animatedSprite = $AnimatedSprite2D
@onready var ledgeCheckRight = $LedgeCheckRight
@onready var ledgeCheckLeft = $LedgeCheckLeft
@onready var visibleNotifier = $VisibleOnScreenNotifier2D

func _init():
	add_to_group("Enemies")

func _physics_process(delta):
	if(in_dash):
		velocity.x = DASH_SPEED * direction
		dash(delta)
		return
	
	dash_cooldown -= delta
	if(dash_cooldown < 0):
		in_dash = true
		dash_cooldown = 2.5
	
	if(!visibleNotifier.is_on_screen()):
		return
		
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if is_on_wall() || (!(ledgeCheckRight.is_colliding() && ledgeCheckLeft.is_colliding()) and !in_dash) and is_on_floor():
		direction *= -1;
	
	velocity.x = direction * SPEED
	
	animatedSprite.flip_h = direction < 0
	
	move_and_slide()

func dash(delta):
	velocity.x = move_toward(velocity.x, 0, delta * 1000)
	velocity.y = 0
	
	if(dash_timer >= 0.08):
		dash_timer = 0
		SoundPlayer.play(SoundPlayer.DASH)
		velocity.x = SPEED * (-1 if animatedSprite.flip_h else 1)
		in_dash = false
	
	move_and_slide()	
	
	dash_timer += delta

func die():
	if not has_dropped:
		SoundPlayer.play(SoundPlayer.ENEMY_HURT)
		has_dropped = true
		var drop = DROP.instantiate()
		get_tree().get_nodes_in_group("World")[0].add_child(drop)
		drop.position = position
		drop.position.y -= drop.size.y * 11
	queue_free()
