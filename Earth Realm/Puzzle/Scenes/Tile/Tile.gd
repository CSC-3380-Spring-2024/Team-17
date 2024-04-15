extends TextureButton

var number
signal tile_pressed
signal slide_completed


# Updates the number of the tile
func set_text(new_number):
	number = new_number
	$Number/Label.text = str(number)



# Slide the tile to a new postion
func slide_to(new_position, duration): 
	var tween = create_tween()
	tween.interpolate_property(self, "rect_position", null, new_position, duration,
	Tween.TRANS_QUART, Tween.EASE_OUT)
	tween.start()

# Hide / Show the number to a new position
func set_number_visible(state):
	$Number.visible = state
	
	
# Tile is pressed
func _on_Tile_pressed():
	emit_signal("tile_pressed", number)
	

# Tile has finished sliding
func _on_Tween_tween_completed(_object, _key):
	emit_signal("slide_completed", number)


