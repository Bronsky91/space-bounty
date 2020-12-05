extends Node

var credits_label: Label
var gold_label: Label

var credits: int
var gold: int

var credits_text: String = "Credits: %s"
var gold_text: String = "Gold: %s"

signal credits_changed
signal gold_changed

func _ready():
	pass

func add_credits(num: int) -> int:
	credits += num
	credits_label.text = credits_text % credits
	emit_signal("credits_changed", credits)
	return credits
	
func subtract_credits(num: int) -> int:
	credits -= num
	credits_label.text = credits_text % credits
	emit_signal("credits_changed", credits)
	return credits
	
func add_gold(num: int) -> int:
	gold += num
	gold_label.text = gold_text % gold
	emit_signal("gold_changed", gold)
	return gold
	
func subtract_gold(num: int) -> int:
	gold -= num
	gold_label.text = gold_text % gold
	emit_signal("gold_changed", gold)
	return gold
