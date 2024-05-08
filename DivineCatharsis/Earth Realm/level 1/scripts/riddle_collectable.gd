extends Area2D



func _on_body_entered(body : CharacterBody2D) -> void:
	if "charaOne" in body.name:
		get_tree().change_scene_to_file("res://Earth Realm/level 1/scenes/Riddle.tscn")
