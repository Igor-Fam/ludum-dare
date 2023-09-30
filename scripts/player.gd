extends CharacterBody2D
class_name Player

enum {
	MOVE,
	CLIMB,
	DASH
}

const SPEED = 100.0
const JUMP_VELOCITY = -300.0
const MAX_VELOCITY = 900

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity_val = ProjectSettings.get_setting("physics/2d/default_gravity")
var gravity

var state = MOVE

var double_jump_available = false
var dash_available = true
var dash_timer = 0
var dash_cooldown = 1.2

@onready var animatedSprite = $AnimatedSprite2D
@onready var ladderCheck = $LadderCheck
@onready var inventory = $Inventory
@onready var gun = $Gun

func _physics_process(delta):
	match state:
		MOVE: move_state(delta)
		CLIMB: climb_state(delta)
		DASH: dash_state(delta)

#States
func move_state(delta):
	if is_on_ladder() && Input.is_action_pressed("ui_up"):
		state = CLIMB
	
	inventory.executeModuleBehaviours()
	
	move_x(delta)
	move_y_gravity(delta)
	move_and_slide()
	
	update_dash_cooldown(delta)

func climb_state(delta):
	if !(is_on_ladder() && Input.is_action_pressed("ui_up")):
		state = MOVE
	
	move_x(delta)
	move_y_climb()
	move_and_slide()

func dash_state(delta):
		
	velocity.x = move_toward(velocity.x, 0, delta * 1000)
	velocity.y = 0
	
	if(dash_timer >= 0.08):
		dash_timer = 0
		velocity.x = SPEED * (1 if animatedSprite.flip_h else -1)
		state = MOVE
	
	move_and_slide()	
	
	dash_timer += delta

#Movement and collision
func move_x(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var friction = delta * (900.0 if is_on_floor() else 300.0)
	var acceleration = delta * (1500.0 if is_on_floor() else 900.0)
	
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction:
		animatedSprite.animation = "Run"
		animatedSprite.flip_h = direction > 0
		velocity.x = move_toward(velocity.x, direction * SPEED, acceleration)
	else:
		animatedSprite.animation = "Idle"
		velocity.x = move_toward(velocity.x, 0, friction)

func move_y_gravity(delta):
	if not is_on_floor():
		animatedSprite.animation = "Jump"
		
		if(velocity.y < 0):
			animatedSprite.frame = 0
			if Input.is_action_just_released("ui_accept"):
				gravity *= 2
		else:
			animatedSprite.frame = 1
			gravity = gravity_val * delta
			
		velocity.y = move_toward(velocity.y, MAX_VELOCITY, gravity)
	else:
		gravity = gravity_val * delta
		double_jump_available = true
	
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

func move_y_climb():
	velocity.y = -SPEED

func is_on_ladder():
	if(!ladderCheck.is_colliding()):
		return false
	
	var collider = ladderCheck.get_collider()
	
	if !(collider is Ladder):
		return false;
	
	return true

func update_dash_cooldown(delta):
	dash_cooldown = move_toward(dash_cooldown, 0, delta)

