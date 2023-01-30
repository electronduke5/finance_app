abstract class ApiStatus<T extends Object> {
  //final List<T>? items;
  final T? item;
  final String? message;

  const ApiStatus({this.item, this.message});
}

class IdleStatus<T extends Object> extends ApiStatus<T> {
  const IdleStatus();
}

class LoadingStatus<T extends Object> extends ApiStatus<T> {
  LoadingStatus();
}

class LoadedStatus<T extends Object> extends ApiStatus<T> {
  LoadedStatus(T? item) : super(item: item);
}

class FailedStatus<T extends Object> extends ApiStatus<T> {
  FailedStatus(String? message) : super(message: message);
}
