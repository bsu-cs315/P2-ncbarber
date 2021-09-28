extends KinematicBody2D

var gravity := 600
var jumpPower := -350
var rocketJumpPower := -500
var speed := 250
var jumpped = false
var rocketJumpped = false
var velocity = Vector2()

func _physics_process(delta):
	velocity.x = 0

		
	if Input.is_action_pressed("right"):
		velocity.x += speed
		if is_on_floor():
			$AnimatedSprite.animation = "walking"
			$AnimatedSprite.play()
			$AnimatedSprite.flip_h = false
	if Input.is_action_pressed("left"):
		velocity.x -= speed
		if is_on_floor():
			$AnimatedSprite.animation = "walking"
			$AnimatedSprite.play()
			$AnimatedSprite.flip_h = true
	if Input.is_action_pressed("jump"):
		if is_on_floor():
			velocity.y = jumpPower
			jumpped = true
			$AnimatedSprite.animation = "jumping"
			$AnimatedSprite.play()
	if Input.is_action_pressed("rocket_launch"):
		if is_on_floor():
			velocity.y = rocketJumpPower
			rocketJumpped = true
			$AnimatedSprite.animation = "rocket"
			$AnimatedSprite.play()
			
	if velocity.x == 0 and is_on_floor():
		$AnimatedSprite.stop()
		$AnimatedSprite.animation = "idle"
		$AnimatedSprite.play()
	if Input.is_action_pressed("down"):
		if is_on_floor() and velocity.x == 0:
			$AnimatedSprite.stop()
			$AnimatedSprite.animation = "ducking"
			$AnimatedSprite.play()
		

	velocity.y += gravity * delta
	if jumpped and is_on_floor():
		jumpped = false
	velocity = move_and_slide(velocity, Vector2(0,-1))
