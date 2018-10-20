extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 30
const JUMP_HEIGHT = -1400
const ACCERELATION = 20
const MAX_SPEED = 700

var motion = Vector2()


func _physics_process(delta):
	var friction = false

	motion.y += GRAVITY

	if Input.is_action_pressed("ui_right"):
		motion.x  = min(motion.x + ACCERELATION, MAX_SPEED)
		$sprite.flip_h = false
		$sprite.play('run')
	elif Input.is_action_pressed("ui_left"):
		motion.x  = max(motion.x - ACCERELATION, -MAX_SPEED)
		$sprite.flip_h = true
		$sprite.play('run')
	else:
		$sprite.play("idle")
		friction = true
		
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.2)
	else:
		$sprite.play("jump-up")
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.2)
	motion = move_and_slide(motion, UP)
