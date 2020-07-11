extends KinematicBody2D

var grabbed: bool = false
var mouse_pos: Vector2 = Vector2.ZERO
var velocity: Vector2 = Vector2.ZERO
var upend: bool = false


func _ready():
	var click_area = get_node("Click Area")
	click_area.connect("input_event", self, "_on_click_area_event")


func _on_click_area_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				emit_signal("grabbed")


func _process(delta):
	if grabbed:
		velocity = mouse_pos - position
	else:
		# Move back to start position, or drop to ground?
		velocity.y += 9.8

	move_and_slide(velocity)


func grab(grab_position: Vector2):
	grabbed = true
	mouse_pos = grab_position


func release():
	grabbed = false


signal grabbed
