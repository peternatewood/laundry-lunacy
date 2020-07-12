extends Node2D

onready var audio_players = get_node("Audio Players").get_children()


func play_sound():
	for player in audio_players:
		if player.playing:
			return false

	audio_players[randi() % 2].play()
