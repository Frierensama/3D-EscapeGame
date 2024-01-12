extends Node3D
var opened = false

@onready var door: StaticBody3D = $".."

var keyreq = false
var beatreq = false
var pinreq = false

func _ready():
	pass
func _process(delta):
	if opened:
		door.rotation.y = lerp_angle(door.rotation.y , deg_to_rad(90) , delta * 2 )
	else:
		door.rotation.y = lerp_angle(door.rotation.y , deg_to_rad(0) , delta * 2 )
func interact():
	opened = !opened
