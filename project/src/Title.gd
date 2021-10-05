extends Control


func _on_StartGame_pressed():
	var _ignored := get_tree().change_scene("res://src/Level.tscn")


func _on_WordDrop_animation_finished(_anim_name):
	$DudeWithRocketLauncher/FlyIn.play("FlyIn")
	$Label/Float.play("Float")


func _on_HowToPlay_pressed():
	var _ignored := get_tree().change_scene("res://src/Instructions.tscn")

