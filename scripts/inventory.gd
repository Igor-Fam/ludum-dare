extends Node2D
class_name Inventory

@onready var display = $InventoryDisplay

@export var modules: Array[Module]
var player

func _ready():
	player = get_parent()

func _physics_process(delta):
	if(Input.is_action_pressed("ui_focus_next")):
		display.process_mode = Node.PROCESS_MODE_INHERIT
		display.visible = true
	else:
		display.process_mode = Node.PROCESS_MODE_DISABLED
		display.visible = false

func executeModuleBehaviours():
	for module in modules:
		var behaviour = module.behaviour.new()
		behaviour.executeBehaviour(player)
	
signal item_changed(indexes)

