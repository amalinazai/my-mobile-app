import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:stream_transform/stream_transform.dart';

/// Helper class for BLoC Event Transformers.
/// To use, extend a BLoC class with [BlocTransformer].
mixin BlocTransformer {
  /// Process only one event and ignore (drop)
  /// any new events until the current event is done.
  EventTransformer<E> customDroppable<E>([
    Duration duration = const Duration(milliseconds: 500),
  ]) {
    return (events, mapper) {
      return droppable<E>().call(events.throttle(duration), mapper);
    };
  }

  /// Process only one event by cancelling any pending
  /// events and processing the new event immediately.
  EventTransformer<E> customRestartable<E>([
    Duration duration = const Duration(milliseconds: 500),
  ]) {
    return (events, mapper) {
      return restartable<E>().call(events.debounce(duration), mapper);
    };
  }
}
