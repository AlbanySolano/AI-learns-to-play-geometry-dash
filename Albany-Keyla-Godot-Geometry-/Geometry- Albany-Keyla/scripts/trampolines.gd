extends Area2D

@export var tipo = 0
@onready var sprite = $Sprite2D
var fuerza = 0
var invertir = false

func _ready() :
	match tipo :
		0 :
			fuerza = 600
			sprite.texture = load("res://imagenes/Blue_Pad.png")
		1:
			fuerza = 850
			sprite.texture = load("res://imagenes/Purple_Pad.png")
		2 :
			fuerza = 500
			invertir = true
			sprite.texture = load("res://imagenes/Red_Pad2.png")
		3 :
			fuerza = 800
			sprite.texture = load("res://imagenes/Yellow_Pad.png")
		
		_ :
			queue_free()
