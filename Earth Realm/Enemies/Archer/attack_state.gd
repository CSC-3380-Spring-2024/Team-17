extends NodeState

#export these so we can control the veloity and animation
@export var character_body_2d : CharacterBody2D
@export var animated_sprite_2d : AnimatedSprite2D
@export var speed : int 

#when state is active and need to hold the player
var player : CharacterBody2D

var max_speed : int

func on_process(delta: float):
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func on_physics_process(delta : float):
	#find direction where the player is entering the area
	var direction : int
	
	if character_body_2d.global_position > player.global_position:
		animated_sprite_2d.flip_h = true
		direction -= 1
	elif character_body_2d.global_position < player.global_position:
		animated_sprite_2d.flip_h = false
		direction = 1
		
	animated_sprite_2d.play("Run")
	
	character_body_2d.velocity.x += direction * speed * delta
	character_body_2d.velocity.x = clamp(character_body_2d.velocity.x, -max_speed, max_speed)
	character_body_2d.move_and_slide()

func enter():
	player = get_tree().get_nodes_in_group("Player")[0] as CharacterBody2D
	max_speed = speed+20
func exit():
	pass
