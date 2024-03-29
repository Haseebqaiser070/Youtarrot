import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerHandler extends BaseAudioHandler with SeekHandler {
  List<String> musicNames = [
    "AMAZING FUTURE",
    "ECHOES OF IRELAND",
    "EURYNOME",
    "IN THE MEMORY",
    "OCEANS OF SAND",
    "RETURNING HOME",
    "VULCAN",
    "YOU",
  ];
  List<String> musicUrls = [
    "https://firebasestorage.googleapis.com/v0/b/cardapp-96d5d.appspot.com/o/Music%2FAmazing_Future.mp3?alt=media&token=e49a98bc-649c-43be-9236-96f93218b67f",
    "https://firebasestorage.googleapis.com/v0/b/cardapp-96d5d.appspot.com/o/Music%2FEchoes_of_Ireland.mp3?alt=media&token=7d7c5979-969a-4b32-b4b5-6212051c59dc",
    "https://firebasestorage.googleapis.com/v0/b/cardapp-96d5d.appspot.com/o/Music%2FEurynome.mp3?alt=media&token=d276f254-2751-4541-b8eb-5ade31265706",
    "https://firebasestorage.googleapis.com/v0/b/cardapp-96d5d.appspot.com/o/Music%2FIn_the_Memory.mp3?alt=media&token=03ca0814-d3be-4835-9998-608f272bf494",
    "https://firebasestorage.googleapis.com/v0/b/cardapp-96d5d.appspot.com/o/Music%2FOceans_of_Sand.mp3?alt=media&token=1b0a2dab-d196-4532-b4f4-e426702df08a",
    "https://firebasestorage.googleapis.com/v0/b/cardapp-96d5d.appspot.com/o/Music%2FReturning_Home.mp3?alt=media&token=8a524535-1a0d-4d32-be32-ffe979298849",
    "https://firebasestorage.googleapis.com/v0/b/cardapp-96d5d.appspot.com/o/Music%2FVulcan.mp3?alt=media&token=9f5097a4-ceb6-4ab6-9d5d-b0e4aa3aa26a",
    "https://firebasestorage.googleapis.com/v0/b/cardapp-96d5d.appspot.com/o/Music%2FYou.mp3?alt=media&token=a607b71c-5887-4ab3-866f-5275b6972768",
  ];

  final _player = AudioPlayer()..setLoopMode(LoopMode.all);

  get playlist => ConcatenatingAudioSource(
        children: List.generate(
          musicUrls.length,
          (index) {
            return AudioSource.uri(
              Uri.parse(musicUrls[index]),
            );
          },
        ),
      );

  AudioPlayerHandler() {
    _player.playbackEventStream.map(_transformEvent).pipe(playbackState);
    mediaItem.add(
      const MediaItem(id: "", title: "You Tarot Music"),
    );
    _player.setAudioSource(playlist);
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> stop() => _player.stop();
  @override
  Future<void> skipToNext() {
    _player.seekToNext();
    return super.skipToNext();
  }

  @override
  Future<void> skipToPrevious() {
    _player.seekToPrevious();
    return super.skipToPrevious();
  }

  PlaybackState _transformEvent(PlaybackEvent event) {
    return PlaybackState(
      controls: [
        if (_player.playing && _player.playerState.processingState == ProcessingState.ready) MediaControl.pause else MediaControl.play,
        MediaControl.stop,
      ],
      systemActions: const {
        MediaAction.seek,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      },
      androidCompactActionIndices: const [0, 1, 3],
      processingState: const {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[_player.processingState]!,
      playing: _player.playing,
      updatePosition: _player.position,
      bufferedPosition: _player.bufferedPosition,
      speed: _player.speed,
      queueIndex: event.currentIndex,
    );
  }
}
