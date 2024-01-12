class_name pickable
extends RigidBody3D
var picked = false
var dropped = false
@onready var col: CollisionShape3D = $col

func _process(delta):
	if picked == true:
		gravity_scale = 0.0
		col.disabled = true
	else:
		gravity_scale = 1.0
	if dropped == true:
		dropped = false
		col.disabled = false

func _on_player_handpos(handpos) -> void:
	if picked == true:
		global_transform = handpos
	

