extends Node2D

export(NodePath) var board_data_path;

func _ready():
	assert(board_data_path != null,
		"[ERROR] Board data path is not set.");
	assert(get_node(board_data_path) != null,
		"[ERROR] Board data path points to invalid node.");
	
	# Get absolute path
	board_data_path = get_node(board_data_path).get_path();
	
	for i in range(12):
		var view := get_node("CardView%d" % i);
		var data := get_node(board_data_path).get_node("Cards/Card%d" % i).get_path();
		
		view.data = data;
		view.initialize();
