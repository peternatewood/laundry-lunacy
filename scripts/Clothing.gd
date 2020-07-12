extends RigidBody2D

onready var impact_sounds = get_node("Impact Sounds")


func _ready():
	connect("body_entered", self, "_on_body_entered")


func _on_body_entered(body):
	if body is KinematicBody2D:
		impact_sounds.play_sound()
