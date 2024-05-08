extends CharacterBody2D

@onready var animation : AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	if velocity.x == 0:
		animation.play("default")
