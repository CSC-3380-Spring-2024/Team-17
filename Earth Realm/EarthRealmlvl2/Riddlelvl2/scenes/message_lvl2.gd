extends NinePatchRect

@onready var TryAgain = $VBoxContainer/TryAgain

func _on_try_again_pressed():
	get_tree().change_scene_to_file("res://EarthRealmlvl2/Riddlelvl2/scenes/riddle_earth_lvl2.tscn") 
	