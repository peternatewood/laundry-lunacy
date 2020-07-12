extends Sprite

onready var leak_point = get_node("Leak Point")
onready var slime_sprite = get_node("Slime Sprite")
onready var timer = get_node("Timer")

var base_wait_time: int


func _ready():
	base_wait_time = timer.wait_time
	timer.set_wait_time(base_wait_time + (randi() % 3))
	timer.connect("timeout", self, "_on_timer_timeout")


func _on_timer_timeout():
	if slime_sprite.visible:
		timer.set_wait_time(base_wait_time + (randi() % 3))
		slime_sprite.hide()
		emit_signal("pipe_leaked", leak_point.global_position)
	else:
		slime_sprite.show()


func reset():
	timer.start()


signal pipe_leaked
