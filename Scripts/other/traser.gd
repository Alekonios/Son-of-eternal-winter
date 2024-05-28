extends CharacterBody3D


var speed = 100  # Скорость пули

var purpose = null


func _process(delta):
	position += transform.basis * Vector3(0, 0, -speed) * delta
	if speed >= 5:
		await get_tree().create_timer(0.06)
		speed -= 5
	else:
		speed = 10
	await get_tree().create_timer(0.5,false).timeout
	queue_free()



func _on_area_3d_body_entered(_body):
	queue_free()
