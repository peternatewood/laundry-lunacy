extends Control

onready var minutes_label = get_node("Panel/HBoxContainer/Minutes")
onready var seconds_label = get_node("Panel/HBoxContainer/Seconds")
onready var timer = get_node("Timer")

var minutes: int = 0
var seconds: int = 0


func _ready():
	timer.connect("timeout", self, "_on_timeout")


func _on_timeout():
	# End the round
	pass


func _process(delta):
	var remaining_time: int = timer.get_time_left()

	var remaining_minutes: int = remaining_time / 60
	var remaining_seconds: int = remaining_time % 60

	if minutes != remaining_minutes:
		minutes = remaining_minutes
		minutes_label.set_text(String(remaining_minutes).pad_zeros(2))

	if seconds != remaining_seconds:
		seconds = remaining_seconds
		seconds_label.set_text(String(remaining_seconds).pad_zeros(2))
