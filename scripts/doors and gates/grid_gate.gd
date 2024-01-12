extends StaticBody3D
var opened = false
@onready var grid_gate: StaticBody3D = $"."

var keyreq = true
var keyname = "grid_key"
func _process(delta):
	if opened:
		grid_gate.rotation.y = lerp_angle(grid_gate.rotation.y , rad_to_deg(0.0) , delta * 2)
func interact():
	if !opened:
		opened = !opened
