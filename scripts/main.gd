extends Node3D
@onready var pausemenu = $pausemenu
var pause = false

func _ready():
	Engine.time_scale = 1
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		pmenu()
	
func pmenu():
	if pause:
		pausemenu.hide()
		Engine.time_scale = 1
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	else:
		pausemenu.show()
		Engine.time_scale = 0
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
	pause = !pause


func _on_robert_clown_kill(death):
	if death == true:
		get_tree().change_scene_to_file("res://scenes/death_scene/death_scene.tscn")
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
