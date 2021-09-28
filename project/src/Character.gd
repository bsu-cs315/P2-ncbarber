extends KinematicBody2D

var gravity = 500
var jumpPower = -350
var rocketJump = -500
var speed = 200
#var currentGravity = gravity
var jumpped = false
var velocity = Vector2()

func _physics_process(delta):
	velocity.x = 0

	if Input.is_action_pressed("jump"):
		if is_on_floor():
			velocity.y = jumpPower
			jumpped = true
			$AnimatedSprite.animation = "jumping"
			$AnimatedSprite.play()
	elif Input.is_action_pressed("rocket_launch"):
		if is_on_floor():
			velocity.y = rocketJump
			jumpped = true
			$AnimatedSprite.animation = "jumping"
			$AnimatedSprite.play()
	elif Input.is_action_pressed("right"):
		velocity.x += speed
		if is_on_floor():
			$AnimatedSprite.animation = "walking"
			$AnimatedSprite.flip_h = false
			$AnimatedSprite.play()
	elif Input.is_action_pressed("left"):
		velocity.x -= speed
		if is_on_floor():
			$AnimatedSprite.animation = "walking"
			$AnimatedSprite.flip_h = true
			$AnimatedSprite.play()
	elif Input.is_action_pressed("down"):
		if is_on_floor() and velocity.x == 0:
			$AnimatedSprite.animation = "ducking"
			$AnimatedSprite.play()
	elif velocity.x == 0 and is_on_floor():
		$AnimatedSprite.animation = "idle"
		$AnimatedSprite.play()
	
	velocity.y += gravity * delta
	if jumpped and is_on_floor():
		jumpped = false
	velocity = move_and_slide(velocity, Vector2(0,-1))
