extends Control

onready var minutes_label = get_node("Panel/HBoxContainer/Minutes")
onready var round_over = get_node("Round Over")
onready var seconds_label = get_node("Panel/HBoxContainer/Seconds")
onready var timer = get_node("Timer")

var minutes: int = 0
var seconds: int = 0


func _ready():
	var new_round_button = get_node("Round Over/PanelContainer/VBoxContainer/New Round Button")
	new_round_button.connect("pressed", self, "_on_new_round_pressed")

	var quit_button = get_node("Round Over/PanelContainer/VBoxContainer/Quit Button")
	quit_button.connect("pressed", self, "_on_quit_pressed")

	timer.connect("timeout", self, "_on_timeout")


func _on_new_round_pressed():
	emit_signal("new_round_pressed")


func _on_quit_pressed():
	emit_signal("quit_pressed")


func _on_timeout():
	round_over.show()
	emit_signal("round_ended")


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


func reset():
	round_over.hide()
	timer.start()


signal new_round_pressed
signal quit_pressed
signal round_ended
