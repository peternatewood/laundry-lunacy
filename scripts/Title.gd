extends Control


func _ready():
	randomize()

	var start_button = get_node("PanelContainer/VBoxContainer/Start Button")
	start_button.connect("pressed", self, "_on_start_pressed")

	var quit_button = get_node("PanelContainer/VBoxContainer/Quit Button")
	quit_button.connect("pressed", self, "_on_quit_pressed")


func _on_start_pressed():
	get_tree().change_scene("res://main.tscn")


func _on_quit_pressed():
	get_tree().quit()
