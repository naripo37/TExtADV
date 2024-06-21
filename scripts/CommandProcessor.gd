extends Node


# Called when the node enters the scene tree for the first time.
func process_command(input:String) -> String:
	var words = input.split(" ",false)
	if words.size() == 0:
		return "error: now words"
	
	var first_word = words[0].to_lower()
	var second_word = ""
	if words.size() > 1:
		second_word = words[1].to_lower()
	
	match first_word:
		"go":
			return go(second_word)
		"help":
			return help()
		_:
			return "unrecognized command"

func help()->String:
	return "you can use this commands: go [location]"

func go(second_word:String):
	if second_word == "":
		return "Go where"
	
	return "you go %s" % second_word
