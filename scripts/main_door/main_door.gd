extends StaticBody3D

var monster_key = false
var wooden_hammer = false
var final = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if monster_key == true && wooden_hammer == true && final == true:
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")


func _on_need_monster_key_monster_done(bool):
	monster_key = true


func _on_wood_hammer_beaten(bool):
	wooden_hammer = true


func _on_openz_all_locks_all_done(bool):
	final = true
