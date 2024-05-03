extends CharacterBody2D

var enemy_nightborne_death_effect = preload("res://Earth Realm/level 1/scenes/enemy_nightborne_death_effect.tscn")

@export var patrol_points : Node
@export var speed : int = 1500
@export var wait_time : int = 3
@export var health_amount: int = 100

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var timer = $Timer

const GRAVITY = 1000

enum State {Idle, Walk, Attack, Death, GetHit}
var current_state : State
var direction : Vector2 = Vector2.LEFT
var number_of_points : int
var point_positions : Array[Vector2]
var current_point : Vector2
var current_point_position : int

var can_walk : bool
var charainarea : bool

# Called when the node enters the scene tree for the first time.
func _ready():
	if patrol_points != null:
		number_of_points = patrol_points.get_children().size()
		for point in patrol_points.get_children():
			point_positions.append(point.global_position)
		current_point = point_positions[current_point_position]
	else:
		print("No Patrol Point")
		
	timer.wait_time = wait_time
	
	current_state = State.Idle
	can_walk = true
	current_state = State.Walk
	charainarea = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta : float):
	enemy_gravity(delta)
	match current_state:
		State.Idle:
			enemy_idle(delta)
		State.Walk:
			enemy_walk(delta)
		State.Attack:
			enemy_attack(delta)
		State.GetHit:
			enemy_get_hit(delta)

	move_and_slide() # Adjust the floor normal according to your game setup
	enemy_animations()

func enemy_get_hit(delta : float):
	pass

func enemy_gravity(delta : float):
	velocity.y += GRAVITY * delta

func enemy_idle(delta : float):
	if !can_walk:
		velocity.x = move_toward(velocity.x, 0, speed * delta)
		current_state = State.Idle

func enemy_attack(delta : float):
	if !can_walk:
		return

func enemy_walk(delta : float):
	if !can_walk:
		return

	if abs(position.x - current_point.x) > 0.5:
		velocity.x = direction.x * speed * delta
		current_state = State.Walk
	else:
		current_point_position += 1

		if current_point_position >= number_of_points:
			current_point_position = 0

		current_point = point_positions[current_point_position]

		if current_point.x > position.x:
			direction = Vector2.RIGHT
		else: 
			direction = Vector2.LEFT

		can_walk = false
		timer.start()

	animated_sprite_2d.flip_h = direction.x < 0

func enemy_animations():
	match current_state:
		State.Idle:
			if !can_walk:
				animated_sprite_2d.play("Idle")
		State.Walk:
			if can_walk:
				animated_sprite_2d.play("Walk")
		State.Attack:
			if charainarea && !can_walk:
				animated_sprite_2d.play("Attack")



func _on_timer_timeout():
	can_walk = true
	current_state = State.Walk
	charainarea = false

func _on_sword_hit(body : Node):
	# Called when the enemy is hit by the main character's sword
	if body.has_method("get_damage_amount"):
		body.deal_damage()  # Assuming the main character's sword has a "deal_damage" method
		health_amount -= body.get_damage_amount
		
		
func _on_hurtbox_area_entered(area : Area2D):
	print("Area Hurtbox entered NightBorne")
	animated_sprite_2d.play("Attack")
	current_state = State.Attack
	charainarea = true
	if area.get_parent().has_method("get_damage_amount"):
		var node = area.get_parent() as Node
		health_amount -= node.damage_amount
		print("Health amount", health_amount)

		if health_amount <= 0:
			var enemy_nightborne_death_effect_instance = enemy_nightborne_death_effect.instantiate() as Node2D
			enemy_nightborne_death_effect_instance.global_position = global_position
			get_parent().add_child(enemy_nightborne_death_effect_instance)
			queue_free()


func _on_hurtbox_area_exited(area):
	charainarea = false
	current_state = State.Walk
	
func enemy() -> void:
	pass
