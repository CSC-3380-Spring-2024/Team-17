extends CharacterBody2D

@onready var animation = $AnimatedSprite2D

@export var speed = 125
@export var gravity = 40
@export var jump_force = 75

var facing_right = true


func _physics_process(delta):
	if !is_on_floor():
		velocity.y += gravity
		if velocity.y > 500:
			velocity.y = 500
