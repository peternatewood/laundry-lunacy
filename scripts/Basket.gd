extends KinematicBody2D

onready var start_position: Vector2 = position

var grabbed: bool = false
var mouse_over: bool = false
var mouse_pos: Vector2 = Vector2.ZERO
var target_angle: float = 0.0
var velocity: Vector2 = Vector2.ZERO
var upend: bool = false


func _ready():
	var mouse_area = get_node("Mouse Area")
	mouse_area.connect("mouse_entered", self, "_on_mouse_entered")
	mouse_area.connect("mouse_exited", self, "_on_mouse_exited")


func _on_mouse_entered():
	if not grabbed:
		Input.set_custom_mouse_cursor(CURSOR_GRAB_ICON)

	mouse_over = true


func _on_mouse_exited():
	if not grabbed:
		Input.set_custom_mouse_cursor(null, Input.CURSOR_ARROW)

	mouse_over = false


func _process(delta):
	if grabbed:
		velocity = SPEED * (mouse_pos - position)
	else:
		# Move back to start position, or drop to ground?
		velocity.x = lerp(velocity.x, 0, delta * SPEED)
		velocity.y += 9.8
		if is_on_floor():
			velocity.y = 0

	if rotation != target_angle:
		set_rotation(lerp(rotation, target_angle, delta * ROTATION_SPEED))
		if abs(rotation - target_angle) < 1e-2:
			rotation = target_angle

	move_and_slide(velocity)


func grab(grab_position: Vector2):
	Input.set_custom_mouse_cursor(CURSOR_GRABBING_ICON)
	grabbed = true
	mouse_pos = grab_position


func release():
	grabbed = false
	if mouse_over:
		Input.set_custom_mouse_cursor(CURSOR_GRAB_ICON)
	else:
		Input.set_custom_mouse_cursor(null, Input.CURSOR_ARROW)


func reset():
	grabbed = false
	mouse_over = false
	target_angle = 0.0
	set_position(start_position)
	set_rotation(0.0)


func upend(direction: int):
	target_angle = direction * PI / 2


func upright():
	target_angle = 0.0


signal grabbed

const CURSOR_GRAB_ICON = preload("res://images/cursor_grab.png")
const CURSOR_GRABBING_ICON = preload("res://images/cursor_grabbing.png")
const ROTATION_SPEED: float = 3.0
const SPEED: float = 5.0
