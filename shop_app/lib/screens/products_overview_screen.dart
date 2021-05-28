import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/cart_screen.dart';
import '../widgets/app_drawer.dart';
import '../widgets/products_grid.dart';
import '../providers/cart.dart';
import '../widgets/badge.dart';
import '../providers/products.dart';

enum FilterOptions {
  Favourites,
  All,
}

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool _showFavs = false;
  bool isInit = true;
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Future.delayed(Duration.zero).then((value) {
    //   Provider.of<Products>(context).fetchSet();
    // });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (isInit) {
      setState(() {
        isLoading = true;
      });
      Provider.of<Products>(context).fetchSet().then((_) {
        setState(() {
          isLoading = false;
        });
      });
    }
    isInit = false;
  }

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions s) {
              setState(() {
                if (s == FilterOptions.Favourites) {
                  _showFavs = true;
                } else {
                  _showFavs = false;
                }
              });
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favs'),
                value: FilterOptions.Favourites,
              ),
              PopupMenuItem(
                child: Text('All'),
                value: FilterOptions.All,
              )
            ],
            icon: Icon(Icons.more_vert),
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(_showFavs),
    );
    return scaffold;
  }
}
