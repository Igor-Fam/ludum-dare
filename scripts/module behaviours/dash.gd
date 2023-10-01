extends Resource

@export var DASH_SPEED = 600

func executeBehaviour(player):
	if not player.ready:
		return
	if Input.is_action_just_pressed("ui_shift") and player.state == player.MOVE and player.dash_cooldown == 0:
		player.velocity.x = DASH_SPEED * (-1 if player.animatedSprite.flip_h else 1)
		player.state = player.DASH
		player.dash_cooldown = 0.5
		player.dash_timer = 0.03
