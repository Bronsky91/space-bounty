extends Node

onready var player_sprite: Dictionary = {
	'Body': $Body,
	'Bottom': $Bottom,
	'Eyes': $Eyes,
	'HairA': $HairA,
	'HairB': $HairB,
	'Head': $Head,
	'Top': $TopB,
	'Eyebrow': $Eyebrow
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
	$PlayerSprites/AnimationPlayer.play("idle_front")
	
func _process(delta):
	pass

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

func _on_GenderButton_button_up(_gender):
	gender = _gender
	create_random_character()

func _on_Random_button_up():
	create_random_character()

func _on_Turn_button_up(direction):
	var animations = ['idle_front', 'idle_right', 'idle_back', 'idle_left']
	current_animation += direction
	if current_animation == 4 or current_animation == -4:
		current_animation = 0
	$PlayerSprites/AnimationPlayer.play(animations[current_animation])
	
func _on_Sprite_Selection_button_up(direction: int, sprite: String):
	# TODO: Figure out how to select new a body
	if not sprite == "Body":
		var folder_path = "res://Assets/Character/"+race+"/"+gender+"/"+sprite+"/"
		var files = g.files_in_dir(folder_path, "Idle")
		var file = sprite_state[sprite].split("/")[-1]
		var current_index = files.find(file)
		var new_index = current_index + direction
		if new_index > len(files) - 1:
			new_index = 0
		if new_index == -1:
			new_index = len(files) -1
		var new_sprite_path = folder_path + files[new_index]
		set_sprite_texture(sprite, new_sprite_path)

func _on_Color_Selection_button_up(direction: int, palette_sprite: String):
	var folder_path = "res://Assets/Palettes/"+palette_sprite
	var files = g.files_in_dir(folder_path)
	var new_color = int(pallete_sprite_state[palette_sprite]) + direction
	if new_color == 0 and direction == -1:
		new_color = len(files) - 1
	if new_color == len(files) and direction == 1:
		new_color = 1
	for sprite in palette_sprite_dict[palette_sprite]:
		set_sprite_color(palette_sprite, sprite, str(new_color).pad_zeros(3))


func _on_Save_button_up():
	pass
	# Saves Character state in new slot
