extends Sprite2D

var timer_on = 0
var timer_off = 0
var on = false

@onready var raycast = $RayCast2D
@onready var laser = $Laser

func _physics_process(delta):
	
	if(!on):
		raycast.enabled = false
		laser.clear_points()
		timer_off += delta
		
		if(timer_off >= 0.2):
			on = !on
			timer_on = 0
		
		return
		
	timer_on += delta
	
	if(timer_on >= 1.7):
		on = !on
		timer_off = 0
	
	raycast.enabled = true
	
	var collision_point = raycast.get_collision_point()
	
	var target = collision_point if collision_point else raycast.target_position
	cast_laser(target)
	
	var collider = raycast.get_collider()
	
	if not collider:
		return
	
	if collider is Player:
		get_tree().reload_current_scene()
	
	if collider.is_in_group("Enemies"):
		collider.queue_free()

func cast_laser(target):
	laser.clear_points()
	laser.add_point(position)
	laser.add_point(target)
	
	
