extends Node

const TRANS = Tween.TRANS_SINE
const EASE = Tween.EASE_IN_OUT

var amplitude := 0

onready var camera = get_parent()


func start(_duration = 0.2, _frequency = 15, _amplitude = 16):
	self.amplitude = _amplitude
	$Duration.wait_time = _duration
	$Frequency.wait_time = 1 / float(_frequency)
	$Duration.start()
	$Frequency.start()
	_shake()


func _shake():
	var rand = Vector2()
	rand.x = rand_range(-amplitude, amplitude)
	rand.y = rand_range(-amplitude, amplitude)
	$Tween.interpolate_property(camera, "offset", camera.offset, rand, $Frequency.wait_time, TRANS, EASE)
	$Tween.start()


func _stop_shake():
	$Tween.interpolate_property(camera, "offset", camera.offset, Vector2(), $Frequency.wait_time, TRANS, EASE)
	$Tween.start()


func _on_Frequency_timeout():
	_shake()


func _on_Duration_timeout():
	_stop_shake()
	$Frequency.stop()
