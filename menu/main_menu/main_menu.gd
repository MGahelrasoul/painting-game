extends Control

const NAVIGATION_LEVEL = preload("res://game.tscn")

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_packed(NAVIGATION_LEVEL)

func _on_options_button_pressed() -> void:
	pass # Replace with function body.

func _on_quit_button_pressed() -> void:
	get_tree().quit()
