extends CharacterBody2D

const GRAVITY : int = 1000
@export var speed : int = 2000
@export var jumpVert : int = -500
@export var jumpHoriz : int = 100
@export var dash : int = 200
@export var roll : int = 300
var fallVel : int = 5
var direction : int = 0

@onready var anim : AnimatedSprite2D = $charaOneanim
@onready var idlecollS : CollisionShape2D = $idlecollS
@onready var rollcollS : CollisionShape2D = $rollcollS 

func _ready():
	pass
	
	
	
	
func _physics_process(delta : float):
	CharaFall(delta)
	CharaIdle(delta)
	CharaWalk(delta)
	CharaJump(delta)
	
	move_and_slide()	
	
	
	
func CharaFall(delta : float):
	if !is_on_floor():
		velocity.y += GRAVITY * delta
		anim.play("fall")
	else:
		velocity.y = 0




func CharaIdle(delta : float):
	if is_on_floor() && direction == 0:
		anim.play("idle")



	
func CharaWalk(delta : float):
	if Input.is_action_pressed("moveLeft"):
		anim.play("walk")
		direction = -1
		velocity.x = direction * speed * delta
	elif Input.is_action_pressed("moveRight"):
		anim.play("walk")
		direction = 1
		velocity.x = direction * speed * delta
	else:
		velocity.x = 0
		direction = 0
		
	if direction != 0:
		anim.flip_h = false if direction > 0 else true




func CharaJump(delta : float):
	if Input.is_action_just_pressed("jump"):
		velocity.y = jumpVert
		anim.play("jump")
		
	if !is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.x = direction * jumpHoriz * delta
	
	
func CharaDash(delta : float):
	if Input.is_action_just_pressed("dash"):
		velocity.x = direction * dash
		anim.play("dash")
		
func CharaRoll(delta : float):
	if Input.is_action_just_pressed("dash"):
		velocity.x = direction * roll
		anim.play("dash")
	
func CharaSword():
	pass
	
func CharaMagic():
	pass
