// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:grocery/view_model/cart_view_model.dart';
// import 'package:grocery/views/productdetai_view.dart';
// import 'package:provider/provider.dart';

// class AddToCartPage extends StatelessWidget {
//   const AddToCartPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Your Cart',
//           style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
//         ),
//       ),
//       body: Consumer<CartProvider>(
//         builder: (context, cartProvider, child) {
//           final cartItems = cartProvider.items;

//           if (cartItems.isEmpty) {
//             return const Center(
//               child: Text(
//                 'Your cart is empty',
//                 style: TextStyle(fontSize: 16),
//               ),
//             );
//           }

//           return Column(
//             children: [
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: cartItems.length,
//                   itemBuilder: (context, index) {
//                     final item = cartItems[index];
//                     final product = item.product;

//                     return ListTile(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (_) => ProductDetailsPage(product: product),
//                           ),
//                         );
//                       },
//                       leading: Image.network(
//                         product.imageUrl,
//                       ),
//                       title: Text(product.name, style: GoogleFonts.poppins()),
//                       subtitle: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text('₹${product.price.toStringAsFixed(0)} • ${product.unit}'),
//                           Row(
//                             children: [
//                               IconButton(
//                                 icon: const Icon(Icons.remove),
//                                 onPressed: () {
//                                   cartProvider.updateQuantity(product.id, item.quantity - 1);
//                                 },
//                               ),
//                               Text('${item.quantity}'),
//                               IconButton(
//                                 icon: const Icon(Icons.add),
//                                 onPressed: () {
//                                   cartProvider.updateQuantity(product.id, item.quantity + 1);
//                                 },
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       trailing: IconButton(
//                         icon: const Icon(Icons.delete, color: Colors.red),
//                         onPressed: () => cartProvider.removeFromCart(product.id),
//                       ),
//                     );
//                   },
//                 ),
//               ),

//               // Total & Checkout Section
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: Column(
//                   children: [
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           'Total:',
//                           style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600),
//                         ),
//                         Text(
//                           '₹${cartProvider.totalAmount.toStringAsFixed(0)}',
//                           style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 12),
//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         onPressed: () {
//                           // Handle checkout
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(content: Text('Checkout process started')),
//                           );
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color(0xFF2E7D32),
//                           padding: const EdgeInsets.symmetric(vertical: 14),
//                         ),
//                         child: const Text('Checkout', style: TextStyle(fontSize: 16)),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery/view_model/cart_view_model.dart';
import 'package:grocery/views/productdetai_view.dart';
import 'package:provider/provider.dart';

class AddToCartPage extends StatelessWidget {
  const AddToCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Your Cart',
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
          ),
          backgroundColor: const Color(0xFF2E7D32)),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          final cartItems = cartProvider.items;

          if (cartItems.isEmpty) {
            return const Center(
              child: Text(
                'Your cart is empty',
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(12),
                  itemCount: cartItems.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) {
                    final item = cartItems[index];
                    final product = item.product;

                    return Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProductDetailsPage(product: product),
                            ),
                          );
                        },
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            product.imageUrl,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, color: Colors.grey),
                          ),
                        ),
                        title: Text(
                          product.name,
                          style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('₹${product.price.toStringAsFixed(2)} • ${product.unit}',
                                style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[700])),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove_circle_outline),
                                  onPressed: () {
                                    if (item.quantity > 1) {
                                      cartProvider.updateQuantity(product.id, item.quantity - 1);
                                    }
                                  },
                                ),
                                Text(
                                  '${item.quantity}',
                                  style: GoogleFonts.poppins(fontSize: 14),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add_circle_outline),
                                  onPressed: () {
                                    cartProvider.updateQuantity(product.id, item.quantity + 1);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => cartProvider.removeFromCart(product.id),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // 🧾 Total & Checkout Section
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, -2))],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total:',
                          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          '₹${cartProvider.totalAmount.toStringAsFixed(2)}',
                          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Checkout process started')),
                        );
                      },
                      icon: const Icon(Icons.shopping_bag_outlined),
                      label: Text(
                        'Proceed to Checkout',
                        style: TextStyle(fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade700,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
