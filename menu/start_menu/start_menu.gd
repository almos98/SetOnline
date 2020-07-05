extends MarginContainer;

export (NodePath) var buttons_container_path;
export (Array, PackedScene) var transition_scenes;

func _ready() -> void:
	assert(!buttons_container_path.is_empty(),
		"ERROR: Buttons container path not set.");

	var buttons := get_node(buttons_container_path).get_children();
	
	assert(transition_scenes.size() == buttons.size(),
		"ERROR: Mismatched buttons and transition scenes");

	for i in buttons.size():
		assert(buttons[i].is_class("BaseButton"),
			"ERROR: Button container contains non-button member.")
	
		if transition_scenes[i] == null:
			continue;
		
		buttons[i].connect("pressed", self, "button_pressed", [i]);

func button_pressed(id: int) -> void:
	assert(get_tree().change_scene_to(transition_scenes[id]),
		"ERROR: Failed to transition to next scene.");
