extends Area2D
var health_amount : int = 300
@onready var animation : AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	animation.play("idle")


func _on_body_entered(body : CharacterBody2D):
	if body.name == "charaTwo" && health_amount <= 0:
		get_tree().change_scene_to_file("res://GUI//scenes//End.tscn")
	


func _on_area_shape_entered(area_rid, area : Area2D, area_shape_index, local_shape_index):
	if area.get_parent().has_method("get_damage_amount"):
		var node : Node = area.get_parent() as Node
		health_amount -= node.damage_amount
		print("Health amount", health_amount)
