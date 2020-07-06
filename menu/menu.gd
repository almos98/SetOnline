extends Control;

var states: Array;

func _ready():
	self.connect("gui_input", self, "_input");

func register(menu: Control) -> void:
	assert(menu.scene_transitions.size() == menu.buttons_path.size(),
		"[ERROR] Mismatched buttons and transition scenes.");
	
	for i in menu.buttons_path.size():
		if !menu.has_node(menu.buttons_path[i]) or menu.scene_transitions[i] == null:
			continue;
		
		var button: BaseButton = menu.get_node(menu.buttons_path[i]);
		button.connect("pressed", self, "change_scene", [menu, i]);
	
	if !menu.back_button_path.is_empty():
		menu.get_node(menu.back_button_path).connect("pressed", self, "back");

func change_scene(menu: Control, t: int) -> void:
	states.push_back(get_tree().current_scene.filename);
	
	get_tree().change_scene_to(menu.scene_transitions[t]) == OK

func back() -> void:
	if states.empty():
		return;
	
	get_tree().change_scene(states.pop_back());

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		back();
