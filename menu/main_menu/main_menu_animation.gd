extends NavigationRegion3D

@onready var camera_pivot: Node3D = $CameraPivot
@onready var settings: Control = $Settings

var rotation_speed = 8
var settings_open = false

func _process(delta):
	camera_pivot.rotation_degrees.y += delta * rotation_speed
	if Input.is_action_just_pressed("pause"):
		pass

func settingsMenu():
	if settings_open:
		settings.hide()
	else:
		settings.show()
	settings_open = !settings_open
