extends Resource

const bulletPath = preload("res://nodes/bullet.tscn")

func executeBehaviour(player):
	if not player.ready:
		return
		
	if Input.is_action_just_pressed("ui_right_click"):
		var bullet = bulletPath.instantiate()
		#player.gun.add_child(bullet)
		bullet.global_position = player.gun.bulletPos.global_position
		bullet.rotation = player.gun.rotation
		bullet.velocity = bullet.speed * bullet.position.direction_to(player.gun.get_global_mouse_position())
		player.get_parent().add_child(bullet)
		print (bullet.position)
		

