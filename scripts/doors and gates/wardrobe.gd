extends Node3D
var opened = false
@onready var door_1_col: CollisionShape3D = $door1_col
@onready var door_2_col: CollisionShape3D = $door2_col

var keyreq = true
var keyname = "old_key"
var del 
func _ready():
	pass
func _process(delta):
	if opened:
		door_1_col.rotation.y = lerp_angle(door_1_col.rotation.y , rad_to_deg(90) , delta * 4 )
		door_2_col.rotation.y = lerp_angle(door_2_col.rotation.y , rad_to_deg(-90) , delta * 4 )
func interact():
	if !opened:
		opened = !opened
