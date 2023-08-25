class_name Alan extends Area2D

signal killed(points)

@export var speed = 150
@export var hp = 1
@export var points = 1

@onready var animations = $AnimationPlayer

func _physics_process(delta):
	global_position.y += speed * delta
	animations.play("sillyTime")

#Enemy and Laser Gone
func die():
	queue_free()

func _on_body_entered(body):
	if body is Player:
		body.die()
		die()

#Alan Takes Damage :(
func take_damage(amount):
	hp -= amount
	if hp <= 0:
		die()
		killed.emit(points)
