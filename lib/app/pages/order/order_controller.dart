import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dt_delivery_app/app/repositories/order/order_repository.dart';

import '../../dto/order_product_dto.dart';
import 'order_state.dart';

class OrderController extends Cubit<OrderState> {
  final OrderRepository _orderRepository;

  OrderController(this._orderRepository) : super(const OrderState.initial());

  void load(List<OrderProductDto> products) async {
    try {
      emit(state.copyWith(status: OrderStatus.loading));
      final paymentTypes = await _orderRepository.getAllPaymentsTypes();

      emit(state.copyWith(orderProducts: products, status: OrderStatus.loaded, paymentsTypes: paymentTypes));
    } catch (e, s) {
      log('Erro ao carregar pagina', error: e, stackTrace: s);
      emit(state.copyWith(status: OrderStatus.error, errorMessage: 'Erro ao carregar a pagina'));
    }
  }
}
