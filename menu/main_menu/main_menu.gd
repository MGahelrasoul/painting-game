extends Control

const NAVIGATION_LEVEL = preload("res://game.tscn")

@onready var main = $"../"

func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_packed(NAVIGATION_LEVEL)

func _on_options_button_pressed() -> void:
	main.settingsMenu()

func _on_quit_button_pressed() -> void:
	get_tree().quit()
