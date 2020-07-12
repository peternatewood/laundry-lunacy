extends KinematicBody2D

onready var container_collider = get_node("Container Collider")

var fill_level: int = 0
var grabbed: bool = false
var mouse_over: bool = false


func _ready():
	connect("mouse_entered", self, "_on_mouse_entered")
	connect("mouse_exited", self, "_on_mouse_exited")
	container_collider.connect("body_entered", self, "_on_body_entered")


func _on_body_entered(body):
	if body.is_in_group("slime_drops") and fill_level < MAX_FILL:
		body.queue_free()
		fill()


func _on_mouse_entered():
	mouse_over = true


func _on_mouse_exited():
	mouse_over = false


func fill():
	fill_level += 1
	if fill_level == 1:
		fill_sprite.show()
	fill_sprite.set_frame(fill_level - 1)


const MAX_FILL: int = 3
