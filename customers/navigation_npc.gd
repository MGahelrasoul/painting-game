extends CharacterBody3D

var _step_time := 0.0

@onready var navigation_agent_3d: NavigationAgent3D = $NavigationAgent3D
@onready var _player_walk: AudioStreamPlayer3D = $PlayerAudio/PlayerWalk3D
@onready var navigation_npc: CharacterBody3D = $"."

#func _unhandled_input(event: InputEvent) -> void:
	#if event.is_action_pressed("ui_accept"):
		#var random_position := Vector3.ZERO
		#random_position.x = randf_range(-5.0, 5.0)
		#random_position.z = randf_range(-5.0, 5.0)
		#navigation_agent_3d.set_target_position(random_position)

func _player_step_audio():
	_player_walk.pitch_scale = randf_range(.8, 1.2)
	_player_walk.play()

func _physics_process(delta: float) -> void:
	var destination = navigation_agent_3d.get_next_path_position()
	var local_destination = destination - global_position
	var direction = local_destination.normalized()
	
	if navigation_npc.velocity.length() > 0.0:
		_step_time += delta

	if _step_time > 0.3:
		_step_time = 0
		_player_step_audio()
	
	velocity = direction * 5
	move_and_slide()
