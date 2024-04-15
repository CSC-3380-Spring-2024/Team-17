extends NinePatchRect

@onready var Fire = $VBoxContainer/Fire
@onready var Echo = $VBoxContainer/Echo
@onready var Shadow = $VBoxContainer/Shadow
@onready var Lightning = $VBoxContainer/Lightning
@onready var checkButton = $VBoxContainer/Check


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
		

func _on_fire_pressed():
	handleButtonPress("1")


func _on_echo_pressed():
	handleButtonPress("2")


func _on_shadow_pressed():
	handleButtonPress("3")


func _on_lightning_pressed():
	handleButtonPress("4")
	
func handleButtonPress(button):
	if button == "1":
		print("Wrong")
		Echo.set_pressed_no_signal(false)
		Shadow.set_pressed_no_signal(false)
		Lightning.set_pressed_no_signal(false)
		
	if button == "2":
		print("Correct")
		Fire.set_pressed_no_signal(false)
		Shadow.set_pressed_no_signal(false)
		Lightning.set_pressed_no_signal(false)
	if button == "3":
		print("Wrong")
		Fire.set_pressed_no_signal(false)
		Echo.set_pressed_no_signal(false)
		Lightning.set_pressed_no_signal(false)
	if button == "4":
		print("Wrong")
		Fire.set_pressed_no_signal(false)
		Echo.set_pressed_no_signal(false)
		Shadow.set_pressed_no_signal(false)


func _on_check_pressed():
	if handleButtonPress("2"):
		print("Correct answer")
	else:
		print("u r wrong")
