import '../models/product_model.dart';

class OrderProductDto {
  final ProductModel product;
  final int amout;

  OrderProductDto({
    required this.product,
    required this.amout,
  });

  double get totalPrice => amout * product.price;

  OrderProductDto copyWith({
    ProductModel? product,
    int? amout,
  }) {
    return OrderProductDto(
      product: product ?? this.product,
      amout: amout ?? this.amout,
    );
  }
}
