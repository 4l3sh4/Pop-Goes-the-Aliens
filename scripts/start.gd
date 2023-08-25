extends Control

func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://scenes/game.tscn")

#Show Credits
func _on_credits_button_pressed():
	$CanvasLayer.visible = false
	$CanvasLayer2.visible = true
	
#Back to Start
func _on_back_button_pressed():
	$CanvasLayer2.visible = false
	$CanvasLayer.visible = true
