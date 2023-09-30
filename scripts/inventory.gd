extends Node2D
class_name Inventory

@export var modules: Array[Module]
var player

func _ready():
	player = get_parent()
	

func executeModuleBehaviours():
	for module in modules:
		var behaviour = module.behaviour.new()
		behaviour.executeBehaviour(player)
	
