import 'package:flutter/material.dart';
import 'package:foodapp/home_page.dart';
import 'package:foodapp/scan_page.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> loginUser(BuildContext context) async {
    final String username = usernameController.text;
    final String password = passwordController.text;

    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/login/'),
      body: {
        'username': username,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      // Authentication successful
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SearchPage()),
      );
    } else {
      // Authentication failed, show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login failed'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              Container(
                height: size.height * 0.24,
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff1E2E3D),
                      Color(0xff152534),
                      Color(0xff0C1C2E),
                    ],
                  ),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      'Good Health with Food Health Checker APP.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              // Toggle password visibility
                            });
                          },
                          icon: const Icon(
                            Icons.visibility,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      obscureText: true,
                    ),

                    const SizedBox(
                      height: 15,
                    ),
                    ElevatedButton(
                      onPressed: () => loginUser(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                      ),
                      child: const Text('Login'),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    // Social login buttons (e.g., Google, Facebook)
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        // Navigate to the registration page
                      },
                      style: TextButton.styleFrom(
                          // Customize the TextButton style
                          ),
                      child: Text(
                        'Good Health, Good Life',
                        style: TextStyle(
                          color: Colors.green[900],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        backgroundColor: const Color(0xff1E2E3D),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const FoodSearchScreen()),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Stack(
        children: [
          Image.network(
            'https://media.istockphoto.com/id/1457433817/photo/group-of-healthy-food-for-flexitarian-diet.webp?b=1&s=170667a&w=0&k=20&c=RKgGJW8aIINIPpisynZ2x6UWFiMZ0afmEN32gmbYvVI=', // Replace with your image URL
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //TODO: Add your UI here
            ],
          ),
        ],
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ScanPage()),
              );
            },
            icon: Icon(
              Icons.camera_alt,
              color: Colors.red[200],
            ),
            label: const Text(
              'Scan Product',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[900],
            ),
          ),
        ),
      ),
    );
  }
}
