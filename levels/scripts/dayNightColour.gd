extends CanvasModulate

const MINUTES_PER_DAY = 1440
const MINUTES_PER_HOUR = 60
#One day cycle equals to (2 * PI)
const INGAME_TO_REAL_MINUTE_DURATION = (2 * PI) / MINUTES_PER_DAY

signal time_tick(day:int, hour:int, minute:int)

@export var gradient: GradientTexture1D
#Real-time second is 1 in-game minute
@export var INGAME_SPEED = 1.0
@export var INITIAL_HOUR = 12:
	set(h):
		INITIAL_HOUR = h
		time = INGAME_TO_REAL_MINUTE_DURATION * INITIAL_HOUR * MINUTES_PER_HOUR

#Time is on a sine wave, night time being 0.0 and day being 1.0
var time: float = 0.0
var past_minute: float = -1.0

func _ready() -> void:
	time = INGAME_TO_REAL_MINUTE_DURATION * INITIAL_HOUR * MINUTES_PER_HOUR

#Time starts at daytime on sine wave
func _process(delta: float) -> void:
	time += delta * INGAME_TO_REAL_MINUTE_DURATION * INGAME_SPEED
	var value = (sin(time - PI / 2.0) + 1.0) / 2.0
	self.color = gradient.gradient.sample(value)
	
	_recalculate_time()
	
func _recalculate_time() -> void:
	#Calculates total in-game mins passed 
	var total_minutes = int(time / INGAME_TO_REAL_MINUTE_DURATION)
	
	#Calculates days, hours and mins
	var day = int(total_minutes / MINUTES_PER_DAY)
	
	var current_day_minutes = total_minutes % MINUTES_PER_DAY
	
	var hour = int(current_day_minutes / MINUTES_PER_HOUR)
	var minute = int(current_day_minutes % MINUTES_PER_HOUR)

	if past_minute != minute:
		past_minute = minute
		time_tick.emit(day, hour, minute)
