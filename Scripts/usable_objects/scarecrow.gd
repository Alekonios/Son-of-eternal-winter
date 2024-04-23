extends CharacterBody3D

var died = false
var HP = 50
@onready var animator = $AnimationPlayer

func died_func():
	if HP <= 0 and !died:
		HP = 0
		died = true
		print("kkd")
		animator.play("died")
		await get_tree().create_timer(5, false).timeout
		return_func()
		
func hit():
	if !died:
		animator.play("hit")
		print(HP)
		
func return_func():
	if HP <= 0:
		HP = 50
		animator.play("return")
		await get_tree().create_timer(0.4, false).timeout
		died = false

func _on_died_timer_timeout():
	died_func()
