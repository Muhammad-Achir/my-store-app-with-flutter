import 'package:flutter/material.dart';
import 'package:my_store_app/model/product/product.dart';

class DetailProductPage extends StatefulWidget {
  final Product product;
  const DetailProductPage({super.key, required this.product});

  @override
  State<DetailProductPage> createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  int quantity = 1;

  void updateQuantity(int newQuantity) {
    setState(() {
      quantity = newQuantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Product'),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth > 800) {
          return DetailWebPage(
            product: widget.product,
            quantity: quantity,
            updateQuantity: updateQuantity,
          );
        } else {
          return Detail(
            product: widget.product,
            quantity: quantity,
            updateQuantity: updateQuantity,
          );
        }
      }),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                'Total: \$ ${quantity * widget.product.price}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Spacer(),
            Expanded(
              child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          content: Text('You bought ${widget.product.title}'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Buy Now',
                    style: TextStyle(fontSize: 18),
                  )),
            )
          ],
        ),
      ),
    );
  }
}

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
          child: Detail(
            product: widget.product,
            quantity: widget.quantity,
            updateQuantity: widget.updateQuantity,
          ),
        ),
      ),
    );
  }
}

class Detail extends StatefulWidget {
  final int quantity;
  final ValueChanged<int> updateQuantity;
  final Product product;
  const Detail({
    super.key,
    required this.product,
    required this.quantity,
    required this.updateQuantity,
  });

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
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
