extends NodeState
#Node name: Idle
#Script name; idle_state.gd
@export var character_body_2d : CharacterBody2D
@export var animated_sprite_2d : AnimatedSprite2D
@export var slow_down_speed : int = 400

func on_process(delta: float) -> void:
	pass

func on_physics_process(delta : float) -> void:
	character_body_2d.velocity.x = move_toward(character_body_2d.velocity.x, 0, slow_down_speed*delta)
	animated_sprite_2d.play("Idle")
	character_body_2d.move_and_slide()
	
func enter() -> void:
	pass

func exit() -> void:
	pass
