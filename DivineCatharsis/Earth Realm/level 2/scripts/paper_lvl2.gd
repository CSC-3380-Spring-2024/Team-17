extends NinePatchRect

@onready var Anguish : Button = $VBoxContainer/Anguish
@onready var Flame : Button = $VBoxContainer/Flame
@onready var Pain : Button = $VBoxContainer/Pain
@onready var Shadow : Button = $VBoxContainer/Shadow
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
		

func _on_anguish_pressed() -> void:
	handleButtonPress("1")



func _on_flame_pressed() -> void:
	handleButtonPress("2")


func _on_pain_pressed() -> void:
	handleButtonPress("3")
	
	
func _on_shadow_pressed() -> void:
	handleButtonPress("4")

	
func handleButtonPress(button : String) -> void:
	if button == "1":
		print("Wrong")
		Flame.set_pressed_no_signal(false)
		Pain.set_pressed_no_signal(false)
		Shadow.set_pressed_no_signal(false)
		tracked =  true
		
		
	if button == "2":
		print("Wrong")
		Anguish.set_pressed_no_signal(false)
		Pain.set_pressed_no_signal(false)
		Shadow.set_pressed_no_signal(false)
		tracked =  true
		
		
	if button == "3":
		print("Correct")
		Anguish.set_pressed_no_signal(false)
		Flame.set_pressed_no_signal(false)
		Shadow.set_pressed_no_signal(false)
		correct = true
		
		
	if button == "4":
		print("Wrong")
		Anguish.set_pressed_no_signal(false)
		Flame.set_pressed_no_signal(false)
		Pain.set_pressed_no_signal(false)
		tracked =  true



func _on_check_pressed() -> void:
	if tracked == true:
		get_tree().change_scene_to_file("res://Earth Realm/level 2/scenes/riddle_earth_lvl2_wrong.tscn")
	if correct == true:
		get_tree().change_scene_to_file("res://Hellish Realm/scenes/base_level.tscn") 
		pass

