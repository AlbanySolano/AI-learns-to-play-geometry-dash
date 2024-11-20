extends Area2D

func ganar_nivel():
	get_tree().change_scene("res://ruta_a_tu_nivel/Nivel2.tscn")

# Called when the node enters the scene tree for the first time.
func _on_Area2D_body_entered(body):
	if body.is_in_group("jugador"):  # Asegúrate de que el jugador esté en un grupo llamado "jugador"
		ganar_nivel()
