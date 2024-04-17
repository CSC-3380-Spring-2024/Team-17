extends CharacterBody2D

const GRAVITY : int = 1000
@export var speed : int = 2000
@export var jumpVert : int = -400
@export var jumpHoriz : int = 100
@export var dash : int = 200
@export var roll : int = 300
@export var maxhp : int = 1000
var charaDead : bool = false
var currenthp : int = 1000
var fallVel : int = 5
var direction : int = 0
var charaAttack : bool = false
var enemyAttack : bool = false
var coyote_frames : int = 6
var coyote : bool = false 
var last_floor : bool = false 
var damage : int = 100

@onready var anim : AnimatedSprite2D = $charaOneanim
@onready var idlecollS : CollisionShape2D = $idlecollS
@onready var rollcollS : CollisionShape2D = $rollcollS 
@onready var hurtanim : AnimationPlayer = $hurtanim
@onready var coyoteTimer : Timer = $CoyoteTimer
@onready var hpLabel : Label = $hpLabel
@onready var hpBar : ProgressBar = $hpBar
@onready var atkTimer : Timer = $attackTimer


func _ready():
	updatehpUI()
	coyoteTimer.wait_time = coyote_frames / 60.0
	
	
	
	
func _physics_process(delta : float):
	CharaFall(delta)
	CharaIdle(delta)
	CharaWalk(delta)
	CharaJump(delta)
	CharaSlide(delta)
	CharaSword(delta)
	CharaBow(delta)
	CharaDamage(delta)
	CharaDeath(delta)
	
	move_and_slide()
	
	last_floor = is_on_floor()
	
	
	
func CharaFall(delta : float) -> void:
	if !is_on_floor():
		velocity.y += GRAVITY * delta
		anim.play("fall")
	else:
		velocity.y = 0




func CharaIdle(delta : float) -> void:
	if is_on_floor() && direction == 0:
		anim.play("idle")



	
func CharaWalk(delta : float) -> void:
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




func CharaJump(delta : float) -> void:
	if Input.is_action_just_pressed("jump") and (is_on_floor() or coyote):
		velocity.y = jumpVert
		anim.play("jump")
		velocity.x = direction * jumpHoriz * delta
	
	if !is_on_floor() and last_floor and Input.is_action_just_pressed("jump"):
		coyote = true
		coyoteTimer.start()
		
		
		
		
func _on_coyote_timer_timeout() -> void:
	coyote = false
	
	
	
	
func CharaSlide(delta : float) -> void:
	if Input.is_action_just_pressed("dash"):
		velocity.x = direction * dash
		anim.play("dash")
	
	
	
	
func CharaSword(delta : float) -> void:
	if Input.is_action_just_pressed("sword") && is_on_floor():
		charaAttack = true
		atkTimer.start()
		atkTimer.wait_time = 0.5
		anim.play("sword")
	
func CharaBow(delta : float) -> void:
	if Input.is_action_just_pressed("magic") && is_on_floor():
		charaAttack = true
		atkTimer.start()
		atkTimer.wait_time = 0.5
		anim.play("magic")


func _on_attack_timer_timeout():
	atkTimer.stop()
	charaAttack = false

func _on_hurtbox_body_entered(body) -> void:
	if body.has_method("enemy"):
		enemyAttack = true
		anim.play("hurt")
		hurtanim.play("hurt")
	 


func _on_hurtbox_body_exited(body) -> void:
	if body.has_method("enemy"):
		enemyAttack = false



func updatehpUI() -> void:
	hpLabelSet()
	hpBarSet()
	if currenthp <= 0:
		currenthp = 0


func hpLabelSet() -> void:
	hpLabel.text = "Health: %s" % currenthp


func hpBarSet() -> void:
	hpBar.max_value = maxhp
	hpBar.value = currenthp
	
	

func CharaDamage(delta : float) -> void:
	if Input.is_action_just_pressed("sword") || enemyAttack == true:
		currenthp -= damage
	updatehpUI()

func CharaDeath(delta : float) -> void:
	if maxhp == 0:
		charaDead = true
		anim.play("death")

func CharaRespawn(delta : float) -> void:
	pass
