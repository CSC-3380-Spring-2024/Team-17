extends CharacterBody2D

@onready var animation = $AnimatedSprite2D

func _ready():
	if velocity.x == 0:
		animation.play("pray")
