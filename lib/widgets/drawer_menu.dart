import 'package:flutter/material.dart';
import '../ui/splash.dart';

class DrawerMenu extends StatelessWidget {
  final VoidCallback onToggleTheme;

  const DrawerMenu({
    super.key,
    required this.onToggleTheme,
  });

  @override
  Widget build(BuildContext context) {
    final isDark =
        Theme.of(context).brightness == Brightness.dark;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: const Center(
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),

          SwitchListTile(
            title: const Text('Tema escuro'),
            value: isDark,
            onChanged: (_) {
              onToggleTheme();
            },
          ),

          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),

          ListTile(
            leading: const Icon(Icons.flash_on),
            title: const Text('Tela inicial'),
            onTap: () {
              Navigator.pop(context);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => Splash(
                    onToggleTheme: onToggleTheme,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}