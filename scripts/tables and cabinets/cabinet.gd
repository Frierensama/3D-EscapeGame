extends Node3D
var opened = false

@onready var door_1_col: CollisionShape3D = $door_1_col
@onready var door_2_col: CollisionShape3D = $door_2_col

var keyreq = false
var beatreq = false
var pinreq = false
func _ready():
	pass
func _process(delta):
	if opened:
		door_1_col.rotation.y = lerp_angle(door_1_col.rotation.y , deg_to_rad(180) , delta * 4 )
		door_2_col.rotation.y = lerp_angle(door_2_col.rotation.y , deg_to_rad(0) , delta * 4 )
	else:
		door_1_col.rotation.y = lerp_angle(door_1_col.rotation.y , deg_to_rad(90) , delta * 4 )
		door_2_col.rotation.y = lerp_angle(door_2_col.rotation.y , deg_to_rad(90) , delta * 4 )
func interact():
		opened = !opened
