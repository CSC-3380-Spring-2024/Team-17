extends Area2D


# Called when the node enters the scene tree for the first time.
#func _ready():
#	pass 
	

@onready var respawnPosition : Vector2 = Vector2(4171, 157)

func _on_body_entered(body : CharacterBody2D) -> void:
	if "charaOne" in body.name:
		
		respawn()

func respawn() -> void:
	if $"../Player/charaOne":
		$"../Player/charaOne".global_position = respawnPosition
