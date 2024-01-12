extends StaticBody3D

var keyreq =false
var opened=false
var beatreq = true
var beatname = "hammer"
signal beaten(bool)
var yes = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if opened:
		hide()

func interact():
	if !opened:
		opened = !opened
	beaten.emit(yes)
	
