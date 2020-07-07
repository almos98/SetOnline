extends Area2D;

export (NodePath) var data;

onready var registered_components: Array;
onready var data_object;

func _ready():
	assert(!data.is_empty(), 
		"[ERROR]: Card data is not set.");
	
	data_object = get_node(data);
	
	data_object.connect("attribute_changed", self, "update_card");
	data_object.connect("activated", self, "set_visible", [true]);
	data_object.connect("deactivated", self, "set_visible", [false]);
	data_object.connect("selected", self, "set_selection", [true]);
	data_object.connect("deselected", self, "set_selection", [false]);
	
	update_card();

func update_card() -> void:
	for c in registered_components:
		c.queue_free();
	registered_components.clear();
	
	var component_shape: Sprite;
	var component_shape_cover: Sprite;
	var component_texture: Sprite;
	
	match data_object.shape:
		Enum.CardShape.Capsule:
			component_shape = $Resources/Shape/CapsuleOutline;
			component_shape_cover = $Resources/Shape/CapsuleCover;
		Enum.CardShape.Diamond:
			component_shape = $Resources/Shape/DiamondOutline;
			component_shape_cover = $Resources/Shape/DiamondCover;
		Enum.CardShape.Rectangle:
			component_shape = $Resources/Shape/RectangleOutline;
			component_shape_cover = $Resources/Shape/RectangleCover;
	component_shape = component_shape.duplicate()
	component_shape_cover = component_shape_cover.duplicate()
	
	match data_object.texture:
		Enum.CardTexture.Diagonal:
			component_texture = $Resources/Texture/Diagonal
		Enum.CardTexture.Fill:
			component_texture = $Resources/Texture/Fill
		Enum.CardTexture.Outline:
			component_texture = $Resources/Texture/Outline
	component_texture = component_texture.duplicate()
	
	var component_color: Color
	match data_object.color:
		Enum.CardColor.Green:
			component_color = Color("#63c74d")
		Enum.CardColor.Orange:
			component_color = Color("#f77622")
		Enum.CardColor.Pink:
			component_color = Color("#b55088")
	component_shape.modulate = component_color
	component_texture.modulate = component_color
	
	match data_object.number:
		Enum.CardNumber.One:
			move_shape(
				[component_shape, component_shape_cover, component_texture],
				$OneShape/Position0.position
			)
		Enum.CardNumber.Two:
			move_shape(
				[component_shape, component_shape_cover, component_texture], 
				$TwoShape/Position0.position
			)
			move_shape(
				[component_shape, component_shape_cover, component_texture],
				$TwoShape/Position1.position,
				true
			)
		Enum.CardNumber.Three:
			move_shape(
				[component_shape, component_shape_cover, component_texture], 
				$ThreeShape/Position0.position
			)
			move_shape(
				[component_shape, component_shape_cover, component_texture],
				$ThreeShape/Position1.position,
				true
			)
			move_shape(
				[component_shape, component_shape_cover, component_texture],
				$ThreeShape/Position2.position,
				true
			)
	
	register_components([component_shape, component_shape_cover, component_texture]);
	call_deferred("add_child", component_shape);
	call_deferred("add_child", component_shape_cover);
	call_deferred("add_child", component_texture);

func move_shape(components: Array, position: Vector2, copy: bool = false) -> void:
	for c in components:
		if !copy:
			c.position = position;
			continue;
		var new_c = c.duplicate();
		add_child(new_c);
		new_c.position = position;
		register_components([new_c]);

func register_components(components: Array) -> void:
	for component in components:
		registered_components.push_back(component);

func set_visible(new: bool) -> void:
	self.visible = new;

func set_selection(new: bool) -> void:
	$Outline.visible = new;

func _input_event(_viewport: Object, event: InputEvent, shape_idx: int):
	if event.is_action_pressed("ui_select"):
		data_object.toggle_selection();
