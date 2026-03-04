import 'package:flutter/material.dart';
import 'screens/registration_screen.dart'; // Import your new files
import 'screens/directory_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Skills Trainer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        brightness: Brightness.light,
      ),
      home: const MainNavigationShell(),
    );
  }
}

class MainNavigationShell extends StatefulWidget {
  const MainNavigationShell({super.key});

  @override
  _MainNavigationShellState createState() => _MainNavigationShellState();
}

class _MainNavigationShellState extends State<MainNavigationShell> {
  int _activePage = 0;

  final List<Map<String, String>> _savedUsers = [
    {"name": "Emma Richardson", "email": "richemma@mail.com"},
    {"name": "Olivia Perry", "email": "perryolivia@mail.com"},
  ];

  void _addNewUser(String name, String email) {
    setState(() {
      _savedUsers.add({"name": name, "email": email});
    });
  }

  @override
  Widget build(BuildContext context) {
    // These are the screens from the separate files
    final List<Widget> pages = [
      RegistrationScreen(onSave: _addNewUser),
      DirectoryScreen(users: _savedUsers),
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 2,
        title: const Text(
          "Flutter Skills Lab",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: pages[_activePage],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _activePage,
        onDestinationSelected: (index) => setState(() => _activePage = index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.person_add_alt_1_outlined),
            selectedIcon: Icon(Icons.person_add_alt_1),
            label: "Registration",
          ),
          NavigationDestination(
            icon: Icon(Icons.badge_outlined),
            selectedIcon: Icon(Icons.badge),
            label: "Directory",
          ),
        ],
      ),
    );
  }
}