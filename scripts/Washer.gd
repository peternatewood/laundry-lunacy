extends StaticBody2D

onready var interior = get_node("Interior")
onready var launch_point = get_node("Launch Point")
onready var spawn_points = get_node("Spawn Points").get_children()


func _ready():
	var timer = get_node("Timer")
	timer.connect("timeout", self, "launch_laundry")


func launch_laundry():
	var launch_force: float = MIN_LAUNCH_FORCE + (randf() * MAX_LAUNCH_FORCE)

	for body in interior.get_overlapping_bodies():
		if body is RigidBody2D:
			body.apply_impulse(launch_point.position, launch_force * Vector2.UP)


const MIN_LAUNCH_FORCE: int = 64
const MAX_LAUNCH_FORCE: int = 320
