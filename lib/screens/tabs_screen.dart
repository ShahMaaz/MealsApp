import 'package:flutter/material.dart';
import 'package:meals_app/models/tab_model.dart';
import 'package:meals_app/screens/category_screen.dart';
import 'package:meals_app/screens/favorites_screen.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<TabModel> _pages = [
    TabModel(page: const CategoryScreen(), title: 'Categories'),
    TabModel(page: const FavoritesScreen(), title: 'Your Favorites'),
  ];
/*  final List<Widget> _pages = [
    const CategoryScreen(),
    const FavoritesScreen(),
  ];

  final List<String> _titles = [
    'Categories',
    'Your Favorites'
  ];*/


  int _selectedIndex = 0;

  void _selectPage(int index){
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_pages[_selectedIndex].title),
        ),
        drawer: const MainDrawer(),
        body: _pages[_selectedIndex].page,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          currentIndex: _selectedIndex,
          selectedItemColor: Theme.of(context).canvasColor,
          unselectedItemColor:  Colors.white54,
          onTap: _selectPage,
          items: const [
            BottomNavigationBarItem(
              icon:  Icon(
                Icons.category,
              ),
              label: 'Categories'
            ),
            BottomNavigationBarItem(
              icon:  Icon(
                Icons.star,
              ),
              label: 'Favorites'
            ),
          ],
        ),
      ),
    );
  }
}
