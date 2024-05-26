extends Decal


func _on_timer_timeout():
	$AnimationPlayer.play("visible_of")
	await get_tree().create_timer(3, false).timeout
	queue_free()
