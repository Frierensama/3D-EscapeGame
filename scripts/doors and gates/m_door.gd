extends Node3D

var opened = false

@onready var col: CollisionShape3D = $col

var keyreq = false
var beatreq = false
var pinreq = false
func _ready():
	pass
func _process(delta):
	if opened:
		col.rotation.x = lerp_angle(col.rotation.x , deg_to_rad(75) , delta * 4 )
	else:
		col.rotation.x = lerp_angle(col.rotation.x , deg_to_rad(0) , delta * 4 )
func interact():
	opened = !opened
