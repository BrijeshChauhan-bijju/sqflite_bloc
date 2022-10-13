abstract class ProductEvent {}

class GetProductEvent extends ProductEvent {
  int? page;

  GetProductEvent({
    this.page,
  });
}
