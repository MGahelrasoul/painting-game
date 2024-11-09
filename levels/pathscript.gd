extends Node3D



func ready() -> void:
	$Path3D/PathFollow3D/NavigationNPC.moving = true
	$Path3D/PathFollow3D/NavigationNPC.move_speed = 1.0



func _physics_process(delta: float) -> void:
	const move_speed := 4.0
	$Path3D/PathFollow3D.progress += move_speed * delta
