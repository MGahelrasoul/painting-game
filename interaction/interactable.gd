extends Area3D

class_name Interactable

# Emitted when an Interactor starts looking at me.
signal focused(interactor: Interactor)
# Emitted when an Interactor stops looking at me.
signal unfocused(interactor: Interactor)
# Emitted when an interactor interacts with me.
signal interacted(interactor: Interactor)


func _on_area_exited(area: Area3D) -> void:
	pass # Replace with function body.
