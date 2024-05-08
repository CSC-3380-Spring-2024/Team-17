extends Area2D

@onready var respawnPosition : Vector2 = Vector2(273,312)





func respawn() -> void:
	if $"../Player/charaOne":
		$"../Player/charaOne".global_position = respawnPosition



func _on_body_entered(body : CharacterBody2D) -> void:
	if "charaOne" in body.name:
		print("This is level two box")
		respawn()
