extends Node2D

@onready var enemy = $"../DashEnemy"
@onready var shift = $Shift

var shift_pressed = false

func _process(delta):
	if not enemy and not shift_pressed:
		shift.visible = true
	else:
		return
	
	if Input.is_action_just_pressed("ui_shift"):
		shift.visible = false
		shift_pressed = true

	
