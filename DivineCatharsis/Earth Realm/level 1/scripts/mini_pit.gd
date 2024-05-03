extends Area2D

@onready var respawnPosition := Vector2(2381, 411)

func _on_body_entered(body):
	if "charaOne" in body.name:
		respawn()

func respawn():
	if $"../Player/charaOne":
		$"../Player/charaOne".global_position = respawnPosition
