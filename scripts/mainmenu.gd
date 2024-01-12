extends Control

var mainhouse = preload("res://scenes/Main House/house.tscn")

@onready var menu = $menu
@onready var options = $options
@onready var audio = $Audio
@onready var graphics = $graphics


func _process(_delta):
	if Input.is_action_just_pressed("ui_cancel"):
		toggle()
	
func toggle():
	visible = !visible
	get_tree().paused = visible


func _on_new_game_pressed():
	toggle()
	get_tree().change_scene_to_packed(mainhouse)


func _on_options_pressed():
	showandhide(options , menu)

func _on_exit_pressed():
	get_tree().quit()


func _on_graphics_pressed():
	showandhide(graphics , options)


func _on_audio_pressed():
	showandhide(audio , options)



func _on_full_screen_toggled(button_pressed):
	if button_pressed == true:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
		




func _on_v_sync_toggled(button_pressed):
	if button_pressed == true:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED )
	else:
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ADAPTIVE )



func showandhide(first , second):
	first.visible = true
	second.visible = false


func _on_master_value_changed(value):
	volume(0 , value)
	
func volume(bus_index , value):
	AudioServer.set_bus_volume_db(bus_index , value)


func _on_music_value_changed(value):
	volume(1 , value)



func _on_sound_fx_value_changed(value):
	volume(2 , value)


func _on_backfrom_audio_pressed():
	showandhide( options , audio)


func _on_backfrom_graphics_pressed():
	showandhide(options , graphics)


func _on_backfrom_options_pressed():
	showandhide( menu , options)


func _on_load_game_pressed():
	get_tree().change_scene_to_file("res://scenes/load_game_menu.tscn")
