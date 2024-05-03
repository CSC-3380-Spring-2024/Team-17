extends CharacterBody2D

@export var gravity = 40
@onready var animation = $AnimatedSprite2D

func _ready():
	if velocity.x == 0:
		animation.play("idle")
		
