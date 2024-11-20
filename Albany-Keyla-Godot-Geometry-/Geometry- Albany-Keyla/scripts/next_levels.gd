extends Node

var niveles = [
	"res://escenas/level_1.tscn", 
	"res://escenas/level_2.tscn", 
	"res://escenas/level_3.tscn"
]
var nivel_actual = 0

func cambiar_a_siguiente_nivel():
	nivel_actual += 1
	if nivel_actual < niveles.size():
		var next_scene = load(niveles[nivel_actual])
		get_tree().current_scene.queue_free()  # Free the current scene if necessary
		get_tree().change_scene_to(next_scene)
	else:
		print("¡Has completado todos los niveles!")

func _on_body_entered(body):
	print("Body entered: ", body.name)
	if body.name == "jugador":  # Make sure this matches your player's node name
		print("Jugador reached the goal!")
		cambiar_a_siguiente_nivel()
