extends Control


var current_button : Button


@onready var w : Button = $"ColorRect/Panel/ScrollContainer/PanelContainer/MarginContainer/TabContainer/Key Bindings/wPanel/w"
@onready var s : Button = $"ColorRect/Panel/ScrollContainer/PanelContainer/MarginContainer/TabContainer/Key Bindings/sPanel/s"
@onready var a : Button = $"ColorRect/Panel/ScrollContainer/PanelContainer/MarginContainer/TabContainer/Key Bindings/aPanel/a"
@onready var d : Button = $"ColorRect/Panel/ScrollContainer/PanelContainer/MarginContainer/TabContainer/Key Bindings/dPanel/d"
@onready var click : Button = $"ColorRect/Panel/ScrollContainer/PanelContainer/MarginContainer/TabContainer/Key Bindings/clickPanel/click"

@onready var mouse_slider = $"ColorRect/Panel/ScrollContainer/PanelContainer/MarginContainer/TabContainer/Options\u200e/InputPanel/SensLabel/SensSlider"
@onready var viewport_rid = get_tree().get_root().get_viewport_rid()


func _ready():
	w.pressed.connect(_on_button_pressed.bind(w))
	s.pressed.connect(_on_button_pressed.bind(s))
	a.pressed.connect(_on_button_pressed.bind(a))
	d.pressed.connect(_on_button_pressed.bind(d))
	click.pressed.connect(_on_button_pressed.bind(click))

	_update_labels()


func _on_window_mode_item_selected(index):
	match index:
		0: #Fullscreen
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		1: #Windowed
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)


func _on_resolution_item_selected(index):
	match index:
		0:
			get_window().set_size(Vector2(1280,720))
		1:
			get_window().set_size(Vector2(1920,1080))
		2:
			get_window().set_size(Vector2(2560,1440))
		3:
			get_window().set_size(Vector2(3840,2160))


func _on_frame_rate_cap_item_selected(index):
	match index:
		0:
			Engine.max_fps = 30;
		1:
			Engine.max_fps = 60;
		2:
			Engine.max_fps = 144;
		3:
			Engine.max_fps = 240;
		4:
			Engine.max_fps = 0;


func _on_shadow_btn_item_selected(index):
	Global.light.directional_shadow_mode = index


func _on_msaa_item_selected(index):
	match index:
		0:
			RenderingServer.viewport_set_msaa_3d(viewport_rid, RenderingServer.VIEWPORT_MSAA_DISABLED)
		1:
			RenderingServer.viewport_set_msaa_3d(viewport_rid, RenderingServer.VIEWPORT_MSAA_2X)
		2:
			RenderingServer.viewport_set_msaa_3d(viewport_rid, RenderingServer.VIEWPORT_MSAA_4X)
		3:
			RenderingServer.viewport_set_msaa_3d(viewport_rid, RenderingServer.VIEWPORT_MSAA_8X)


func _on_vsync_item_selected(index):
	match index:
		0:
			DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		1:
			DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_ENABLED)


func _on_fxaa_item_selected(index):
	match index:
		0:
			get_viewport().screen_space_aa = Viewport.SCREEN_SPACE_AA_DISABLED
		1:
			get_viewport().screen_space_aa = Viewport.SCREEN_SPACE_AA_FXAA


func _on_button_pressed(button: Button) -> void:
	current_button = button # assign clicked button to current_button


func _input(event: InputEvent) -> void:
	if !current_button: # return if no current_button is null
		return
		
	if event is InputEventKey || event is InputEventMouseButton:
		
		# This part is for deleting duplicate assignments:
		# Add all assigned keys to a dictionary
		var all_ies : Dictionary = {}
		for ia in InputMap.get_actions():
			for iae in InputMap.action_get_events(ia):
				all_ies[iae.as_text()] = ia
		
		# check if the new key is already in the dict.
		# If yes, delete the old one.
		if all_ies.keys().has(event.as_text()):
			InputMap.action_erase_events(all_ies[event.as_text()])
		
		# Erase the event in the Input map
		InputMap.action_erase_events(current_button.name)
		# And assign the new event to it
		InputMap.action_add_event(current_button.name, event)
		
		# After a key is assigned, set current_button back to null
		current_button = null

		_update_labels() # refresh the labels


func _update_labels() -> void:
	# This is just a quick way to update the labels:
	var eb1 : Array[InputEvent] = InputMap.action_get_events("w")
	if !eb1.is_empty():
		w.text = eb1[0].as_text()
	else:
		w.text = ""
		
	var eb2 : Array[InputEvent] = InputMap.action_get_events("s")
	if !eb2.is_empty():
		s.text = eb2[0].as_text()
	else:
		s.text = ""
		
	var eb3 : Array[InputEvent] = InputMap.action_get_events("a")
	if !eb3.is_empty():
		a.text = eb3[0].as_text()
	else:
		a.text = ""
		
	var eb4 : Array[InputEvent] = InputMap.action_get_events("d")
	if !eb4.is_empty():
		d.text = eb4[0].as_text()
	else:
		d.text = ""
		
	var eb5 : Array[InputEvent] = InputMap.action_get_events("click")
	if !eb5.is_empty():
		click.text = eb5[0].as_text()
	else:
		click.text = ""

func _on_shadows_item_selected(index):
	match index:
		0:
			Global.light.shadow_enabled = false
		1:
			Global.light.shadow_enabled = true


func _on_glow_item_selected(index):
	match index:
		0:
			Global.world_environment.environment.glow_enabled = false
		1:
			Global.world_environment.environment.glow_enabled = true


func _on_glow_3_item_selected(index):
	match index:
		0:
			Global.world_environment.environment.ssr_enabled = false
		1:
			Global.world_environment.environment.ssr_enabled = true


func _on_ssao_item_selected(index):
	match index:
		0:
			Global.world_environment.environment.ssao_enabled = false
		1:
			Global.world_environment.environment.ssao_enabled = true


func _on_ssil_item_selected(index):
	match index:
		0:
			Global.world_environment.environment.ssil_enabled = false
		1:
			Global.world_environment.environment.ssil_enabled = true


func _on_sdfgi_item_selected(index):
	match index:
		0:
			Global.world_environment.environment.sdfgi_enabled = false
		1:
			Global.world_environment.environment.sdfgi_enabled = true


func _on_sens_slider_value_changed(value):
	Global.mouse_sens = value