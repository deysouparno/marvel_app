import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key? key,
    required this.onItemSelected,
  }) : super(key: key);

  final ValueChanged<DrawerItem> onItemSelected;

  Widget buildDrawerItems(BuildContext context) => Column(
        children: DrawerItems.drawerItems
            .map((e) => ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  title: Text(e.title),
                  leading: Icon(e.icondata),
                  onTap: () => onItemSelected(e),
                ))
            .toList(),
      );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [buildDrawerItems(context)],
      ),
    );
  }
}

class DrawerItem {
  final String title;
  final IconData icondata;

  const DrawerItem({required this.title, required this.icondata});
}

class DrawerItems {
  static const DrawerItem characterPage =
      DrawerItem(title: "Characters", icondata: Icons.account_circle_rounded);
  static const DrawerItem comicsPage =
      DrawerItem(title: "Comics", icondata: Icons.menu_book);
  static List<DrawerItem> drawerItems = [characterPage, comicsPage];
}
