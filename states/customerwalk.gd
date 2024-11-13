extends State
class_name CustomerWalk

@export var customer: CharacterBody3D
@export var move_speed := 4.0
var destination : Node3D

func enter():
	destination = get_tree().get_first_node_in_group("Destination")

func physics_update(delta: float):
	var direction = destination.global_position - customer.global_position
	
	if direction.length() > 25:
		customer.velocity = direction.normalized() * move_speed
	else: 
		customer.velocity = Vector3()
