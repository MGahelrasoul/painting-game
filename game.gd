extends NavigationRegion3D

@onready var pause_menu: Control = $UI/PauseMenu
@onready var settings: Control = $UI/Settings

var paused = false
var settings_open = false

func _process(delta):
	if Input.is_action_just_pressed("pause"):
		pauseMenu()
		
func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0
	paused = !paused
func settingsMenu():
	if settings_open:
		settings.hide()
	else:
		settings.show()
	settings_open = !settings_open
