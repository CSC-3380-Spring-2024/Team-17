extends CharacterBody2D

const GRAVITY : int = 1000
@export var speed : int = 12000
@export var jumpVert : int = -500
@export var jumpHoriz : int = 100
@export var maxhp : int = 1000
var charaDead : bool = false
var currenthp : int = 1000
var fallVel : int = 5
var direction : int = 0
var charaAttack : bool = false
var enemyAttack : bool = false
var attackCD : bool = false
var damageCD : bool = false
var coyote_frames : int = 6
var coyote : bool = false 
var last_floor : bool = false 
var damage : int = 100

@onready var anim : AnimatedSprite2D = $charaTwoanim
@onready var jumpTimer : Timer = $jumpTimer
@onready var idlecollS : CollisionShape2D = $idlecollS
@onready var lightBox : CollisionShape2D = $charaBox/hitBoxBowLight
@onready var heavyBox : CollisionShape2D = $charaBox/hitBoxBowHeavy
@onready var hurtanim : AnimationPlayer = $hurtanim
@onready var coyoteTimer : Timer = $coyoteTimer
@onready var hpLabel : Label = $hpLabel
@onready var hpBar : ProgressBar = $hpBar
@onready var atkTimer : Timer = $attackTimer
@onready var dmgTimer : Timer = $damageTimer


func _ready() -> void:
	updatehpUI()
	coyoteTimer.wait_time = coyote_frames / 60.0
	atkTimer.wait_time = 0.5
	dmgTimer.wait_time = 0.5
	jumpTimer.wait_time = 0.4
	
	
	
	
func _physics_process(delta : float) -> void:
	CharaFall(delta)
	CharaIdle(delta)
	CharaWalk(delta)
	CharaJump(delta)
	CharaBowLight(delta)
	CharaBowHeavy(delta)
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
	if attackCD == false && is_on_floor() && direction == 0:
		anim.play("idle")



	
func CharaWalk(delta : float) -> void:
	if Input.is_action_pressed("moveLeft") && !attackCD:
		if is_on_floor():
			anim.play("walk")
		direction = -1
		velocity.x = direction * speed * delta
	elif Input.is_action_pressed("moveRight") && !attackCD:
		if is_on_floor():
			anim.play("walk")
		direction = 1
		velocity.x = direction * speed * delta
	else:
		velocity.x = 0
		direction = 0
		
	if direction != 0:
		anim.flip_h = false if direction > 0 else true




func CharaJump(delta : float) -> void:
	if !attackCD && Input.is_action_just_pressed("jump") and (is_on_floor() or coyote):
		velocity.y = jumpVert
		anim.play("jump")
		velocity.x = direction * jumpHoriz * delta
	
	if !is_on_floor() and last_floor and Input.is_action_just_pressed("jump"):
		coyote = true
		coyoteTimer.start()
		
		
		
		
func _on_coyote_timer_timeout() -> void:
	coyote = false
	
	
	
	
	
	
	
	
func CharaBowLight(delta : float) -> void:
	if !attackCD && Input.is_action_just_pressed("bowLight") && is_on_floor() && direction == 0:
		atkTimer.start()
		charaAttack = true
		if charaAttack == true:
			lightBox.set_deferred("Disabled", false)
		attackCD = true
		anim.play("bowLight")
	
func CharaBowHeavy(delta : float) -> void:
	if !attackCD && Input.is_action_just_pressed("bowHeavy") && is_on_floor() && direction == 0:
		atkTimer.start()
		charaAttack = true
		if charaAttack == true:
			heavyBox.set_deferred("Disabled", false)
		attackCD = true
		anim.play("bowHeavy")


func _on_attack_timer_timeout() -> void:
	atkTimer.stop()
	charaAttack = false
	attackCD = false

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
	hpLabel.text = "HP: %s" % currenthp


func hpBarSet() -> void:
	hpBar.max_value = maxhp
	hpBar.value = currenthp
	
	

func CharaDamage(delta : float) -> void:
	if damageCD == false && enemyAttack == true:
		dmgTimer.start()
		damageCD = true
		currenthp -= damage
	updatehpUI()

func _on_damage_timer_timeout() -> void:
	dmgTimer.stop()
	enemyAttack = false
	damageCD = false

func CharaDeath(delta : float) -> void:
	if currenthp == 0:
		charaDead = true
		anim.play("death")

func CharaRespawn(delta : float) -> void:
	pass
