extends CharacterBody2D

const GRAVITY : int = 1000
var speed : int = 10000
var jumpVert : int = -500
var jumpHoriz : int = 100
var maxhp : int = 1000
var charaDead : bool = false
var currenthp : int = 1000
var fallVel : int = 5
var direction : int = 0
var idle : bool = false
var walk : bool = false
var jump : bool = false
var fall : bool = false
var charaAttack : bool = false
var enemyAttack : bool = false
var attackCD : bool = false
var damageCD : bool = false
var coyote_frames : int = 10
var coyote : bool = false 
var last_floor : bool = false 
var damage : int = 100

@onready var dmgTimer : Timer = $damageTimer
@onready var coyoteTimer : Timer = $coyoteTimer
@onready var hpLabel : Label = $hpLabel
@onready var hpBar : ProgressBar = $hpBar

# Called when the node enters the scene tree for the first time.
func _ready():
	updatehpUI()
	coyoteTimer.wait_time = coyote_frames / 60.0
	dmgTimer.wait_time = 0.5


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta : float) -> void:
	CharaFall(delta)
	CharaIdle(delta)
	CharaWalk(delta)
	CharaJump(delta)
	CharaDamage(delta)
	CharaDeath(delta)
	
	move_and_slide()
	
	last_floor = is_on_floor()
	
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
	
	
	
func CharaFall(delta : float) -> void:
	if !is_on_floor():
		velocity.y += GRAVITY * delta
		fall = true
	else:
		velocity.y = 0
		
		
		
func CharaIdle(delta : float) -> void:
	if !attackCD && is_on_floor() && direction == 0:
		idle = true

func CharaWalk(delta : float) -> void:
	if Input.is_action_pressed("moveLeft") && !attackCD:
		if is_on_floor():
			walk = true
		direction = -1
		velocity.x = direction * speed * delta
	elif Input.is_action_pressed("moveRight") && !attackCD:
		if is_on_floor():
			walk = true
		direction = 1
		velocity.x = direction * speed * delta
	else:
		velocity.x = 0
		direction = 0

func CharaJump(delta : float) -> void:
	if !attackCD && Input.is_action_just_pressed("jump") and (is_on_floor() or coyote):
		jump = true
		velocity.y = jumpVert
		velocity.x = direction * jumpHoriz * delta
	
	if !is_on_floor() and last_floor and Input.is_action_just_pressed("jump"):
		coyote = true
		coyoteTimer.start()
		
		
func CharaDamage(delta : float) -> void:
	if damageCD == false && enemyAttack == true:
		dmgTimer.start()
		damageCD = true
		currenthp -= damage
	updatehpUI()
	
	
func CharaDeath(delta : float) -> void:
	if currenthp == 0:
		charaDead = true
		

func CharaRespawn(delta : float) -> void:
	pass


func _on_damage_timer_timeout() -> void:
	dmgTimer.stop()
	enemyAttack = false
	damageCD = false
