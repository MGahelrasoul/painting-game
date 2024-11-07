extends Camera3D

@export_group("Camera Settings")
@export var zoom_speed = 1
@export var max_zoom = 12
@export var min_zoom = -1

var zoom := 10.0

@onready var _camera: Camera3D = %Camera3D

func _unhandled_input(event: InputEvent) -> void:
# Handle camera zoom
	if event.is_action_pressed("cam_zoom_in"):
		if zoom == 1:
			zoom = -1
		else:
			zoom -= zoom_speed
	if event.is_action_pressed("cam_zoom_out"):
		if zoom == -1:
			zoom = 1
		else:
			zoom += zoom_speed
	zoom = clamp(zoom, min_zoom, max_zoom)
	
# Handle physics
func _physics_process(delta: float) -> void:
	_camera.position.z = zoom
