extends Node2D



func _on_quit_pressed():
	get_tree().change_scene_to_file("res://Quit Screen.tscn")


func _on_instructions_pressed():
	get_tree().change_scene_to_file("res://Instruction Screen.tscn")


func _on_play_pressed():
	get_tree().change_scene_to_file("res://Load Game.tscn")



