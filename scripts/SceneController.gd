extends Node2D

export (NodePath) var basket_path

onready var basket = get_node(basket_path)

var mouse_pos: Vector2 = Vector2.ZERO


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
		if event.pressed and basket.mouse_over:
			basket.grab(mouse_pos)
		elif basket.grabbed:
			basket.release()
