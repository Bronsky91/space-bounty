extends Node

onready var character = get_parent()

onready var animation_player = character.get_node("AnimationPlayer")

onready var player_sprite: Dictionary = {
	'Body': character.get_node("Body"),
	'Bottom': character.get_node("Bottom"),
	'Eyes': character.get_node("Eyes"),
	'HairA': character.get_node("HairA"),
	'HairB': character.get_node("HairB"),
	'Head': character.get_node("Head"),
	'Top': character.get_node("Top"),
	'Eyebrow': character.get_node("Eyebrow")
}

onready var palette_sprite_dict: Dictionary = {
	'Bottom': [
		player_sprite['Bottom']
	],
	'Eye': [player_sprite['Eyes']],
	'Hair': [
		player_sprite['HairA'],
		player_sprite['HairB'],
		player_sprite['Eyebrow']
	],
	'Skintone': [
		player_sprite['Body'],
		player_sprite['Head']
	],
	'Top': [
		player_sprite['Top'],
	],
}

var pallete_sprite_state: Dictionary
var sprite_state: Dictionary

var player_name: String
var race: String = "Human" # Temp hardcoded
var gender: String = "Female" # Temp hardcoded

var current_animation = 0

func _ready():
	create_random_character()
	make_character_shaders_unique()

func _process(delta):
	pass
	
func make_character_shaders_unique():
	for sprite in player_sprite:
		var mat = player_sprite[sprite].get_material().duplicate()
		player_sprite[sprite].set_material(mat)

func set_sprite_texture(sprite_name: String, texture_path: String) -> void:
	player_sprite[sprite_name].set_texture(load(texture_path))
	sprite_state[sprite_name] = texture_path
	
func set_sprite_color(folder, sprite: Sprite, number: String) -> void:
	var palette_path = "res://Assets/Palettes/{folder}/{folder}color_{number}.png".format({
		"folder": folder,
		"number": number
	})
	var gray_palette_path = "res://Assets/Palettes/{folder}/{folder}color_000.png".format({
		"folder": folder
	})
	sprite.material.set_shader_param("palette_swap", load(palette_path))
	sprite.material.set_shader_param("greyscale_palette", load(gray_palette_path))
	pallete_sprite_state[folder] = number
	
func random_asset(folder: String, keyword: String = "") -> String:
	var files: Array
	files = g.files_in_dir(folder, keyword)
	if keyword == "":
		files = g.files_in_dir(folder)
	if len(files) == 0:
		return ""
	randomize()
	var random_index = randi() % len(files)
	return folder+"/"+files[random_index]
	
func create_random_character() -> void:
	var sprite_folder_path = "res://Assets/{race}/{gender}".format({"race": race, "gender": gender})
	var palette_folder_path = "res://Assets/Palettes"
	var sprite_folders = g.files_in_dir(sprite_folder_path)
	var palette_folders = g.files_in_dir(palette_folder_path)
	for folder in sprite_folders:
		var random_sprite = random_asset(sprite_folder_path+"/"+folder, "Idle")
		if random_sprite == "": # No assets in the folder yet continue to next folder
			continue
		if "000" in random_sprite: # Prevent some empty sprite sheets
			if folder == "HairA" and "Hair" in random_sprite: # If main hair is bald, leave rest of hair
				continue
			if "Top" in folder or "Bottom" in folder: # If no top or no bottom was returned, dont set the texture
				continue
		#player_sprite[folder].set_texture(load(random_sprite))
		set_sprite_texture(folder, random_sprite)
	for folder in palette_folders:
		var random_color = random_asset(palette_folder_path+"/"+folder)
		
		if random_color == "" or "000" in random_color:
			random_color = random_color.replace("000", "001")
		for sprite in palette_sprite_dict[folder]:
			set_sprite_color(folder, sprite, random_color.substr(len(random_color)-7, 3))
