extends Marker2D

@onready var bulletPos = $BulletOut

func _process(delta):
	look_at(get_global_mouse_position())
