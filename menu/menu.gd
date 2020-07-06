extends Control;

var states: Array;

func register(menu: Control) -> void:
	assert(!menu.buttons_container_path.is_empty(),
		"ERROR: Buttons container path not set.");
	
	var buttons := menu.get_node(menu.buttons_container_path).get_children();
	
	assert(menu.scene_transitions.size() == buttons.size(),
		"ERROR: Mismatched buttons and transition scenes.");
	
	for i in buttons.size():
		assert(buttons[i].is_class("BaseButton"),
			"ERROR: Button container contains non-button member.");
		
		if menu.scene_transitions[i] == null:
			continue;
		
		buttons[i].connect("pressed", self, "change_scene", [menu, i]);
	
	if !menu.back_button_path.is_empty():
		menu.get_node(menu.back_button_path).connect("pressed", self, "back");

func change_scene(menu: Control, t: int) -> void:
	states.push_back(get_tree().current_scene.filename);
	
	assert(get_tree().change_scene_to(menu.scene_transitions[t]) == OK,
		"ERROR: Failed to transition to next scene.");

func back() -> void:
	get_tree().change_scene(states.pop_back());
