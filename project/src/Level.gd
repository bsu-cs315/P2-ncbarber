extends Node2D


var character : KinematicBody2D
var score := 5
var timer := 0
var running := true

func _ready():
	var randomNumber : RandomNumberGenerator = RandomNumberGenerator.new()
	randomNumber.randomize()
	spawn_player()
	spawn_coin(Vector2(670, 325))
	
	var generatedNumber := randi()%4+1
	if generatedNumber == 1:
		spawn_coin(Vector2(-323, 217))
		spawn_coin(Vector2(3040, -934))
		spawn_coin(Vector2(-295, 225))
		spawn_coin(Vector2(randomNumber.randi_range(1050, 2585), 465))
	elif generatedNumber == 2:
		spawn_coin(Vector2(0, -530))
		spawn_coin(Vector2(2932, 715))
		spawn_coin(Vector2(2144, -295))
		spawn_coin(Vector2(randomNumber.randi_range(1050, 2585), 465))
	elif generatedNumber == 3:
		spawn_coin(Vector2(2614, 75))
		spawn_coin(Vector2(75, -835))
		spawn_coin(Vector2(1312, 144))
		spawn_coin(Vector2(randomNumber.randi_range(378, 1425), -703))
	elif generatedNumber == 4:
		spawn_coin(Vector2(2525, -290))
		spawn_coin(Vector2(1700, 90))
		spawn_coin(Vector2(3313, -493))
		spawn_coin(Vector2(randomNumber.randi_range(2745, 3335), 15))


func _process(_delta):
	timer = $HUD/Timer.time_left
	$HUD/Score.text = "Coins Left: %d" % score
	$HUD/TimeRemaining.text = "Time Remaining: %d" % timer
	
	if score == 0:
		# Run Game Over Screen With Win
		var _game_over := get_tree().change_scene("res://src/Winner.tscn")
		
	elif timer == 0:
		var _game_over := get_tree().change_scene("res://src/GameOver.tscn")

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
		score -= 1


func restart_level():
	var _restart := get_tree().change_scene("res://src/Title.tscn")
