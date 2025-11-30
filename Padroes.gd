extends Node2D

# Texturas para os padrões
var textura_listras = preload("res://listras.png")
var textura_pontos = preload("res://pontos.png")

# Configurações de tiles
var tiles_configs = [
	Vector2(1, 1),   # Config 0: 1x1
	Vector2(2, 2),   # Config 1: 2x2  
	Vector2(4, 4),   # Config 2: 4x4
	Vector2(8, 8),   # Config 3: 8x8
	Vector2(2, 4),   # Config 4: 2x4
	Vector2(4, 2)    # Config 5: 4x2
]
var config_atual = 0

func _ready():
	# Configurar polígono inicial
	$Polygon2D.polygon = PoolVector2Array([
		Vector2(0, -150),
		Vector2(150, 150), 
		Vector2(-150, 150)
	])
	
	# Aplicar textura inicial
	trocar_textura(textura_listras)
	atualizar_tiles()

func _input(event):
	if event is InputEventKey and event.pressed:
		match event.keycode:
			KEY_1:
				# Tecla 1 - Textura de listras
				trocar_textura(textura_listras)
				print("Textura: Listras")
			KEY_2:
				# Tecla 2 - Textura de pontos  
				trocar_textura(textura_pontos)
				print("Textura: Pontos")
			KEY_3:
				# Tecla 3 - Próxima configuração de tiles
				config_atual = (config_atual + 1) % tiles_configs.size()
				atualizar_tiles()
				print("Tiles: ", tiles_configs[config_atual])
			KEY_4:
				# Tecla 4 - Configuração anterior de tiles
				config_atual = (config_atual - 1) % tiles_configs.size()
				atualizar_tiles()
				print("Tiles: ", tiles_configs[config_atual])

func trocar_textura(nova_textura):
	$Polygon2D.texture = nova_textura
	# Garantir que a repetição está ativada
	$Polygon2D.texture_repeat = CanvasItem.TEXTURE_REPEAT_ENABLED

func atualizar_tiles():
	var tiles = tiles_configs[config_atual]
	$Polygon2D.texture_scale = Vector2(1.0 / tiles.x, 1.0 / tiles.y)

# Função para criar texturas programaticamente (fallback se não tiver imagens)
func criar_texturas_fallback():
	# Esta função pode ser chamada se você não tiver as imagens
	# Ela cria texturas simples programaticamente
	pass
