extends CollisionShape2D

var damage_amount = 10
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta : float) -> void:
	pass

func hitboxLigt() -> void:
	pass

func get_damage_amount() -> int:
	return damage_amount
