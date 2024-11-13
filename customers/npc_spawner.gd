extends Node3D

var navigation_npc = preload("res://customers/customer.tscn")
var customer = null

func _process(_delta):
	if customer == null:
		var new_obj = navigation_npc.instantiate()
		new_obj.position = position
		get_parent().add_child(new_obj)
		customer = new_obj
		
