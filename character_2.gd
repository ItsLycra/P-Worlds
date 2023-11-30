extends CharacterBody2D
var direction : int
var decel = 0.175
var airdecel = 0.01
@export var speed = 200
@export var jump_speed = -150
@export var gravity = 500

func _physics_process(delta):
	print(Globals.latk)
	direction = Input.get_axis('p2left', 'p2right')
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
	if Input.is_action_pressed("p2latk"):
		Globals.latk = true
		await get_tree().create_timer(1).timeout
		Globals.latk = false
	
func face_direction():
	if direction > 0:
		$Sprite2D.flip_h = false
		$atk.position.x = 74 
	elif direction < 0:
		$Sprite2D.flip_h = true
		$atk.position.x = -74
