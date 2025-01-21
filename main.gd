extends Node2D


func _ready() -> void:
	#Utils.saveGame()
	Utils.loadGame()

func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://world.tscn")
	Game.playerHP = 10
	
