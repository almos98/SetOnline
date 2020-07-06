extends Node;

const FLAG_CLEAR_STACK = 1;
const FLAG_IGNORE_STACK = 2;

var state_stack: Array;

func manage_stack(flags: int = 0) -> void:
	if flags & FLAG_CLEAR_STACK:
		state_stack.clear();
	
	if flags & FLAG_IGNORE_STACK:
		return;
	
	state_stack.push_back(get_tree().current_scene.filename);

func change_scene(filename: String, flags: int = 0) -> void:
	manage_stack(flags);
	get_tree().change_scene(filename);

func change_scene_to(scene: PackedScene, flags: int = 0) -> void:
	manage_stack(flags);
	get_tree().change_scene_to(scene);

func previous_scene() -> void:
	if state_stack.empty():
		return;
	
	change_scene(state_stack.pop_back(), FLAG_IGNORE_STACK);
