extends CharacterBody3D

@export_group("Camera")
@export_range(0.0, 1.0) var mouse_sensitivity := 0.25
@export var invert_x_axis := 1
@export var invert_y_axis := 1

@export_group("Movement")
@export var move_speed := 6.0
@export var sprint_speed := 12.0
@export var acceleration := 50.0
@export var sprint_acceleration := 100.0
@export var rotation_speed := 12.0
@export var jump_impulse := 12.0

var _camera_input_direction := Vector2.ZERO
var _last_movement_direction := Vector3.BACK
var _gravity := -30.0

@onready var _camera_pivot: Node3D = %CameraPivot
@onready var _camera: Camera3D = %Camera3D
@onready var _skin: SophiaSkin = %SophiaSkin

# Handle game window focus
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

# Handle camera input
func _unhandled_input(event: InputEvent) -> void:
	var is_camera_motion := (
		event is InputEventMouseMotion and 
		Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
	)
	if is_camera_motion:
		_camera_input_direction.x = invert_x_axis * event.screen_relative.x * mouse_sensitivity
		_camera_input_direction.y = invert_y_axis * event.screen_relative.y * mouse_sensitivity

# Handle physics
func _physics_process(delta: float) -> void:
	# Handle camera rotation
	_camera_pivot.rotation.x += _camera_input_direction.y * delta
	_camera_pivot.rotation.x = clamp(_camera_pivot.rotation.x, -PI / 3.0, PI / 3.0)
	_camera_pivot.rotation.y -= _camera_input_direction.x * delta
	_camera_input_direction = Vector2.ZERO

	# Handle movement input
	var raw_input := Input.get_vector("move_left","move_right","move_up","move_down")
	var forward := _camera.global_transform.basis.z
	var right := _camera.global_transform.basis.x

	var move_direction := forward * raw_input.y + right * raw_input.x
	move_direction.y = 0.0
	move_direction = move_direction.normalized()
	
	# Handle velocity and sprint speed
	var target_speed = move_speed
	var target_acceleration = acceleration
	
	if Input.is_action_pressed("sprint"):
		target_speed  = sprint_speed
		target_acceleration = sprint_acceleration
		
	var vertical_velocity := velocity.y
	velocity.y = 0.0
	
	var horizontal_velocity = velocity
	horizontal_velocity.y = 0.0
	
	if move_direction != Vector3.ZERO:
		velocity = velocity.move_toward(move_direction * target_speed, target_acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector3.ZERO, acceleration * delta)
		
	# Handle gravity
	velocity.y = vertical_velocity + _gravity * delta
	
	# Handle jump
	var is_starting_jump := Input.is_action_just_pressed("jump") and is_on_floor()
	if is_starting_jump:
		velocity.y += jump_impulse
	
	move_and_slide()
	
# Handle animations
	if is_starting_jump:
		_skin.jump()
	elif not is_on_floor() and velocity.y < 0:
		_skin.fall()
	elif is_on_floor():
		var ground_speed := horizontal_velocity.length()
		if ground_speed > 0.0:
			_skin.move()
		else:
			_skin.idle()

	if move_direction.length() > 0.2:
		_last_movement_direction = move_direction
	var target_angle := Vector3.BACK.signed_angle_to(_last_movement_direction, Vector3.UP)
	_skin.global_rotation.y = lerp_angle(_skin.rotation.y, target_angle, rotation_speed * delta)
	
