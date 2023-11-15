import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:memory_aid/widget/front_tile.dart';

class Carousal extends StatelessWidget {
  const Carousal({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      CarouselSlider(
        options: CarouselOptions(
          height: 380.0,
          enlargeCenterPage: true,
          autoPlay: true,
          aspectRatio: 10 / 9,
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
          autoPlayAnimationDuration: const Duration(milliseconds: 500),
          viewportFraction: 0.8,
        ),
        items:const [          
          FrontTile(title: 'Stay ', subtitle: 'Mentally active..'),
          FrontTile(title: 'Interact', subtitle: 'With more people..'),
          FrontTile(title: 'Have', subtitle: 'Enough Sleep..')

        ]
      ),
    ]);
  }
}
