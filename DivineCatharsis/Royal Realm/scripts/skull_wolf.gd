extends CharacterBody2D

@onready var animation = $AnimatedSprite2D

@export var speed = -125
@export var gravity = 40
@export var jump_force = 75

var facing_right = false
var health_amount : int = 200


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
		
func _on_hurtbox_area_entered(area):
	animation.play("Death")
	
func _on_body_entered(body):
	if body.name == "user player":
		animation.play("Death")
		queue_free()

func enemy():
	pass
	
func _on_hurtbox_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	if area.get_parent().has_method("get_damage_amount"):
		var node = area.get_parent() as Node
		health_amount -= node.damage_amount
		print("Health amount", health_amount)

		if health_amount <= 0:
			queue_free()
		
