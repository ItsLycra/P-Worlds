extends CharacterBody2D
var direction : int
var decel = 0.175
var airdecel = 0.01
var rightatk = true
var leftatk = false
var latkcd = true
@export var walljump = -200
@export var speed = 200
@export var jump_speed = -150
@export var gravity = 500

func _physics_process(delta):
	print(Globals.latk)
	direction = Input.get_axis('p2left', 'p2right')
	if Input.is_action_just_pressed("p2jump") and is_on_wall():
		velocity.y = walljump
		direction = direction * -1.0
	if not is_on_floor():
		velocity.y += gravity * delta
	if Input.is_action_just_pressed('p2jump') and is_on_floor():
		velocity.y = jump_speed
	if direction:
		velocity.x = direction * speed
		face_direction()
	elif is_on_floor():
		velocity.x = lerp(velocity.x, 0.0, decel)
	elif not is_on_floor():
		velocity.x = lerp(velocity.x, 0.0, airdecel)
	move_and_slide()
	latk()
	
func latk():
	if Input.is_action_pressed("p2latk") and latkcd == true:
		$latkcd.start()
		if rightatk == true:
			$AnimationPlayer.play("LATK")
			await get_tree().create_timer(0.5).timeout
			$AnimationPlayer.play("RESET")
			latkcd = false
		elif leftatk == true:
			$AnimationPlayer.play("LATK2")
			await get_tree().create_timer(0.5).timeout
			$AnimationPlayer.play("RESET2")
			latkcd = false
	
func face_direction():
	if direction > 0:
		$Sprite2D.flip_h = false
#		$AnimationPlayer.play("RESET")
		rightatk = true
		leftatk = false
		if $AnimationPlayer.current_animation != "LATK":
			$AnimationPlayer.play("RESET")
	elif direction < 0:
		$Sprite2D.flip_h = true
#		$AnimationPlayer.play("RESET2")
		rightatk = false
		leftatk = true
		if $AnimationPlayer.current_animation != "LATK2":
			$AnimationPlayer.play("RESET2")



func _on_latkcd_timeout():
	latkcd = true


func _on_area_2d_area_entered(area):
	if area.is_in_group("enemy"):
		Globals.lives -= 1
