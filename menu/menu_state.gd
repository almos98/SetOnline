extends Control;

export (Array, NodePath) var buttons_path;
export (Array, PackedScene) var scene_transitions;
export (NodePath) var back_button_path;

func _ready() -> void:
	Menu.register(self);
