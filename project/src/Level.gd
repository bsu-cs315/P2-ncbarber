extends Node2D

var character : KinematicBody2D

func _ready():
	make_player()

func _process(_delta):
	if Input.is_action_pressed("restart"):
		restart_level()

func make_player():
	character = load("res://src/Character.tscn").instance()
	character.position = Vector2(100,500)
	call_deferred("add_child", character)

func restart_level():
	var _restart = get_tree().change_scene("res://src/Level.tscn")
