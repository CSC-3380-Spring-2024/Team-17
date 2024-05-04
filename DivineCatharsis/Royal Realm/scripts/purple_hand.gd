extends CharacterBody2D

@onready var animation = $AnimatedSprite2D

func _ready():
	if velocity.x == 0:
		animation.play("default")

func enemy():
	pass


func _on_hurtbox_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	animation.play("hurt")
