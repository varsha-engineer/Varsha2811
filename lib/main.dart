import 'package:firebase_auth/firebase_auth.dart';
import 'package:grocery/export.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures binding for async code
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: GroceryApp(),
    ),
  );
}

class GroceryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'FreshMart Grocery',
          debugShowCheckedModeBanner: false,
          themeMode: themeProvider.themeMode,
          theme: ThemeData(
            primarySwatch: Colors.lightGreen,
            primaryColor: const Color(0xFF2E7D32),
            fontFamily: GoogleFonts.poppins().fontFamily,
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF2E7D32),
              foregroundColor: Colors.white,
              elevation: 2,
            ),
            bottomSheetTheme: const BottomSheetThemeData(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
            ),
          ),
          darkTheme: ThemeData.dark().copyWith(
            primaryColor: const Color(0xFF4CAF50),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF1B5E20),
              foregroundColor: Colors.white,
              elevation: 2,
            ),
            bottomSheetTheme: BottomSheetThemeData(
              backgroundColor: Colors.grey[900],
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
            ),
          ),
          home: const SplashScreen(),
        );
      },
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(), // Ensures Firebase is ready
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return const Scaffold(
            body: Center(child: Text('Something went wrong')),
          );
        }

        // Now Firebase is initialized, listen for auth changes
        return StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            if (userSnapshot.hasData) {
              return const HomeScreen(); // Signed in
            } else {
              return const LoginScreen(); // Not signed in
            }
          },
        );
      },
    );
  }
}
