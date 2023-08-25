class_name Player extends CharacterBody2D

signal laser_shot(laser_scene, location)
signal killed

@export var speed: int = 300
@onready var animations = $AnimationPlayer
@onready var muzzle = $Muzzle
@onready var ship_death = $ShipDeathSFX

var laser_scene = preload("res://scenes/laser.tscn")

var shoot_cd := false

#Pew Pew
func _process(delta):
	if Input.is_action_pressed("shoot"):
		if !shoot_cd:
			shoot_cd = true
			shoot()
			await get_tree().create_timer(0.25).timeout
			shoot_cd = false
		
#Movement
func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	
#Animations
func updateAnimation():
	var state = "Idle"
	if velocity.x < 0: state = "Left"
	elif velocity.x > 0: state = "Right"
	elif speed <= 0: state = "Explode"
	
	animations.play("move" + state)
		
func _physics_process(delta):
	get_input()
	move_and_slide()
	updateAnimation()
	
	#Makes sure the player ain't goin' off the screen
	global_position = global_position.clamp(Vector2.ZERO,get_viewport_rect().size)
	
#Pew Pew 2: Electric Boogaloo
func shoot():
	var laser = laser_scene.instantiate()
	laser.global_position = muzzle.global_position
	emit_signal("laser_shot", laser)
	
#O7
func die():
	ship_death.play()
	speed = 0
	await animations.animation_finished
	queue_free()
	killed.emit()
