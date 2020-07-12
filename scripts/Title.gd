extends Control

onready var directions_popup = get_node("Directions")
onready var overlay = get_node("Overlay")


func _ready():
	randomize()

	var start_button = get_node("PanelContainer/VBoxContainer/Start Button")
	start_button.connect("pressed", self, "_on_start_pressed")

	var directions_button = get_node("PanelContainer/VBoxContainer/Directions Button")
	directions_button.connect("pressed", self, "_on_directions_pressed")

	var quit_button = get_node("PanelContainer/VBoxContainer/Quit Button")
	quit_button.connect("pressed", self, "_on_quit_pressed")

	directions_popup.connect("popup_hide", self, "_on_directions_popup_hide")


func _on_directions_popup_hide():
	overlay.hide()


func _on_directions_pressed():
	overlay.show()
	directions_popup.popup_centered()


func _on_quit_pressed():
	get_tree().quit()


func _on_start_pressed():
	get_tree().change_scene("res://main.tscn")
