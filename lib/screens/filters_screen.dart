import 'package:flutter/material.dart';
import 'package:meals_app/widgets/main_drawer.dart';

import '../dialog.dart';
import '../models/filter.dart';

class FiltersScreen extends StatefulWidget {
  static const routName = '/filters';
  final Function(Filter) saveFilters;
  final Filter currentFilters;

  const FiltersScreen(
      {Key? key, required this.saveFilters, required this.currentFilters})
      : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _lactoseFree = false;
  bool _vegetarian = false;
  bool _vegan = false;

  @override
  void initState() {
    _glutenFree = widget.currentFilters.gluten;
    _lactoseFree = widget.currentFilters.lactose;
    _vegetarian = widget.currentFilters.vegetarian;
    _vegan = widget.currentFilters.vegan;
    super.initState();
  }

  Widget _buildSwitchListTile(String title, String description,
      bool currentValue, Function(bool) updateValue) {
    return SwitchListTile(
      activeColor: Theme.of(context).colorScheme.secondary,
      title: Text(title),
      subtitle: Text(description),
      value: currentValue,
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Filters'),
          actions: [
            IconButton(
              onPressed: () {
                final selectedFilters = Filter(
                    gluten: _glutenFree,
                    lactose: _lactoseFree,
                    vegetarian: _vegetarian,
                    vegan: _vegan);
                widget.saveFilters(selectedFilters);
                if(selectedFilters.gluten || selectedFilters.lactose || selectedFilters.vegetarian || selectedFilters.vegan) {
                  MyDialog.buildDialog(context, 'Successfully applied filters');
                }else{
                  MyDialog.buildDialog(context, 'No filter applied - please apply some');
                }
              },
              icon: const Icon(Icons.save),
            ),
          ],
        ),
        drawer: const MainDrawer(),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              child: Text(
                'Adjust your meal selection.',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            _buildSwitchListTile(
              'Gluten-free',
              'Only gluten-free meals.',
              _glutenFree,
              (newValue) {
                setState(
                  () {
                    _glutenFree = newValue;
                  },
                );
              },
            ),
            _buildSwitchListTile(
              'Lactose-free',
              'Only lactose-free meals.',
              _lactoseFree,
              (newValue) {
                setState(
                  () {
                    _lactoseFree = newValue;
                  },
                );
              },
            ),
            _buildSwitchListTile(
              'Vegetarian',
              'Only vegetarian meals.',
              _vegetarian,
              (newValue) {
                setState(
                  () {
                    _vegetarian = newValue;
                  },
                );
              },
            ),
            _buildSwitchListTile(
              'Vegan',
              'Only vegan meals.',
              _vegan,
              (newValue) {
                setState(
                  () {
                    _vegan = newValue;
                  },
                );
              },
            ),
          ],
        ));
  }
}
