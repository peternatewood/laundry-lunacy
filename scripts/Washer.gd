extends StaticBody2D

onready var interior = get_node("Interior")
onready var launch_point = get_node("Launch Point")
onready var spawn_points = get_node("Spawn Points").get_children()
onready var timer = get_node("Timer")


func _ready():
	timer.connect("timeout", self, "launch_laundry")


func get_clothing_count():
	var clothing_count: int = 0

	for body in interior.get_overlapping_bodies():
		if body.is_in_group("clothing"):
			clothing_count += 1

	return clothing_count


func launch_laundry():
	var launch_force: float = MIN_LAUNCH_FORCE + (randf() * MAX_LAUNCH_FORCE)

	for body in interior.get_overlapping_bodies():
		if body is RigidBody2D:
			body.apply_impulse(launch_point.position, launch_force * Vector2.UP)


func reset():
	timer.start()


const MIN_LAUNCH_FORCE: int = 300
const MAX_LAUNCH_FORCE: int = 800
