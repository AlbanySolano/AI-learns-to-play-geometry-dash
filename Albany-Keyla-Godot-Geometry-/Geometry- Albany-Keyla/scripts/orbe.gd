extends Area2D

@export var tipo = 0
@onready var sprite = $Sprite2D
var fuerza = 0
var invertir = false

func _ready() :
	match tipo :
		0 :
			fuerza = -600
			sprite.texture = load("res://imagenes/GreenGravityRing.png")
		1:
			fuerza = 700
			sprite.texture = load("res://imagenes/MagentaJumpRing.png")
		2 :
			fuerza = 3000
			invertir = true
			sprite.texture = load("res://imagenes/RedJumpRing.png")
		3 :
			fuerza = 700
			sprite.texture = load("res://imagenes/BlackGravityRing.png")
		_ :
			fuerza = 0
			invertir = true
			sprite.texture = load("res://imagenes/YellowJumpRing.png")
		
