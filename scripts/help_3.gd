extends Node2D

@onready var enemy = $"../SwordEnemy"
@onready var click = $Click

var click_pressed = false

func _process(delta):
	if not enemy and not click_pressed:
		click.visible = true
	else:
		return
	
	if Input.is_action_just_pressed("ui_right_click"):
		click.visible = false
		click_pressed = true
