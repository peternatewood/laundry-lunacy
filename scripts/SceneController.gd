extends Node2D

export (NodePath) var basket_path

onready var basket = get_node(basket_path)

var mouse_pos: Vector2 = Vector2.ZERO


func _ready():
	basket.connect("grabbed", self, "_on_basket_grabbed")


func _input(event):
	if event is InputEventMouseMotion:
		mouse_pos = event.position

		if basket.grabbed:
			basket.mouse_pos = mouse_pos
	elif event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if not event.pressed:
				if basket.grabbed:
					basket.release()


func _on_basket_grabbed():
	basket.grab(mouse_pos)
