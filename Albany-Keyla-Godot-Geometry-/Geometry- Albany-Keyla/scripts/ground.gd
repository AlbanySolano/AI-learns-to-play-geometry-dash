extends StaticBody2D



@onready var jugador = get_node("../jugador")

func _process(delta):
	position.x = jugador.position.x + 300
	$Sprite2D.region_rect.position.x += (jugador.SPEED / 60) * delta
