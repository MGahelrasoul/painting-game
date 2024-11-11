extends Control

@onready var main = $"../../"
#const NAVIGATION_LEVEL = preload("res://game.tscn")

func _on_resume_button_pressed() -> void:
	main.pauseMenu()

func _on_options_button_pressed() -> void:
	main.settingsMenu()

func _on_quit_button_pressed() -> void:
	get_tree().quit()
