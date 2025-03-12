extends RichTextLabel

const TIME_BETWEEN_SCROLL = 0.02

var time_elapsed_since_last_scroll = 0

func _ready():
	visible_characters = 0

func _process(delta):
	# setting to -1 will display entire line
	if visible_characters != -1:
		time_elapsed_since_last_scroll += delta
		
		while time_elapsed_since_last_scroll > TIME_BETWEEN_SCROLL:
			time_elapsed_since_last_scroll -= TIME_BETWEEN_SCROLL
			visible_characters += 1
		
		if visible_ratio >= 0.99:
			visible_characters = -1 # stop scrolling

func scroll_text(text):
	self.text = text
	visible_characters = 0
