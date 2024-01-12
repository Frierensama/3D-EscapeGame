extends CharacterBody3D

var speed
const WALK_SPEED = 4.0
const SPRINT_SPEED = 8.0
const JUMP_VELOCITY = 4.8
const SENSITIVITY = 0.004
const CROUCH_SPEED = 2.5
const CROUCH_DEPTH = 0.8

#bob variables
const BOB_FREQ = 2.4
const BOB_AMP = 0.08
var t_bob = 0.0

#fov variables
const BASE_FOV = 80.0
const FOV_CHANGE = 1.1



#buttons 
@onready var rc_bt = $head/Camera3D/red_circle_bt
@onready var gt_bt = $head/Camera3D/green_tri_bt
@onready var ws_bt = $head/Camera3D/white_square_bt
@onready var bx_bt = $head/Camera3D/bx_bt

#collision shapes
@onready var standing_colide_shape: CollisionShape3D = $"standing colide_shape"
@onready var crouch_colide_shape: CollisionShape3D = $crouch_colide_shape
var crouched = false

#raycasts
@onready var crouch_raycast: RayCast3D = $crouch_raycast


#states
var state = 0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = 9.8
@onready var head: Node3D = $head
@onready var camera = $head/Camera3D


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	rc_bt.visible = false
	ws_bt.visible = false
	bx_bt.visible = false
	
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-60), deg_to_rad(60))

#############################################################################
# pickme
@onready var hand: Node3D = $head/hand
@onready var reach: RayCast3D = $head/Camera3D/reach
signal handpos(handpos:Transform3D)
var picked = false
var detected = null
#for doors
@onready var interact: RayCast3D = $head/Camera3D/interact
@onready var label: Label = $head/Camera3D/Label
@onready var for_ship = $head/Camera3D/for_ship

@onready var label_2: Label = $head/Camera3D/Label2
@onready var timer: Timer = $head/Camera3D/Timer



func _process(delta):
	if Input.is_action_just_pressed("F") or ws_bt.button_pressed == true:
		if reach.is_colliding() and reach.get_collider() is pickable and picked !=true:
			picked=true
			detected=reach.get_collider()
			reach.get_collider().picked = true
		if reach.is_colliding() and reach.get_collider() is pickable and picked ==true:
			detected.picked = false
			detected.dropped = true
			picked=true
			detected=reach.get_collider()
			reach.get_collider().picked = true
	if picked == true:
		handpos.emit(hand.global_transform)
	if picked == true:
		bx_bt.visible = true
		if Input.is_action_just_pressed("G") or bx_bt.button_pressed == true:
			detected.picked = false
			detected.dropped = true
			picked = false
			detected = null
	else:
		bx_bt.visible = false
	#for doors
	if interact.is_colliding() and interact.get_collider().collision_layer != 1 and interact.get_collider().collision_layer !=10 :
		label.text = "[E] to INTERACT"
		if Input.is_action_just_pressed("E") or rc_bt.button_pressed == true:
			if interact.get_collider().keyreq == true :
				if detected !=null and detected.get_name()== interact.get_collider().keyname:
					timer.start()
					hold_player_circle_loading()
				else:
					label_2.text="NEED a KEY to OPEN"
			elif interact.get_collider().beatreq == true:
				if detected !=null and detected.get_name()== interact.get_collider().beatname:
					interact.get_collider().interact()
					interact.get_collider().collision_layer=1
				else:
					label_2.text="NEED a HAMMER to OPEN"
			elif interact.get_collider().pinreq == true:
				if detected !=null and detected.get_name()== "lockpin":
					timer.start()
					hold_player_circle_loading()
				else:
					label_2.text ="NEED a TOOL to OPEN"
			else:
				interact.get_collider().interact()
	else:
		label_2.text=""
	if for_ship.is_colliding()  or rc_bt.button_pressed == true :
		label.text = "[E] to INTERACT"
		rc_bt.visible = true
		if Input.is_action_just_pressed("E") and detected != null:
			if detected.get_name() == "need_gear":
				print("exit")
			else:
				label.text = "need ship key"
		else:
			label.text = ""
	else:
		rc_bt.visible = false
	if reach.is_colliding() and reach.get_collider() is pickable:
		ws_bt.visible = true
		rc_bt.visible = false
		label.text="[F] to PICK UP"
	elif interact.is_colliding() and interact.get_collider().collision_layer != 1  and interact.get_collider().collision_layer !=10  :
		label.text = "[E] to INTERACT"
		rc_bt.visible = true
		ws_bt.visible = false
	else:
		label.text=""
		rc_bt.visible = false
		ws_bt.visible = false
#############################################################################

func _physics_process(delta):
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	
	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor() and !crouched :
		velocity.y = JUMP_VELOCITY
		state = 3
	
	# Handle Sprint.
	if Input.is_action_pressed("sprint"):
		speed = SPRINT_SPEED
		state = 2
	else:
		speed = WALK_SPEED
		state = 1
	
	#Handle Crouch.
	if Input.is_action_pressed("crouch") or gt_bt.button_pressed == true:
		state = 4
		standing_colide_shape.disabled = true
		crouch_colide_shape.disabled = false
		head.position.y = CROUCH_DEPTH
		speed = CROUCH_SPEED
		crouched = true
		
	elif !crouch_raycast.is_colliding() :
		state = 1
		head.position.y = 1.8
		standing_colide_shape.disabled = false
		crouch_colide_shape.disabled = true
		crouched = false
		
	elif crouch_raycast.is_colliding() :
		speed = CROUCH_SPEED
		state = 4
		
	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("left", "right", "up", "down")
	var direction = (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			state = 0
			velocity.x = lerp(velocity.x, direction.x * speed, delta * 7.0)
			velocity.z = lerp(velocity.z, direction.z * speed, delta * 7.0)
	else:
		state = 3
		velocity.x = lerp(velocity.x, direction.x * speed, delta * 3.0)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * 3.0)
	
	# Head bob
	t_bob += delta * velocity.length() * float(is_on_floor())
	camera.transform.origin = _headbob(t_bob)
	
	# FOV
	var velocity_clamped = clamp(velocity.length(), 0.5, SPRINT_SPEED * 2)
	var target_fov = BASE_FOV + FOV_CHANGE * velocity_clamped
	camera.fov = lerp(camera.fov, target_fov, delta * 8.0)
	
	move_and_slide()
	


#HeadBOB
func _headbob(time) -> Vector3:
	var pos = Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.x = cos(time * BOB_FREQ / 2) * BOB_AMP
	return pos
	

func _on_timer_timeout() -> void:
	set_physics_process(true)
	set_process_input(true)
	set_process_unhandled_input(true)
	interact.get_collider().interact()
	interact.get_collider().collision_layer=1
	
func hold_player_circle_loading():
	label_2.text ="Unlocking~ please wait..."
	set_physics_process(false)
	set_process_input(false)
	set_process_unhandled_input(false)
