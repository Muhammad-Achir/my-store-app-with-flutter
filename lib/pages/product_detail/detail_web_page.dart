import "package:flutter/material.dart";
import "package:my_store_app/models/product/product.dart";
import "package:my_store_app/pages/product_page/detail_product_item.dart";

class DetailWebPage extends StatefulWidget {
  final int quantity;
  final ValueChanged<int> updateQuantity;
  final Product product;
  const DetailWebPage({
    super.key,
    required this.product,
    required this.quantity,
    required this.updateQuantity,
  });

  @override
  State<DetailWebPage> createState() => _DetailWebPageState();
}

class _DetailWebPageState extends State<DetailWebPage> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.quantity;
  }

  @override
  void didUpdateWidget(covariant DetailWebPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.quantity != widget.quantity) {
      quantity = widget.quantity;
    }
  }

  void increaseQuantity() {}

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 1200,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 32),
          color: Theme.of(context).colorScheme.onInverseSurface,
          child: DetailProductItem(
            product: widget.product,
            quantity: widget.quantity,
            updateQuantity: widget.updateQuantity,
          ),
        ),
      ),
    );
  }
}

