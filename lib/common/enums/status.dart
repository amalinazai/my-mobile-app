/// The status of a data request.
enum Status {
  /// The initial status before any data has been requested.
  initial,

  /// The status when data is being refreshed.
  refreshing,

  /// The status when data is being loaded for the first time.
  loading,

  /// The status when more data is being loaded.
  loadingMore,

  /// The status when there was an error loading data.
  failure,

  /// The status when data was successfully loaded.
  success,
}
