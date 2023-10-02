extends Resource

const bulletPath = preload("res://nodes/laser.tscn")
var gun 

func executeBehaviour(player):
	if not player.ready:
		return
	
	if not gun:
		gun = player.get_node("Gun")
		gun.visible = true
		
	if Input.is_action_just_pressed("ui_right_click"):
		var bullet = bulletPath.instantiate()
		#player.gun.add_child(bullet)
		bullet.global_position = player.gun.bulletPos.global_position
		bullet.rotation = player.gun.rotation
		bullet.target = player.gun.get_global_mouse_position()
		bullet.get_node("Hitbox").enemy = false
		bullet.get_node("Hitbox").projectile = true
		player.get_parent().add_child(bullet)


