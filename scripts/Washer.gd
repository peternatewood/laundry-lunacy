extends StaticBody2D

onready var interior = get_node("Interior")
onready var launch_point = get_node("Launch Point")


func _ready():
	var timer = get_node("Timer")
	timer.connect("timeout", self, "launch_laundry")


func launch_laundry():
	var launch_force: float = MIN_LAUNCH_FORCE + (randf() * MAX_LAUNCH_FORCE)

	for body in interior.get_overlapping_bodies():
		body.apply_impulse(launch_point.position, launch_force * Vector2.UP)


const MIN_LAUNCH_FORCE: int = 64
const MAX_LAUNCH_FORCE: int = 320
