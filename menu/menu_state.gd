extends Control;

export (NodePath) var buttons_container_path;
export (Array, PackedScene) var scene_transitions;
export (NodePath) var back_button_path;

func _ready() -> void:
	Menu.register(self);
