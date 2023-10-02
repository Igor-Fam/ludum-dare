extends Node

var sword

func executeBehaviour(player):
	if not player.ready:
		return
	
	if not sword:
		sword = player.get_node("Sword")
	
	sword.visible = true
	sword.process_mode = PROCESS_MODE_INHERIT
