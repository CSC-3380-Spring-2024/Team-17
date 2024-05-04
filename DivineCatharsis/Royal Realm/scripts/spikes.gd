extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	pass


func _on_body_entered(body) -> void:
	if "charaThree" in body.name:
		get_tree().change_scene_to_file("res://Royal Realm/scenes/world.tscn")
	
