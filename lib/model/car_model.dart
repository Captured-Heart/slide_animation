import 'package:slide_animation/asset_constant.dart';

class CarModel {
  final String image;
  final String? title;
  final String? subtitle;
  final String? description;

  CarModel({
    required this.image,
    this.title,
    this.subtitle,
    this.description,
  });
}

List<CarModel> carModelList = [
  // 1
  CarModel(
    image: AssetConstant.car5,
    title: 'Lamborghini',
    subtitle: '*Founded*: 1963 by Ferruccio Lamborghini.',
    description: '*Distinctive Features*: Exotic designs, powerful engines (V10, V12), and cutting-edge technology.',
  ),
  // 2
  CarModel(
    image: AssetConstant.car2,
    title: 'Porsche',
    subtitle: '*Founded*: 1931 by Ferdinand Porsche.',
    description: '*Distinctive Features*: Precision engineering, rear-engine layout (in 911), advanced hybrid and electric models like the Taycan.',
  ),
  // 3
  CarModel(
    image: AssetConstant.car3,
    title: 'Ferrari',
    subtitle: '*Founded*: 1939 by Enzo Ferrari.',
    description: '*Distinctive Features*: Sleek, aggressive styling, V8 and V12 engines, and a racing legacy.',
  ),
  // 4
  CarModel(
    image: AssetConstant.car4,
    title: 'Volkswagen',
    subtitle: '*Founded*: 1937 by the German Labour Front (people\'s car program).',
    description: '*Distinctive Features*: Focus on affordability, reliability, and fuel efficiency.',
  ),
  // 5
  CarModel(
    image: AssetConstant.car1,
    title: 'Toyota',
    subtitle: '*Founded*: 1937 by Kiichiro Toyoda',
    description: '*Distinctive Features*: Renowned for reliability, fuel efficiency, and cutting-edge hybrid technology',
  ),
];
