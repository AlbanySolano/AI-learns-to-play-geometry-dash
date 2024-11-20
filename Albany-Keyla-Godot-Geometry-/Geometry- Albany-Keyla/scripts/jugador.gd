extends CharacterBody2D

var SPEED = 25000.0
var JUMP_VELOCITY = -450.0
var rotacion = 500

var isOrbe = false
var fuerzaorbe = 0
var canInvert = false
var isUfo = false
@onready var RayCast = $RayCast2D
var gravity = 5000
@onready var genetic_alg = preload("res://scripts/genetic_alg.gd").new()
@onready var neural_network = preload("res://scripts/neural_network.gd").new()
var enviroment_inputs: Array = []

func _ready():
	genetic_alg.initgen(20)

func perform_jump():
	if is_on_floor():
		velocity.y = JUMP_VELOCITY
		print("Saltando")
		
func _physics_process(delta: float) -> void:
	# controla que el jugador se mueva solo a la derecha
	velocity.x = SPEED * delta
	var distance = get_distance_to_next_obstacle()
	if distance < 100.0:
		perform_jump()
	
	enviroment_inputs = [
		[get_distance_to_next_obstacle()],
		[velocity.x],
		[1.0 if is_on_floor() else 0.0]
	]
	var output = neural_network.evaluate(enviroment_inputs)
	print("enviroment inputs: ", enviroment_inputs)
	
	if output.size() > 0 and output[0].size() >0:
		if output[0][0] > 0.5:
			perform_jump()
			#if isUfo == true or is_on_floor():
			#	velocity.y = JUMP_VELOCITY
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		#$Sprite2D.rotation_degrees += 380 * delta
	#else:
	#	var modulo = int($Sprite2D.rotation_degrees) % 90;
	#	if modulo > 45:
	#		$Sprite2D.rotation_degrees += (90 - modulo)
	#	else:
	#		$Sprite2D.rotation_degrees -= modulo

	# Handle jump con el control configurado.
	#if Input.is_action_pressed("salto"):
	#	if isUfo == true or is_on_floor():
	#		velocity.y = JUMP_VELOCITY

	
	if isOrbe and Input.is_action_just_pressed("salto"):
		velocity.y = -fuerzaorbe
		if canInvert == true :
			gravity = -gravity
			JUMP_VELOCITY = -JUMP_VELOCITY
			rotacion = -rotacion
			isOrbe = false
	move_and_slide()
	
func get_distance_to_next_obstacle() -> float:
	print("Raycast: ", RayCast.is_colliding())
	
	if RayCast.is_colliding():
		var collision_point = RayCast.get_collision_point()
		var distance = collision_point.distance_to(position)
		print("Distancia hasta el obstaculo: ", distance)
		return distance
	else:
		print("No hay colision, preterminada en 200")
		return 200
		
		
func death():
	SPEED = 0
	$Sprite2D.visible = false
	$AudioStreamPlayer2D.play()
	$Timer.start()

func _on_timer_timeout():
	get_tree().reload_current_scene()

func _on_externo_area_entered(area: Area2D) -> void:
	if area.is_in_group("orbe"):
		isOrbe = true
		fuerzaorbe = area.fuerza
		canInvert = area.invertir
		
	
	if area.is_in_group("trampolines") :
		velocity.y = -area.fuerza
		if area.invertir == true :
			gravity = -gravity
			JUMP_VELOCITY = -JUMP_VELOCITY
			rotacion = -rotacion
	if area.is_in_group("portal") :
		match area.tipo :
			0 :
				$Sprite2D.texture = load("res://imagenes/Ball001.png")
				isUfo = false
			1:
				$Sprite2D.texture = load("res://imagenes/Cube001.png")
				isUfo= false
			2:
				$Sprite2D.texture = load("res://imagenes/Ship001.png")
				isUfo = false
			3:
				$Sprite2D.texture = load("res://imagenes/UFO001.png")
				isUfo = true
				JUMP_VELOCITY = -800
			4:
				$Sprite2D.texture = load("res://imagenes/Wave001.png")
				isUfo = false
				JUMP_VELOCITY = -1200

func _on_externo_area_exited(area: Area2D) -> void:
	if area.is_in_group("orbe"):
			isOrbe = false
			fuerzaorbe = 0
			canInvert = false
