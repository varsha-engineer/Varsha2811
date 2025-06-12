import 'package:firebase_auth/firebase_auth.dart';
import 'package:grocery/export.dart';



class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Profile',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Profile Picture
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.green[100],
              child: const Icon(Icons.person, size: 60, color: Colors.green),
            ),
            const SizedBox(height: 16),

            // Display Name & Email
            Text(
              user?.displayName ?? 'No Name',
              style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              user?.email ?? 'No Email',
              style: GoogleFonts.poppins(color: Colors.grey[600]),
            ),
            const SizedBox(height: 20),

            // Other Info (Static for now)
            _buildInfoTile(Icons.phone, 'Phone', user?.phoneNumber ?? 'Not Provided'),
            _buildInfoTile(Icons.location_on, 'Address', 'Mumbai, Maharashtra'),
            _buildInfoTile(Icons.shopping_bag, 'Total Orders', '12'),
            _buildInfoTile(Icons.calendar_today, 'Member Since', user?.metadata.creationTime?.toLocal().toString().split(' ').first ?? 'N/A'),
            const SizedBox(height: 30),

            // Action Buttons
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Edit Profile coming soon')),
                  );
                },
                icon: const Icon(Icons.edit),
                label: const Text('Edit Profile'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.logout),
                label: const Text('Logout'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String title, String value) {
    return ListTile(
      leading: Icon(icon, color: Colors.green[600]),
      title: Text(
        title,
        style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        value,
        style: GoogleFonts.poppins(color: Colors.grey[700]),
      ),
    );
  }
}
