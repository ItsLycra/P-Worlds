extends CharacterBody2D


var SPEED = 350.0
var JUMP_VELOCITY = -250.0
var gravity = 400.0
@export var decel = 0.1
@export var airdecel = 0.05
@onready var bullet_scene = preload("res://b.tscn")
@export var walljump = -200
var shooting = true
var left = false
var hp = 100


func _physics_process(delta):
	var direction = Input.get_axis("p1left", "p1right")
	Globals.direct = direction
	
	if hp <= 0:
		pass

	if Input.is_action_just_pressed("p2jump") and is_on_wall():
		velocity.y = walljump
		direction = direction * -1.0
	
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if Input.is_action_just_pressed("p1jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY 
		if not is_on_floor():
			velocity.y += gravity * delta
			
	if direction:
		velocity.x = direction * SPEED
		
	elif not is_on_floor():
		velocity.x = lerp(velocity.x, 0.0, airdecel)  
	
	elif is_on_floor():
		velocity.x = lerp(velocity.x, 0.0, decel)
		
	if Input.is_action_pressed("p1atk"):
		shoot(delta)
		if Input.is_action_just_released("p1atk"):
			shooting = false
		
	move_and_slide()
	face_direction()
	take_damage()
	
func shoot(delta):
	if shooting == true:
		var bullet = bullet_scene.instantiate()
		if Globals.direct > 0:
			bullet.rotate(0)
			left = false
		elif Globals.direct < 0:
			bullet.rotate(3.1)
			left = true
		if left == true and Globals.direct == 0:
			bullet.rotate(3.1)
		bullet.global_position = position
		get_parent().add_child(bullet)
		shooting = false
		$Timer.start()

func _on_timer_timeout():
	shooting = true

func face_direction():
	if Globals.direct > 0:
		$Sprite2D.flip_h = false

	elif Globals.direct < 0:
		$Sprite2D.flip_h = true

func take_damage():
	pass
