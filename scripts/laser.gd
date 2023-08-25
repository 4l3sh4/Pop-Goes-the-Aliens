class_name Laser extends Area2D

@export var speed = 900
@export var damage = 1

@onready var animations = $AnimationPlayer

func _physics_process(delta):
	global_position.y += -speed * delta
	animations.play("glowing")
	
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	
#Enemy and Laser Gone
func _on_area_entered(area):
	if area is Alan:
		area.take_damage(damage)
		queue_free()
