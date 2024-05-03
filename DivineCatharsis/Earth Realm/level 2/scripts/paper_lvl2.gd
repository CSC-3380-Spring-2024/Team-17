extends NinePatchRect

@onready var Anguish = $VBoxContainer/Anguish
@onready var Flame = $VBoxContainer/Flame
@onready var Pain = $VBoxContainer/Pain
@onready var Shadow = $VBoxContainer/Shadow
@onready var checkButton = $VBoxContainer/Check

var tracked = false
var correct = false
var self_opened = false

func _input(event):
	if event.is_action_pressed("ui_accept"):
		toggle_menu()
		
func toggle_menu(): # by pressing enter the paper disappers
	self_opened = !self_opened
	if self_opened:
		self.visible = true
	else:
		self.visible = false
		

func _on_anguish_pressed():
	handleButtonPress("1")



func _on_flame_pressed():
	handleButtonPress("2")


func _on_pain_pressed():
	handleButtonPress("3")
	
	
func _on_shadow_pressed():
	handleButtonPress("4")

	
func handleButtonPress(button):
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



func _on_check_pressed():
	if tracked == true:
		get_tree().change_scene_to_file("res://Earth Realm/level 2/scenes/riddle_earth_lvl2_wrong.tscn")
	if correct == true:
		get_tree().change_scene_to_file("res://Hellish Realm/scenes/base_level.tscn") 
		pass

