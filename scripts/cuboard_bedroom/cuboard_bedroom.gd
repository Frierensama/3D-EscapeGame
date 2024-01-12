extends Node3D

@onready var col: CollisionShape3D = $col

var opened = false
var keyreq = false
var beatreq = false
var pinreq = false

func _process(delta):
	if !opened:
		col.position.z = lerp(col.position.z ,0.0 , delta *5)
	else:
		col.position.z = lerp(col.position.z , -3.0, delta*5 )
func interact():
	opened = !opened

