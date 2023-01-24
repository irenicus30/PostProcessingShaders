extends OptionButton


export(NodePath) onready var shader_node = get_node(shader_node)
export(NodePath) onready var pulse_source = get_node(pulse_source) as Spatial

var pulse_button = null

var distance = 0.0
var is_running = false

export(float) var max_distance = 20.0
export(float) var speed = 2.0

var shader_material = null


func _ready():
	self.add_item("other", 0)
	self.add_item("depth", 1)
	call_deferred("_on_OptionButton_item_selected", 0)


func _process(delta):
	
	if is_running:
		distance += delta * speed
		if distance > max_distance:
			is_running = false
			distance = 0.0
		shader_material.set_shader_param("radius", distance)


func _on_OptionButton_item_selected(index):
	if index == 0:
		pulse_button = Button.new()
		pulse_button.text = "generate pulse"
		get_parent().add_child(pulse_button)
		pulse_button.connect("button_down", self, "generate_pulse")
		
		shader_material = shader_node.get_surface_material(0) as ShaderMaterial
		shader_material.shader = load("res://scanner_pulse.gdshader")
	else:
		if pulse_button:
			pulse_button.queue_free()
			pulse_button = null
		
		shader_material = shader_node.get_surface_material(0) as ShaderMaterial
		shader_material.shader = load("res://depth_visualizer.gdshader")


func generate_pulse():
	print("lol")
	if shader_material:
		shader_material.set_shader_param("start_point", pulse_source.get_global_transform().origin)
		is_running = true
		distance = 0.0
