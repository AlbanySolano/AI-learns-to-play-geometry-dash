extends Area2D

@export var tipo : int
@onready var imagen : Sprite2D = $Sprite2D

func _ready():
	match tipo :
		0 :
			imagen.texture = load("res://imagenes/BallPortal.png")
		
		1:
			imagen.texture = load("res://imagenes/CubePortalLabelled.png")
		
		2:
			imagen.texture = load("res://imagenes/ShipPortal.png")
			
		3:
			imagen.texture = load("res://imagenes/UFOPortal.png")
		
		4:
			imagen.texture = load("res://imagenes/WavePortal.png")
