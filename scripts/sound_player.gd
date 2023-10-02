extends Node

@onready var audioPlayers = $AudioPlayers

const ENEMY_HURT = preload("res://assets/sounds/damage.wav")
const PLAYER_HURT = preload("res://assets/sounds/player_damage.wav")
const PLAYER_LASER = preload("res://assets/sounds/laser.wav")
const ENEMY_LASER = preload("res://assets/sounds/enemy_laser.wav")
const SWORD = preload("res://assets/sounds/sword_swing.wav")
const ITEM_GRAB = preload("res://assets/sounds/item_grab.wav")
const ITEM_DROP = preload("res://assets/sounds/item_drop.wav")
const DASH = preload("res://assets/sounds/dash.wav")
const JUMP = preload("res://assets/sounds/jump.wav")
const DOUBLE_JUMP = preload("res://assets/sounds/double_jump.wav")
const BUTTON = preload("res://assets/sounds/button.wav")

func play(sound):
	for audioStreamPlayer in audioPlayers.get_children():	
		if not audioStreamPlayer.playing:
			audioStreamPlayer.stream = sound
			audioStreamPlayer.play()
			break
