extends Control

@onready var display_text: Label = $Background/AllComponentsContainer/DisplayMargins/DisplayArea/TextMargins/DisplayText
@onready var all_buttons: GridContainer = $Background/AllComponentsContainer/ButtonMargins/AllButtons

#set the 6-digit password here
var set_password := "123456"
var user_input := ""
var has_been_used := false
var input_length := 0

func _ready():
	for button in all_buttons.get_children():
		if button.name.is_valid_int():
			button.pressed.connect(Callable(self, "_number_buttons").bind(button))

func _number_buttons(button):
	if not has_been_used:
		user_input = button.name
		display_text.text = "*"
		input_length += 1
		has_been_used = true
	else:
		if input_length < 6:
			user_input += button.name
			display_text.text += "*"
			input_length += 1
		
func _on_clr_pressed() -> void:
	get_tree().reload_current_scene()


func _on_ok_pressed() -> void:
	if input_length == 6:
		if user_input == set_password:
			display_text.text = "CODE OK"
		else:
			display_text.text = "ERROR"
	else:
		display_text.text = "ERROR"
	# Wait 3 seconds, then continue
	await get_tree().create_timer(3.0).timeout
	get_tree().reload_current_scene()


		
