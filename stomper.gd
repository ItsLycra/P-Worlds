extends CharacterBody2D

var direction = 0
var speed = 50
var gravity = 350

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta
	$rotation/RayCast2D.look_at(Globals.player_pos)
	if $rotation/RayCast2D.is_colliding() and $rotation/RayCast2D.get_collider() != null and $rotation/RayCast2D.get_collider().is_in_group("player"):
		move_and_slide()
		tracking(delta)
	move_and_slide()
	print(direction)

func tracking(delta):
	direction = global_position.direction_to(Globals.player_pos)
	velocity.x = direction.x * speed
#	if not is_on_floor():
#	velocity.y = 0
