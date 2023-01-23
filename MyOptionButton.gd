extends OptionButton


export(NodePath) onready var shader_node = get_node(shader_node)

var pulse_button = null

func _ready():
	self.add_item("depth", 1)
	self.add_item("other", 2)


func _on_OptionButton_item_selected(index):
	if index == 1:
		pulse_button = Button.new()
		pulse_button.text = "generate pulse"
		get_parent().add_child(pulse_button)
		pulse_button.connect("button_down", self, "generate_pulse")
	else:
		pulse_button.queue_free()
		pulse_button = null


func generate_pulse():
	print("lol")
	pass
