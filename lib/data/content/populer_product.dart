class populerProduct {
  String? image;
  String? name;
  double? price;
  String? description;

  populerProduct(
      {required this.image, required this.name,required this.price, required this.description});
}

List<populerProduct> productPopuler = [
  populerProduct(
      image: 'assets/images/product_1.png',
      name: "Bell Pepper Red",
      price: 50.000,
      description:
          'Daun bawang memiliki bentuk memanjang dengan batang putih berdaging tebal. Daun bawang memiliki aroma dan rasa yang khas. Sehingga sering digunakan sebagai pelengkap makanan atau penambah cita rasa.',
          
          ),
  populerProduct(
      image: 'assets/images/product_2.png',
      price: 20.000,
      name : "Fresh Lettuce",
      description:
          'Daun bawang memiliki bentuk memanjang dengan batang putih berdaging tebal. Daun bawang memiliki aroma dan rasa yang khas. Sehingga sering digunakan sebagai pelengkap makanan atau penambah cita rasa.',
          
          ),
  populerProduct(
      image: 'assets/images/product_2.png',
      price: 20.000,
      name : "Fresh Lettuce",
      description:
          'Daun bawang memiliki bentuk memanjang dengan batang putih berdaging tebal. Daun bawang memiliki aroma dan rasa yang khas. Sehingga sering digunakan sebagai pelengkap makanan atau penambah cita rasa.',
          
          ),
  
];
