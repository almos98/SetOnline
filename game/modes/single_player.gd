extends Control

onready var matched := 0;

func _on_Board_matched():
	matched += 1;
	$ScoreLabel.text = str(matched);
