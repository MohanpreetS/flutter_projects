import 'package:flutter/material.dart';

class MenuFilters extends StatefulWidget {
  Map<String, bool> selectedFilters;
  Function selectFilter;
  Function resetFilters;

  MenuFilters(this.selectedFilters, this.selectFilter, this.resetFilters);
  @override
  _MenuFiltersState createState() => _MenuFiltersState();
}

class _MenuFiltersState extends State<MenuFilters> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            SizedBox(
              width: 10,
            ),
            if (isSelected) _buildX(context),
            if (isSelected)
              SizedBox(
                width: 10,
              ),
            ...(_buildList(widget.selectedFilters, context)),
          ],
        ),
      ),
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.06,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
    );
  }

  List<Widget> _buildList(Map<String, bool> selectedFilters, context) {
    List<Widget> builtList = [];
    widget.selectedFilters.entries.forEach((entry) {
      if (entry.value) {
        builtList.add(_buildFilter(entry.key, context));
        builtList.add(SizedBox(
          width: 10,
        ));
      }
    });
    // if (builtList.length == 1) {
    //   builtList.insert(0, _buildX(context));
    // }
    return builtList;
  }

  Widget _buildX(context) {
    return ActionChip(
      onPressed: () {
        widget.resetFilters();
        isSelected = false;
      },
      elevation: 5,
      label: Text(
        'X',
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }

  Widget _buildFilter(title, context) {
    return ActionChip(
      onPressed: () {
        widget.selectFilter(title);
        isSelected = true;
      },
      elevation: 5,
      label: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
