extends Area2D



func _on_body_entered(body):
	if "charaOne" in body.name:
		get_tree().change_scene_to_file("res://EarthRealmlvl2/Riddlelvl2/scenes/riddle_earth_lvl2.tscn")