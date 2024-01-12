extends StaticBody3D
var opened = false

@onready var door = $".."

var keyreq = true
var keyname = "gf_base_door_key"
func _process(delta):
	if opened:
		door.rotation.y = lerp_angle(door.rotation.y , rad_to_deg(-90.0) , delta * 2)
func interact():
	if !opened:
		opened = !opened
