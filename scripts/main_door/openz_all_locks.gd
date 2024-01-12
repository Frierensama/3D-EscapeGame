extends StaticBody3D

var keyreq = false
var beatreq = false
var pinreq = false

signal all_done(bool)
var yes = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func interact():
	all_done.emit(yes)
