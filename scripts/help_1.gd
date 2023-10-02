extends Node2D

@onready var enemy = $"../DoubleJumpEnemy"
@onready var tab = $Tab
@onready var drag = $Drag

var tab_pressed = false
var click_pressed = false

func _process(delta):
	if not enemy and not tab_pressed and not click_pressed:
		tab.visible = true
	else:
		return
	
	if(Input.is_action_just_pressed("ui_focus_next") and not click_pressed):
		tab.visible = false
		drag.visible = true
		tab_pressed = true
	
