extends CharacterBody2D

func _process(delta):
	position += (transform.x * Globals.bullet_speed * delta)
