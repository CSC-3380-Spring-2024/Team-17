extends Area2D

@onready var animation = $AnimatedSprite2D

func _ready():
	animation.play("idle")


func _on_body_entered(body):
	if body.name == "user player":
		queue_free()
	
