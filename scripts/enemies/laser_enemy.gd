extends CharacterBody2D


const SPEED = 35.0
const bulletPath = preload("res://nodes/laser.tscn")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction = 1
var walk_timer = 2.5
var aim_timer = 1
var shoot_timer = 0.8

@onready var animatedSprite = $AnimatedSprite2D
@onready var ledgeCheckRight = $LedgeCheckRight
@onready var ledgeCheckLeft = $LedgeCheckLeft
@onready var visibleNotifier = $VisibleOnScreenNotifier2D
@onready var gun = $Gun
@onready var player = get_tree().get_nodes_in_group("Player")[0]


func _init():
	add_to_group("Enemies")

func _physics_process(delta):
	if(!visibleNotifier.is_on_screen()):
		return
		
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if(walk_timer > 0):
		walk()
		
		aim_timer = 1
		walk_timer -= delta
	else:
		
		if(aim_timer > 0):
			aim_timer -= delta
			
			if(shoot_timer > 0):
				shoot_timer -= delta
			else:
				shoot()
				shoot_timer = 0.5
			
		else:
			walk_timer = 1.5
			shoot_timer = 0.5
	

func walk():
	if is_on_wall() || !(ledgeCheckRight.is_colliding() && ledgeCheckLeft.is_colliding()):
		direction *= -1;
	
	velocity.x = direction * SPEED
	
	animatedSprite.flip_h = direction > 0
	
	move_and_slide()

func shoot():
	var bullet = bulletPath.instantiate()
	bullet.enemy = true
	bullet.global_position = gun.bulletPos.global_position
	bullet.rotation = gun.rotation
	bullet.target = player.position
	bullet.get_node("Hitbox").projectile = true
	get_parent().add_child(bullet)
