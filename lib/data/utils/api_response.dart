class ApiResponse<T extends Object> {
  final bool hasError;
  final T? data;
  final String? message;

  ApiResponse({
    required this.data,
    required this.hasError,
    required this.message,
  });
}
