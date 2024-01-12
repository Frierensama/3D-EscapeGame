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
		col.rotation.y = lerp_angle(col.rotation.y , deg_to_rad(-90) , delta * 4 )
	else:
		col.rotation.y = lerp_angle(col.rotation.y , deg_to_rad(0) , delta * 4 )
func interact():
	opened = !opened
