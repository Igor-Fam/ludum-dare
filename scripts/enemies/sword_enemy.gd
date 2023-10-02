extends CharacterBody2D

const SPEED = 25.0
const DROP = preload("res://nodes/modules/sword_item.tscn")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = 1
var has_dropped = false

@onready var sight = $Sight
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
		animatedSprite.animation = "idle"
	else:
		animatedSprite.animation = "walk"
		direction = sign(player.position.x - position.x)
		velocity.x = direction * SPEED
		sight.target_position.x = 50*direction
		
	
	animatedSprite.flip_h = direction < 0
	
	move_and_slide()

func player_in_range():
	var collider = sight.get_collider()
	return collider and collider.is_in_group("Player")

func die():
	if not has_dropped:
		SoundPlayer.play(SoundPlayer.ENEMY_HURT)
		has_dropped = true
		var drop = DROP.instantiate()
		get_tree().get_nodes_in_group("World")[0].add_child(drop)
		drop.position = position
		drop.position.y -= drop.size.y * 11
	queue_free()
