extends CollisionShape2D

var damage_amount : int = 20
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta : float) -> void:
	pass

func hitboxHeavy() -> void:
	pass

func get_damage_amount() -> int:
	return damage_amount
	
