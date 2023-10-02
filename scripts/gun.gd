extends Marker2D

@onready var bulletPos = $BulletOut
@onready var player = get_tree().get_nodes_in_group("Player")[0]

@export var enemy = false

func _process(delta):
	look_at(player.position if enemy else get_global_mouse_position())
