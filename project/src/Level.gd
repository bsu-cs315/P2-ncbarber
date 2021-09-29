extends Node2D

var character : KinematicBody2D
var HUD : Sprite
var score := 0

func _ready():
	spawn_player()
	spawn_coin(Vector2(250, 450))
	spawn_coin(Vector2(670, 325))
	spawn_coin(Vector2(1680, 100))
	spawn_coin(Vector2(2460,85))


func _process(_delta):
	if Input.is_action_pressed("restart"):
		restart_level()


func spawn_player():
	character = load("res://src/Character.tscn").instance()
	character.position = Vector2(100,500)
	call_deferred("add_child", character)


func spawn_coin(spawnPosition):
	var coin : Area2D = load("res://src/Coin.tscn").instance()
	var _connection := coin.connect("body_entered", self, "_on_Coin_Entered", [coin])
	coin.position = spawnPosition
	call_deferred("add_child", coin)


func _on_Coin_Entered(body, coin):
	if body == character:
		coin.queue_free()
		score += 10
		print("Score: ", score)


func restart_level():
	var _restart := get_tree().change_scene("res://src/Title.tscn")
