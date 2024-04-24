extends CharacterBody2D

@onready var animation = $AnimatedSprite2D

@export var speed = -125
@export var gravity = 40
@export var jump_force = 75

var facing_right = false


func _physics_process(delta):
	if !is_on_floor():
		velocity.y += gravity
		if velocity.y > 500:
			velocity.y = 500
			
	if !$RayCast2D.is_colliding() && is_on_floor:
		flip()

	velocity.x = speed
	move_and_slide()


func flip():
	facing_right = !facing_right
	
	scale.x = abs(scale.x) * -1
	if facing_right:
		speed = abs(speed)
	else:
		speed = abs(speed) * -1

func _ready():
	if velocity.x != 0:
		animation.play("Attack")
