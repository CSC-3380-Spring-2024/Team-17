extends NinePatchRect

@onready var checkButton : Button = $VBoxContainer/TryAgain


func _on_try_again_pressed() -> void:
	get_tree().change_scene_to_file("res://Earth Realm/level 1/scenes/Riddle.tscn")
