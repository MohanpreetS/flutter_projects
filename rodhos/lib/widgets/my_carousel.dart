import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MyCarousel extends StatefulWidget {
  final list;
  var current;
  MyCarousel(this.current, this.list);
  @override
  _MyCarouselState createState() => _MyCarouselState();
}

class _MyCarouselState extends State<MyCarousel> {
  @override
  Widget build(BuildContext context) {
    final mQuery = MediaQuery.of(context);
    return Container(
      child: Column(
        children: [
          CarouselSlider(
            items: widget.list.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        'text $i',
                        style: TextStyle(fontSize: 16.0),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
            options: CarouselOptions(
              height: mQuery.size.height * 0.18,
              aspectRatio: 16 / 9,
              viewportFraction: 1,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              //onPageChanged: callbackFunction,
              scrollDirection: Axis.horizontal,
              onPageChanged: (i, _) {
                setState(() {
                  widget.current = i;
                });
              },
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ...widget.list.map((e) {
                return Container(
                  width: widget.current == e ? 12 : 10,
                  height: widget.current == e ? 12 : 10,
                  margin: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 2,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.current == e
                        ? Colors.white
                        : Colors.grey.shade400,
                  ),
                );
              })
            ],
          )
        ],
      ),
    );
  }
}
