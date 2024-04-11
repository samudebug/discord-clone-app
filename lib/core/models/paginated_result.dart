class PaginatedResult<T> {
  int total;
  List<T> results;
  int page;

  PaginatedResult({required this.total, required this.results, required this.page});
}