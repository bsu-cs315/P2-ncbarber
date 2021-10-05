extends Control


func _on_StartGame_pressed():
	var _ignored := get_tree().change_scene("res://src/Level.tscn")


func _on_MainMenu_pressed():
	var _ignored := get_tree().change_scene("res://src/Title.tscn")
