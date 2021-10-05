extends Node2D

var character : KinematicBody2D
var HUD : Sprite
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
		spawn_coin(Vector2(randomNumber.randi_range(1050, 2585), 465))
	elif generatedNumber == 2:
		spawn_coin(Vector2(0, -530))
		spawn_coin(Vector2(2932, 715))
	elif generatedNumber == 3:
		spawn_coin(Vector2(2614, 75))
		spawn_coin(Vector2(randomNumber.randi_range(378, 1425), -703))
	elif generatedNumber == 4:
		spawn_coin(Vector2(randomNumber.randi_range(2745, 3335), 15))
		spawn_coin(Vector2(1700, 90))


func _process(_delta):
	timer = $HUD/Timer.time_left
	$HUD/Score.text = "Coins Left: %d" % score
	$HUD/TimeRemaining.text = "Time Remaining: %d" % timer
	
	if score == 0:
		# Run Game Over Screen
		score = 0
	if timer == 0:
		# Run You lose
		timer = 0
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
		#print("Score: ", score)


func restart_level():
	var _restart := get_tree().change_scene("res://src/Title.tscn")
