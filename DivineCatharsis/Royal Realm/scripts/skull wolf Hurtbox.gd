extends Area2D

@onready var animation = $AnimatedSprite2D

func _on_body_entered(body):
	if body.name == "user player":
		animation.play("Death")
		queue_free()
