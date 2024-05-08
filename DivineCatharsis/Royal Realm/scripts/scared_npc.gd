extends CharacterBody2D

@export var gravity : int = 40
@onready var animation : AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	if velocity.x == 0:
		animation.play("idle")
		
