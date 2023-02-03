// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

import 'package:dt_delivery_app/app/models/payment_type_model.dart';

import '../../dto/order_product_dto.dart';

part 'order_state.g.dart';

@match
enum OrderStatus {
  initial,
  loading,
  loaded,
  error,
}

class OrderState extends Equatable {
  final OrderStatus status;
  final List<OrderProductDto> orderProducts;
  final List<PaymentTypeModel> paymentsTypes;
  final String? errorMessage;

  const OrderState({
    required this.status,
    required this.orderProducts,
    required this.paymentsTypes,
    this.errorMessage,
  });

  const OrderState.initial()
      : status = OrderStatus.initial,
        orderProducts = const [],
        paymentsTypes = const [],
        errorMessage = null;

  @override
  List<Object?> get props => [status, orderProducts, paymentsTypes, errorMessage];

  OrderState copyWith({
    OrderStatus? status,
    List<OrderProductDto>? orderProducts,
    List<PaymentTypeModel>? paymentsTypes,
    String? errorMessage,
  }) {
    return OrderState(
      status: status ?? this.status,
      orderProducts: orderProducts ?? this.orderProducts,
      paymentsTypes: paymentsTypes ?? this.paymentsTypes,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
