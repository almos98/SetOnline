extends Node

signal attribute_changed();
signal selected();
signal deselected();
signal activated();
signal deactivated();


export(Enum.CardColor) 		var color 	:= Enum.CardColor.Green			setget set_color;
export(Enum.CardNumber) 	var number 	:= Enum.CardNumber.One			setget set_number;
export(Enum.CardShape) 		var shape 	:= Enum.CardShape.Capsule		setget set_shape;
export(Enum.CardTexture) 	var texture	:= Enum.CardTexture.Diagonal	setget set_texture;

export(bool) var selected := false setget set_selection;
export(bool) var active := true setget set_active;

# Validate the color value and emit attribute_changed signal.
func set_color(new: int) -> void:
# warning-ignore:narrowing_conversion
	new = clamp(new, 0, Enum.CardColor.size());
	if new != color:
		emit_signal("attribute_changed");
	color = new


# Validate the number value and emit attribute_changed signal.
func set_number(new: int) -> void:
# warning-ignore:narrowing_conversion
	new = clamp(new, 0, Enum.CardNumber.size());
	if new != number:
		emit_signal("attribute_changed");
	number = new;

# Validate the shape value and emit attribute_changed signal.
func set_shape(new: int) -> void:
# warning-ignore:narrowing_conversion
	new = clamp(new, 0, Enum.CardShape.size());
	if new != shape:
		emit_signal("attribute_changed");
	shape = new;

# Validate the texture value and emit attribute_changed signal.
func set_texture(new: int) -> void:
# warning-ignore:narrowing_conversion
	new = clamp(new, 0, Enum.CardTexture.size());
	if new != texture:
		emit_signal("attribute_changed");
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
	if selected:
		emit_signal("selected");
	else:
		emit_signal("deselected");

func toggle_selection() -> void:
	set_selection(!selected);

func set_active(new: bool) -> void:
	if active == new:
		return
	
	active = new;
	if active:
		emit_signal("activated");
	else:
		emit_signal("deactivated");
