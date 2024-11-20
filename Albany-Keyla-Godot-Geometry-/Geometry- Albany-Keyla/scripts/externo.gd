extends Area2D


func _on_area_entered(area: Area2D):
	if area.is_in_group("kill"):
		$"..".death() #mismo sistema de muerte
		self.queue_free()
		#get_tree().reload_current_scene()
