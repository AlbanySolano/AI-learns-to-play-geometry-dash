extends Area2D


func _on_body_entered(body: Node2D):
	if body.is_in_group("kill"):
		$"..".death() #selecciona al padre para poder iniciar la funcion de muerte creada en el script jugador
		self.queue_free()
	#	get_tree().reload_current_scene()
