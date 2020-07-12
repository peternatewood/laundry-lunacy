extends Node2D

export (NodePath) var basket_path

onready var basket = get_node(basket_path)
onready var hud = get_node("CanvasLayer/HUD")

var mouse_pos: Vector2 = Vector2.ZERO


func _ready():
	hud.connect("new_round_pressed", self, "_on_new_round_pressed")
	hud.connect("quit_pressed", self, "_on_quit_pressed")
	hud.connect("round_ended", self, "_on_round_ended")

	spawn_clothing()


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


func _on_new_round_pressed():
	# Reset everything
	spawn_clothing()
	hud.reset()

	get_tree().set_pause(false)


func _on_quit_pressed():
	get_tree().quit()


func _on_round_ended():
	get_tree().set_pause(true)
	# TODO: Count clothing in each washer


func spawn_clothing():
	# Clean up any existing articles of clothing
	for clothing in get_tree().get_nodes_in_group("clothing"):
		clothing.queue_free()

	var spawn_count: int = 2
	for washer in get_tree().get_nodes_in_group("washers"):
		for i in range(spawn_count):
			var index: int = randi() % CLOTHING_PREFABS.size()
			var clothing = CLOTHING_PREFABS[index].instance()
			add_child(clothing)
			clothing.set_position(washer.spawn_points[i].global_position)
			clothing.add_to_group("clothing")


const CLOTHING_PREFABS: Array = [
	preload("res://prefabs/Boxers.tscn"),
	preload("res://prefabs/Pants.tscn"),
	preload("res://prefabs/Shirt.tscn"),
	preload("res://prefabs/Sock.tscn")
]
