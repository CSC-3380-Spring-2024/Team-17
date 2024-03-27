extends CharacterBody2D

var SPEED = 50
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player
var chase = false

func _physics_process(delta):
	# Gravity for Frog
	velocity.y += gravity * delta
	if chase:
		get_node("AnimatedSprite2D").play("Walk")
		player = get_node("../../Player/TestCharacter")
		var direction = (player.position - position).normalized(
		if direction.x > 0:    
			get_node("AnimatedSprite2D").flip_h = false
		else:
			get_node("AnimatedSprite2D").flip_h = true
		velocity.x = direction.x * SPEED
	else:
		get_node("AnimatedSprite2D").play("Idle")
		velocity.x = 0
	move_and_slide()

func _on_player_detection_body_entered(body):
	if body.name == "TestCharacter":
		chase = true

func _on_player_detection_body_exited(body):
	if body.name == "TestCharacter":
		chase = false
