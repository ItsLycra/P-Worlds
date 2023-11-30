extends CharacterBody2D
var hp = 2
var movetime = true
var left = true
var right = false

func _physics_process(delta):
	if hp <= 0:
		queue_free()
	if is_on_wall():
		velocity.x * -1
	
		
	move_and_slide()


func _on_area_2d_area_entered(area):
	if area.is_in_group("latk") and Globals.latk == true:
		hp -= 1
		print(hp)
	


func _on_timer_timeout():
	$AnimatedSprite2D.play("piderwalk")
	velocity.x += 100
	await get_tree().create_timer(1).timeout
	velocity.x -= 100
	$AnimatedSprite2D.play("pideridle")
	
