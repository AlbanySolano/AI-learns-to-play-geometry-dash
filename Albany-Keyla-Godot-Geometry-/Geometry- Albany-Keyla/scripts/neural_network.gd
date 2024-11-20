extends Node

var n_inputs = 3
var n_hidden = 3
var n_outputs = 1

#pesos y sesgos aleatorios

var w_input_hidden: Array = []
var w_hidden_output: Array = []
var b_hidden: Array = []
var b_output: Array = []

var w: Array = [
	[0.89, 0.03, -0.44],  # Pesos para la capa de entrada a capa oculta
	[0.32, -0.21, 0.41]  # Pesos para la capa oculta a capa de salida (esto es solo un ejemplo)
]
var b: Array = [
	[-0.85],  # Sesgos para la capa oculta
	[0.47]    # Sesgo para la capa de salida
]

#func _ready():
#	w_input_hidden = initialize_weights(n_inputs, n_hidden)
#	w_hidden_output = initialize_weights(n_hidden, n_outputs)
#	b_hidden = initialize_biases(n_hidden)
#	b_output = initialize_biases(n_outputs)
#	
#func initialize_weights(input_size: int, output_size: int) -> Array:
#	var weights = []
#	for i in range(input_size):
#		var row = []
#		for j in range(output_size):
#			row.append(randf_range(-1.0, 1.0))
#		weights.append(row)
#	return weights
	
func initialize_biases(size: int) -> Array:
	var biases = []
	for i in range(size):
		biases.append(randf_range(-1.0, 1.0))
	return biases

func evaluate(inputs: Array) -> Array:
	var hidden_input = _matrix_multiply(w_input_hidden, inputs)
	hidden_input = _matrix_sum(hidden_input, b_hidden)
	var hidden_output = apply_activation(hidden_input)
	
	var final_input = _matrix_multiply(w_hidden_output, hidden_output)
	final_input = _matrix_sum(final_input, b_output)
	var final_output = apply_activation(final_input)
	
	return final_output
	
func apply_activation(input: Array) -> Array:
	var output = []
	for row in input:
		var row_output = []
		for value in row:
			row_output.append(1.0 / (1.0 + exp(-value)))
		output.append(row_output)
	return output
# Sumar matrices
func _matrix_sum(a: Array, b: Array) -> Array:
	print("Sumando matrices:")
	print("a (multiplicación): ", a)
	print("b (sesgos): ", b)
	
	if a.size() != b.size():
		print("Las matrices tienen tamanos distintos")
		return []
		
	var _matrix = []
	for i in range(a.size()):
		var _row = []
		for j in range(a[i].size()):
			_row.append(a[i][j] + b[i][j])
		_matrix.append(_row)
	return _matrix

# Multiplicación de matrices
func _matrix_multiply(a: Array, b: Array) -> Array:
	print("multiplicando las matrices")
	print("a (pesos): ", a)
	print("b (entradas): ", b)
	
	var result = []
	# Producto punto entre vectores
	if a.size() == 1 and b.size() == 1:
		var total = 0.0
		for i in range(a[0].size()):
			total += a[0][i] * b[i][0]
		result.append([total])
		print("Resultado del producto punto: ", [[total]])
	return result
	# Multiplicación de matrices generales
	for i in range(a.size()):
		var row = []
		for j in range(b[0].size()):
			var sum = 0.0
			for k in range(a[i].size()):
				sum += a[i][k] * b[k][j]
			row.append(sum)
		result.append(row)
	print("Resultado de la multiplicación de matrices: ", result)
	return result
