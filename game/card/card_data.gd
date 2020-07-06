extends Node

signal selected(card);
signal attribute_changed(attrib_name, new_value);

export(Enum.CardColor) 		var color 	:= Enum.CardColor.Green			setget set_color;
export(Enum.CardNumber) 	var number 	:= Enum.CardNumber.One			setget set_number;
export(Enum.CardShape) 		var shape 	:= Enum.CardShape.Capsule		setget set_shape;
export(Enum.CardTexture) 	var texture	:= Enum.CardTexture.Diagonal	setget set_texture;

export(bool) var selected := false setget set_selection;

# Validate the color value and emit attribute_changed signal.
func set_color(new: int) -> void:
	new = clamp(new, 0, Enum.CardColor.size());
	if new != color:
		emit_signal("attribute_changed", "color", new);
	color = new


# Validate the number value and emit attribute_changed signal.
func set_number(new: int) -> void:
	new = clamp(new, 0, Enum.CardNumber.size());
	if new != number:
		emit_signal("attribute_changed", "number", new);
	number = new;

# Validate the shape value and emit attribute_changed signal.
func set_shape(new: int) -> void:
	new = clamp(new, 0, Enum.CardShape.size());
	if new != shape:
		emit_signal("attribute_changed", "shape", new);
	shape = new;

# Validate the texture value and emit attribute_changed signal.
func set_texture(new: int) -> void:
	new = clamp(new, 0, Enum.CardTexture.size());
	if new != texture:
		emit_signal("attribute_changed", "texture", new);
	texture = new;

# Convenience function to set attributes of card_data.
# Example: card_data.set_attributes([
#			Enum.CardColor.Pink,
#			Enum.CardNumber.Three,
#			Enum.CardShape.Rectangle,
#			Enum.CardTexture.Outline
#		]);
func set_attributes(attributes: Array) -> void:
	set_color(attributes[0]);
	set_number(attributes[1]);
	set_shape(attributes[2]);
	set_texture(attributes[3]);

# Set selection and emit selected signal.
func set_selection(new: bool) -> void:
	if selected == new:
		return
	
	selected = new;
	emit_signal("selected", self);

func toggle_selection() -> void:
	set_selection(!selected);
