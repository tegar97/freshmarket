class onBoardingContent {
  String? image;
  String? title;
  String? description;

  onBoardingContent(
      {required this.image, required this.title, required this.description});
}

List<onBoardingContent> contents = [
  onBoardingContent(
      image: 'assets/images/onboarding_1.jpg',
      title: 'Easy Shopping',
      description:
          'Sekarang belanja mudah di freshmarket, cuman butuh beberapa klik selesai deh'),
  onBoardingContent(
      image: 'assets/images/onboarding_2.jpg',
      title: 'Gratis Ongkir',
      description:
          'Ga usah mikirin ongkir lagi  😤, karena di freshmarket ongkir gratisss 🔥'),
  onBoardingContent(
      image: 'assets/images/onboarding_3.jpg',
      title: 'Dijamin Fresh',
      description:
          'Semua produk kami dijamin fresh  , kami mengambil product dari petani unggulan  '),
  onBoardingContent(
      image: 'assets/images/onboarding_4.jpg',
      title: 'Tunggu apalagi?',
      description:
          'Ayo berbelanja di freshmarket dan dapatkan promo setiap harinya. '),
];
