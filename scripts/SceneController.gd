extends Node2D

export (NodePath) var basket_path

onready var basket = get_node(basket_path)

var mouse_pos: Vector2 = Vector2.ZERO


func _ready():
	# Spawn clothing
	var spawn_count: int = 2
	for washer in get_tree().get_nodes_in_group("washers"):
		for i in range(spawn_count):
			var index: int = randi() % CLOTHING_PREFABS.size()
			print(index)
			var clothing = CLOTHING_PREFABS[index].instance()
			add_child(clothing)
			clothing.set_position(washer.spawn_points[i].global_position)


func _input(event):
	if event is InputEventMouseMotion:
		mouse_pos = event.position

		if basket.grabbed:
			basket.mouse_pos = mouse_pos
	elif event is InputEventMouseButton:
		match event.button_index:
			BUTTON_LEFT:
				if event.pressed:
					basket.upend(-1)
				else:
					basket.upright()
			BUTTON_RIGHT:
				if event.pressed:
					basket.upend(1)
				else:
					basket.upright()
	elif event.is_action("grab"):
		if event.pressed:
			if not event.is_echo() and basket.mouse_over and not basket.grabbed:
				basket.grab(mouse_pos)
		elif basket.grabbed:
			basket.release()


const CLOTHING_PREFABS: Array = [
	preload("res://prefabs/Boxers.tscn"),
	preload("res://prefabs/Pants.tscn"),
	preload("res://prefabs/Shirt.tscn"),
	preload("res://prefabs/Sock.tscn")
]
