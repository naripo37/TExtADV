extends Control

const InputRisponse = preload("res://input_response.tscn") as PackedScene
const Respons = preload("res://scense/response.tscn") as PackedScene

@export var max_lines_remembered := 30

@onready var history_rows: VBoxContainer = $Background/MarginContainer/Rows/GameInfo/MarginContainer/Scroll/HistoryRows
@onready var scroll: ScrollContainer = $Background/MarginContainer/Rows/GameInfo/MarginContainer/Scroll
@onready var scroll_bar = scroll.get_v_scroll_bar()
@onready var command_processor: Node = $CommandProcessor
@onready var room_manager: Node = $RoomManager

var max_scroll_lenght:=0



func _ready() -> void:
	scroll_bar.connect("changed" , Callable(self, "handle_scrollbar_changed"))
	max_scroll_lenght = scroll_bar.max_value
	var starting_message = Respons.instantiate()
	starting_message.text = " you wakeup to find your self in a crumbiling house with no memoreis how you get in there "
	add_response_to_game(starting_message)
	command_processor.initialize(room_manager.get_child(0))


func handle_scrollbar_changed():
	if max_scroll_lenght != scroll_bar.max_value:
		max_scroll_lenght = scroll_bar.max_value
		scroll.scroll_vertical = scroll_bar.max_value


func _on_input_text_submitted(new_text: String) -> void:
	if new_text.is_empty():
		return
	
	var input_response = InputRisponse.instantiate()
	var response = command_processor.process_command(new_text)
	input_response.set_text(new_text,response)
	add_response_to_game(input_response)


func add_response_to_game(response: Control):
	history_rows.add_child(response)
	delete_history_beyond_limite()


func delete_history_beyond_limite():
	if history_rows.get_child_count() > max_lines_remembered:
		var lines_to_forget = history_rows.get_child_count() - max_lines_remembered
		for i in range(lines_to_forget):
			history_rows.get_child(i).queue_free()
	
	
	
	
	
