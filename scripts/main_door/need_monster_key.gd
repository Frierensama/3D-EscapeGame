extends StaticBody3D
var opened = false
@onready var grid_gate: StaticBody3D = $"."
var yes = true
signal monster_done(bool)
var keyreq = true
var keyname = "monster_key"
func _process(delta):
	pass
func interact():
	monster_done.emit(true)
