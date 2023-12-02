extends StaticBody2D
var b1 = true
var b2 = false
var b3 = false

func _ready():
	$AnimatedSprite2D.play("wall")
	
func _on_area_2d_area_entered(area):
	if area.is_in_group("latk") and b1 == true:
		$AnimatedSprite2D.play("wallbreak")
		b2 = true
		b1 = false
	elif area.is_in_group("latk") and b2 == true:
		$AnimatedSprite2D.play("wallbreak2")
		b3 = true
		b2 = false
	elif area.is_in_group("latk") and b3 == true:
		queue_free()
		b3 = false
