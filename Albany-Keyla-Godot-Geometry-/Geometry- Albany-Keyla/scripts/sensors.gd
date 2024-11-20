extends Area2D

var distance_to_spike = 1000

var player_position = get_parent().global_position
 
func _on_area_2d_body_entered(body):
	if body.is_in_group("spike"):
		distance_to_spike = player_position.distance_to(body.global_position)

func _on_area_2d_body_exited(body):
	if body.is_in_group("spike"):
		distance_to_spike = 1000
