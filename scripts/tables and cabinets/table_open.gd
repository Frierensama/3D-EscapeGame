extends Node3D

@onready var col: CollisionShape3D = $col

var opened = false
var keyreq = false
var beatreq = false
var pinreq = false

func _process(delta):
	if !opened:
		col.position.x = lerp(col.position.x ,0.0 , delta * 5)
	else:
		col.position.x = lerp(col.position.x , -100.0, delta * 5)
func interact():
	opened = !opened
