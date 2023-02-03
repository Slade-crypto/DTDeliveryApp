import 'package:auto_size_text/auto_size_text.dart';
import 'package:dt_delivery_app/app/core/ui/extensions/formatter_extension.dart';
import 'package:dt_delivery_app/app/core/ui/helpers/size_extensions.dart';
import 'package:dt_delivery_app/app/core/ui/styles/text_styles.dart';
import 'package:dt_delivery_app/app/core/ui/widgets/delivery_appbar.dart';
import 'package:dt_delivery_app/app/dto/order_product_dto.dart';
import 'package:dt_delivery_app/app/models/product_model.dart';
import 'package:dt_delivery_app/app/pages/product_detail/product_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/ui/base_state/base_state.dart';
import '../../core/ui/widgets/delivery_increment_decrement_button.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductModel product;
  final OrderProductDto? order;

  const ProductDetailPage({super.key, required this.product, required this.order});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends BaseState<ProductDetailPage, ProductDetailController> {
  @override
  void initState() {
    super.initState();
    final amount = widget.order?.amout ?? 1;
    controller.initial(amount, widget.order != null);
  }

  void _showConfirmDelete(int amount) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Deseja excluir o prouto?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Cancelar',
                  style: context.textStyles.textBold.copyWith(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.of(context).pop(
                    OrderProductDto(
                      product: widget.product,
                      amout: amount,
                    ),
                  );
                },
                child: Text(
                  'Confirmar',
                  style: context.textStyles.textBold,
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeliveryAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: context.screenWidth,
            height: context.percentHeight(.4),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.product.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              widget.product.name,
              style: context.textStyles.textExtraBold.copyWith(fontSize: 22),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SingleChildScrollView(
                child: Text(
                  widget.product.description,
                ),
              ),
            ),
          ),
          const Divider(),
          Row(
            children: [
              Container(
                  width: context.percentWidth(.5),
                  height: 68,
                  padding: const EdgeInsets.all(8),
                  child: BlocBuilder<ProductDetailController, int>(
                    builder: (context, amout) {
                      return DeliveryIncrementDecrementButton(
                        incrementTap: () {
                          controller.increment();
                        },
                        decrementTap: () {
                          controller.decrement();
                        },
                        amout: amout,
                      );
                    },
                  )),
              Container(
                  width: context.percentWidth(.5),
                  height: 68,
                  padding: const EdgeInsets.all(8),
                  child: BlocBuilder<ProductDetailController, int>(builder: (context, amout) {
                    return ElevatedButton(
                      style: amout == 0 ? ElevatedButton.styleFrom(backgroundColor: Colors.red) : null,
                      onPressed: () {
                        if (amout == 0) {
                          _showConfirmDelete(amout);
                        } else {
                          Navigator.of(context).pop(
                            OrderProductDto(
                              product: widget.product,
                              amout: amout,
                            ),
                          );
                        }
                      },
                      child: Visibility(
                        visible: amout > 0,
                        replacement: Text(
                          'Excluir produto',
                          style: context.textStyles.textExtraBold,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Adicionar',
                              style: context.textStyles.textExtraBold.copyWith(fontSize: 13),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Expanded(
                              child: AutoSizeText(
                                (widget.product.price * amout).currencyPTBR,
                                maxFontSize: 13,
                                minFontSize: 5,
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                style: context.textStyles.textExtraBold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })),
            ],
          ),
        ],
      ),
    );
  }
}
