extends Node2D



func _on_quit_pressed() -> void:
	get_tree().change_scene_to_file("res://GUI//scenes//Quit Screen.tscn")


func _on_instructions_pressed() -> void:
	get_tree().change_scene_to_file("res://GUI//scenes//Instruction Screen.tscn")


func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Earth Realm/level 1/scenes/Mystic_Forest_Map.tscn")



