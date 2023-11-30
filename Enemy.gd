extends CharacterBody2D
var hp = 2

func _physics_process(delta):
	if hp <= 0:
		queue_free()


func _on_area_2d_area_entered(area):
	if area.is_in_group("latk") and Globals.latk == true:
		hp -= 1
		print(hp)
	
