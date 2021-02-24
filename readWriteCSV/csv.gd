extends Control

var doc = "res://readWriteCSV/test.csv"

var documento

func _ready():
	documento = _leer()

func _escribir():
	
	var file = File.new()
	
	file.open(doc, 2)
	
	if documento.size() == null:
		var titulos = ["nombre", "edad"]
		file.store_csv_line(titulos, ";")
	else:
		for i in documento.size():
			var datos = documento[i]
			file.store_csv_line(datos, ";")
	
	var nombre = $LineEdit.text
	var edad = $LineEdit2.text
	
	var datos = [nombre, edad]
	file.store_csv_line(datos, ";")
	
	file.close()

func _leer():
	
	var file = File.new()
	
	file.open(doc, 1)
	
	var contenido = file.get_as_text()
	
	$RichTextLabel.text = contenido
	
	contenido = contenido.split("\n")
	
	contenido = Array(contenido)
	
	contenido.erase("")
	
	var datos = []
	
	for dato in contenido:
		dato = dato.split(";")
		dato = Array(dato)
		dato.erase("")
		datos.append(dato)
	
	
	file.close()
	
	return datos

func _on_Button_pressed():
	_escribir()
	get_tree().reload_current_scene()
