extends Node

var n_players = 20
var n_generations = 0
var bots = []
var best_w : Array = []
var best_b : Array = []


# Crear un bot
func create_bot() -> Node:
	var bot = preload("res://scripts/jugador.gd").new()
	bot.position = Vector2(randf_range(-8, 8), 0)  # Ajusta la posición
	add_child(bot)
	print("creando bot: ", bot.position)
	return bot

# Inicializar una generación de bots
func initgen(n_players: int) -> void:
	for i in range(n_players):
		var bot = create_bot()
		bots.append(bot)

# Crear la siguiente generación
func nextgen() -> void:
	bots.clear()
	
	# Copiar pesos y sesgos
	var best_w_copy = best_w.duplicate()
	var best_b_copy = best_b.duplicate()
	
	initgen(n_players)
	
	for i in range(n_players):
		var bot = bots[i]
		if i == 0:
			bot.neural_network.w_input_hidden = best_w_copy[0]
			bot.neural_network.w_hidden_output = best_w_copy[1]
			bot.neural_network.b_hidden = best_b_copy[0]
			bot.neural_network.b_output = best_b_copy[1]
		else:
			# Aquí puedes agregar lógica para mutar los pesos y sesgos
			var offset = randf_range(-2, 2)
			bot.neural_network.w_input_hidden = mutate_matrix(best_w_copy[0], 60, offset)
			bot.neural_network.w_hidden_output = mutate_matrix(best_w_copy[1], 60, offset)
			bot.neural_network.b_hidden = mutate_matrix(best_b_copy[0], 30, offset)
			bot.neural_network.b_output = mutate_matrix(best_b_copy[1], 30, offset)
	n_generations += 1

# Función para mutar las matrices de manera global
func mutate_matrix(matrix: Array, prob: int, offset: float) -> Array:
	if randf() < prob / 100.0:
		for i in range(matrix.size()):
			for j in range(matrix[i].size()):
				matrix[i][j] += offset
	return matrix
	
