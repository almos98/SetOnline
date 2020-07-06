extends Control;

export (Array, NodePath) var buttons_path;
export (Array, PackedScene) var scene_transitions;
export (NodePath) var back_button_path;

func _ready() -> void:
	connect("gui_input", self, "_input");
	
	assert(scene_transitions.size() == buttons_path.size(),
		"[ERROR] Mismatched buttons and transition scenes.");
	
	for i in buttons_path.size():
		if buttons_path[i] == null or scene_transitions[i] == null:
			continue;
		
		var button: BaseButton = get_node(buttons_path[i]);
		button.connect("pressed", self, "button_pressed", [i]);
	
	if !back_button_path.is_empty():
		get_node(back_button_path).connect("pressed", self, "back");

func button_pressed(t: int) -> void:
	StateManager.change_scene_to(scene_transitions[t]);

func back() -> void:
	StateManager.previous_scene();

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		back();
