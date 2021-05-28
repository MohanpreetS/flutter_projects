import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters';

  final Function saveFilters;
  final Map<String, bool> curFilters;

  FiltersScreen(this.saveFilters, this.curFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  initState() {
    super.initState();
    _glutenFree = widget.curFilters['gluten'];
    _vegetarian = widget.curFilters['vegetarian'];
    _lactoseFree = widget.curFilters['lactose'];
    _vegan = widget.curFilters['vegan'];
  }

  Widget _buildSwitch(
    String title,
    String description,
    bool curVal,
    Function updateValue,
  ) {
    return SwitchListTile(
      title: Text(title),
      value: curVal,
      subtitle: Text(description),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your filters'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final selectedFilters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              };
              widget.saveFilters(selectedFilters);
            },
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust meal selection',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSwitch(
                  'Gluten Free',
                  'Only g free',
                  _glutenFree,
                  (newVal) {
                    setState(() {
                      _glutenFree = newVal;
                    });
                  },
                ),
                _buildSwitch(
                  'Lactose Free',
                  'Only l free',
                  _lactoseFree,
                  (newVal) {
                    setState(() {
                      _lactoseFree = newVal;
                    });
                  },
                ),
                _buildSwitch(
                  'vegetarian',
                  'Only v',
                  _vegetarian,
                  (newVal) {
                    setState(() {
                      _vegetarian = newVal;
                    });
                  },
                ),
                _buildSwitch(
                  'Vegan',
                  'Only vegan',
                  _vegan,
                  (newVal) {
                    setState(() {
                      _vegan = newVal;
                    });
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
