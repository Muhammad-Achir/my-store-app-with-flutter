import 'package:flutter/material.dart';
import 'package:my_store_app/model/product/product.dart';

class DetailProductItem extends StatefulWidget {
  final int quantity;
  final ValueChanged<int> updateQuantity;
  final Product product;
  const DetailProductItem({
    super.key,
    required this.product,
    required this.quantity,
    required this.updateQuantity,
  });

  @override
  State<DetailProductItem> createState() => _DetailProductItemState();
}

class _DetailProductItemState extends State<DetailProductItem> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.quantity;
  }

  void increaseQuantity() {
    quantity += 1;
    widget.updateQuantity(quantity);
  }

  void decreaseQuantity() {
    if (quantity > 1) {
      quantity -= 1;
      widget.updateQuantity(quantity);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.4,
            color: Colors.white,
            child: Hero(
              tag: widget.product.title,
              child: Image.network(
                widget.product.image,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(height: 8),
                Hero(
                  tag: 'rate${widget.product.title}',
                  child: Wrap(
                    children: [
                      Text(
                        '${widget.product.rating.rate}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(width: 2),
                      Icon(
                        Icons.star,
                        size: 15,
                        color: Colors.amber,
                      ),
                      SizedBox(width: 2),
                      Text(
                        'Penilaian Produk (${widget.product.rating.count})',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Description',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  widget.product.description,
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 8),
                Text('Category: ${widget.product.category}'),
                const SizedBox(height: 16),
                Text(
                  'Price: ${widget.product.price}/Pcs',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Wrap(
                  children: [
                    Text('Quantity:'),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: decreaseQuantity,
                      child: Text(
                        '-',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        minimumSize: Size(30, 30),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '$quantity',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: increaseQuantity,
                      child: Text(
                        '+',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        minimumSize: Size(30, 30),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
