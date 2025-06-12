
import 'package:grocery/export.dart';

class ProductDetailsPage extends StatelessWidget {
  final Product product;

  const ProductDetailsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name, style: GoogleFonts.poppins()),
        backgroundColor: const Color(0xFF2E7D32),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🖼️ Product Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                product.imageUrl,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 180,
                    color: Colors.grey[200],
                    child: const Icon(Icons.broken_image, size: 60, color: Colors.grey),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    height: 180,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator(),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // 📝 Product Name
            Text(
              product.name,
              style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w600),
            ),

            const SizedBox(height: 8),

            // 💵 Price & Unit
            Text(
              '₹${product.price.toStringAsFixed(2)} • ${product.unit}',
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.green[800], fontWeight: FontWeight.w500),
            ),

            const SizedBox(height: 10),

            // ⭐ Ratings
            Row(
              children: [
                Icon(Icons.star, size: 18, color: Colors.amber[700]),
                const SizedBox(width: 4),
                Text(
                  '${product.rating} ',
                  style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w500),
                ),
                Text(
                  '(${product.reviews} reviews)',
                  style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey[600]),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // 🍀 Organic Badge
            if (product.isOrganic)
              Chip(
                label: const Text("Organic", style: TextStyle(color: Colors.white)),
                backgroundColor: const Color(0xFF2E7D32),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              ),

            const Divider(height: 32),

            // 📃 Description Section
            Text("Description", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 6),
            Text(
              product.description ?? "No description available.",
              style: GoogleFonts.poppins(fontSize: 14, height: 1.4),
            ),

            const Divider(height: 32),

            // 🟢 Availability + CTA
            Text("Availability", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Provider.of<CartProvider>(context, listen: false).addToCart(product);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AddToCartPage()),
                  );
                },
                icon: const Icon(Icons.add_shopping_cart, size: 20),
                label: Text(
                  "Add to Cart",
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E7D32),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
