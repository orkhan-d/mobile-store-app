import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:store/pages/auth_page.dart';
import 'package:store/pages/orders_page.dart';
import 'package:store/providers/auth_provider.dart';
import 'package:store/providers/theme_provider.dart';
import 'package:store/services/auth_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class MenuItem {
  IconData icon;
  String title;
  void Function() onTap;

  MenuItem({required this.icon, required this.title, required this.onTap});
}

class _ProfilePageState extends State<ProfilePage> {
  late ThemeProvider themeProvider;

  @override
  void initState() {
    super.initState();
    themeProvider = Provider.of<ThemeProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final avatarSize = MediaQuery.of(context).size.width*0.4;

    final List<MenuItem> items = [
    MenuItem(
      icon: Icons.shopping_cart,
      title: 'Orders',
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const OrdersPage()));
      }
    ),
    MenuItem(
      icon: Icons.edit,
      title: 'Edit profile',
      onTap: () {}
    ),
    MenuItem(
      icon: Icons.logout,
      title: 'Logout',
      onTap: () {
        signOut(context);
      }
    ),
  ];

    return Consumer<AuthProvider>(
      builder: (context, AuthProvider authProvider, child) {
        if (authProvider.currentUser == null) {
          return AuthPage();
        } else {
          return ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length+1,
            itemBuilder: (context, index) {
              if (index==0) {
                return ListTile(
                  minVerticalPadding: 35,
                  titleAlignment: ListTileTitleAlignment.center,
                  minLeadingWidth: avatarSize,
                  leading: AspectRatio(
                    aspectRatio: 1,
                    child: Container(
                      width: avatarSize,
                      decoration: BoxDecoration(
                        color: themeProvider.currentTheme!.colorScheme.secondary.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(avatarSize*0.5),
                      ),
                      child: Icon(Icons.person, size: avatarSize*0.25, color: Colors.white),
                    ),
                  ),
                  title: Text(
                    authProvider.currentUser!.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  onTap: () {},
                );
              }
              else {
                return Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: themeProvider.currentTheme!.colorScheme.secondary.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: Icon(items[index-1].icon),
                    title: Text(
                      items[index-1].title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    onTap: items[index-1].onTap,
                  ),
                );
              }
            },
          );
        }
      }
    );
  }
}