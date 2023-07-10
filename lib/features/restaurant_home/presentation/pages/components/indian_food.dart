class IndianFood {
  const IndianFood({
    required this.image,
    required this.name,
  });

  final String image;
  final String name;

  static List<IndianFood> getIndianRestaurants() {
    return const [
      IndianFood(image: 'assets/images/food3.jpg', name: 'South\nIndian'),
      IndianFood(image: 'assets/images/food5.jpg', name: 'Chinese'),
      IndianFood(image: 'assets/images/food1.jpg', name: 'North \nIndian'),
      IndianFood(image: 'assets/images/food8.jpg', name: 'Biryani'),
      IndianFood(image: 'assets/images/food9.jpg', name: 'Dosa'),
      IndianFood(image: 'assets/images/food4.jpg', name: 'Idli'),
    ];
  }
}
