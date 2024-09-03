extends AudioStreamPlayer2D
## Efekty dźwiękowe w grze
##
## Moduł odgrywa efekty dźwiękowe w grze. Jest ładowany w opcji 'autoload', przez co jest 
## modułem globalnym, dostępnym z każdej sceny i skryptu w grze.

#region Stałe i zmienne
const SFX_COIN_COLLECTED : AudioStreamWAV = preload("res://assets/audio/sfx/coin.wav") # Zebranie coina
const SFX_PLAYER_JUMP : AudioStreamOggVorbis = preload("res://assets/audio/sfx/jump.ogg") # Skok gracza
const SFX_PLAYER_DEATH : AudioStreamMP3 = preload("res://assets/audio/sfx/death.mp3")
#endregion

## Odegranie wskazanego dźwięku
## 
## Metoda prywatne, która odgrywa wskazany dźwięk o podanej głośności
func _make_player(stream : AudioStream, volume : float) -> void:
	var sfx_player = AudioStreamPlayer.new()
	sfx_player.stream = stream
	sfx_player.name = "sfx_player"
	sfx_player.volume_db = volume
	add_child(sfx_player)
	sfx_player.play()
	await sfx_player.finished
	sfx_player.queue_free()
	

## Dźwięk w momencie podniesienia coina
func coin_collected() -> void:
	_make_player(SFX_COIN_COLLECTED, 0.0)


## Dźwięk w momencie skoku gracza
func player_jump() -> void:
	_make_player(SFX_PLAYER_JUMP, 0.0)


## Dźwięk w momencie śmierci gracza
func player_death() -> void:
	_make_player(SFX_PLAYER_DEATH, 0.0)
