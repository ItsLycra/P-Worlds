extends CharacterBody2D
var hp = 2
var movetime = false
var speed = 100
var negspeed = -100
@export var gravity = 500

func _physics_process(delta):
	if hp <= 0:
		queue_free()
	if is_on_wall() and movetime == true:
		velocity.x = speed * -1
		speed = speed * -1
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if velocity.x > 100 and movetime == true:
		velocity.x = speed
	elif velocity.x < -100 and movetime == true:
		velocity.x = negspeed
	
		
	move_and_slide()


func _on_area_2d_area_entered(area):
	if area.is_in_group("latk"):
		hp -= 1
		print(hp)
	


func _on_timer_timeout():
	$AnimatedSprite2D.play("piderwalk")
	velocity.x = speed 
	movetime = true
	await get_tree().create_timer(1).timeout
	velocity.x = 0
	movetime = false
	$AnimatedSprite2D.play("pideridle")
	
