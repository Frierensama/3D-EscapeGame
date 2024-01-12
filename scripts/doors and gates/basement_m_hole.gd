extends StaticBody3D
@onready var col: CollisionShape3D = $CollisionShape3D
var keyreq =false
var opened=false
var beatreq = true
var beatname = "hammer"
func _process(delta):
	if opened:
		#col.position.y = lerp(col.position.y , col.position.y + 1.2917 , delta * 2)
		col.position.y = lerp(col.position.y , 3.413 , delta * 6 )
		col.position.x = lerp(col.position.x , -11.08 , delta * 8 )
		col.position.z = lerp(col.position.z , -6.453 , delta * 4 )
		
		col.rotation.x = lerp_angle(col.rotation.x , deg_to_rad(90) , delta * 10)
		
func interact():
	if !opened:
		opened = !opened
		col.disabled = true
