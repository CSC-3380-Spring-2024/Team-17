extends NinePatchRect

@onready var Fire : Button = $VBoxContainer/Fire
@onready var Echo : Button = $VBoxContainer/Echo
@onready var Shadow : Button = $VBoxContainer/Shadow
@onready var Lightning : Button = $VBoxContainer/Lightning
@onready var checkButton : Button = $VBoxContainer/Check

var tracked : bool = false
var correct : bool = false
var self_opened : bool = false

func _input(event : InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		toggle_menu()
		
func toggle_menu() -> void: # by pressing enter the paper disappers
	self_opened = !self_opened
	if self_opened:
		self.visible = true
	else:
		self.visible = false
		

func _on_fire_pressed() -> void:
	handleButtonPress("1")
	


func _on_echo_pressed() -> void:
	handleButtonPress("2")


func _on_shadow_pressed() -> void:
	handleButtonPress("3")


func _on_lightning_pressed() -> void:
	handleButtonPress("4")
	
func handleButtonPress(button : String) -> void:
	if button == "1":
		print("Wrong")
		Echo.set_pressed_no_signal(false)
		Shadow.set_pressed_no_signal(false)
		Lightning.set_pressed_no_signal(false)
		tracked =  true
		
		
	if button == "2":
		print("Correct")
		Fire.set_pressed_no_signal(false)
		Shadow.set_pressed_no_signal(false)
		Lightning.set_pressed_no_signal(false)
		correct = true
		
		
	if button == "3":
		print("Wrong")
		Fire.set_pressed_no_signal(false)
		Echo.set_pressed_no_signal(false)
		Lightning.set_pressed_no_signal(false)
		tracked =  true
		
		
	if button == "4":
		print("Wrong")
		Fire.set_pressed_no_signal(false)
		Echo.set_pressed_no_signal(false)
		Shadow.set_pressed_no_signal(false)
		tracked =  true


func _on_check_pressed() -> void:
	if tracked == true:
		get_tree().change_scene_to_file("res://Earth Realm/level 1/scenes/Riddle_Wrong.tscn")
	if correct == true:
		get_tree().change_scene_to_file("res://Earth Realm/level 2/scenes/Level2.tscn")
