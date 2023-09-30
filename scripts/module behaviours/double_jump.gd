extends Resource

func executeBehaviour(player):
	if not player.ready:
		return
	if Input.is_action_just_pressed("ui_accept") and not player.is_on_floor() and player.double_jump_available:
		player.velocity.y = player.JUMP_VELOCITY
		player.double_jump_available = false

