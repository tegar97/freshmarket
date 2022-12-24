// import 'package:flutter/material.dart';
// import 'package:freshmarket/models/addressModels.dart';
// import 'package:freshmarket/providers/address_providers.dart';
// import 'package:freshmarket/ui/global/widget/skeleton.dart';
// import 'package:freshmarket/ui/home/theme.dart';
// import 'package:provider/provider.dart';

// class AddressScreen extends StatefulWidget {
//   const AddressScreen({Key? key}) : super(key: key);

//   @override
//   State<AddressScreen> createState() => _AddressScreenState();
// }

// class _AddressScreenState extends State<AddressScreen> {
//   final Future<String> _calculation = Future<String>.delayed(
//     const Duration(seconds: 2),
//     () => 'Data Loaded',
//   );

//   void initState() {
//     super.initState();
//     getInit();
//   }

//   Future<void> getInit() async {
//     await Provider.of<AddressProvider>(context, listen: false).getAllAddress();

//     await Provider.of<AddressProvider>(context, listen: false).getMyAddress();
//   }

//   int? id;
//   bool? detectChange = false;
//   @override
//   Widget build(BuildContext context) {
//     AddressProvider addressProvider = Provider.of<AddressProvider>(context);

//     return Scaffold(
//       backgroundColor: lightModeBgColor,
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       floatingActionButton: detectChange == true
//           ? Container(
//               padding: EdgeInsets.symmetric(horizontal: 16),
//               width: double.infinity,
//               child: FloatingActionButton.extended(
//                 onPressed: () {
//                   addressProvider.changeToDabase(id);
//                   Navigator.pushNamed(context, '/cart');
//                 },
//                 label: Text('Ganti alamat'),
//                 backgroundColor: primaryColor,
//               ),
//             )
//           : null,
//       appBar: AppBar(
//         actions: [
//           IconButton(
//             icon: const Icon(
//               Icons.add,
//               color: Colors.black,
//             ),
//             tooltip: 'Add address',
//             onPressed: () {
//               Navigator.pushNamed(context, '/add-address');
//             },
//           ),
//         ],
//         title: Text("Alamat",
//             style: headerTextStyle.copyWith(
//                 fontSize: 18, fontWeight: FontWeight.w600)),
//         centerTitle: true,
//         backgroundColor: lightModeBgColor,
//         elevation: 0.5,
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back_ios_new,
//             color: Colors.black,
//           ),
//           tooltip: 'Kembali ke halaman product',
//           onPressed: () {
//             // handle the press
//             Navigator.pop(context);
//           },
//         ),
//       ),
//       body: SafeArea(
//         child: Container(
//             padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
//             margin: EdgeInsets.only(bottom: 20),
//             child: FutureBuilder(
//               future: _calculation,
//               builder: (context, snapshot) {
//                 if (snapshot.hasData) {
//                   return addressProvider.listAddress.length < 1
//                       ? EmptyAddress()
//                       : ListView(
//                           children: addressProvider.listAddress
//                               .map((address) => GestureDetector(
//                                   onTap: () {
//                                     setState(() {
//                                       detectChange = true;
//                                       id = address.id;
//                                     });
//                                     addressProvider.changeMainAaddress(address);
//                                   },
//                                   child: AddressBox(
//                                     address: address,
//                                     selectedAddress: addressProvider.myAddress,
//                                   )))
//                               .toList());
//                 } else {
//                   return Center(
//                     child: CircularProgressIndicator(
//                       color: primaryColor,
//                     ),
//                   );
//                 }
//               },
//             )),
//       ),
//     );
//   }
// }

// class AddressBox extends StatelessWidget {
//   AddressBox({Key? key, required this.address, required this.selectedAddress})
//       : super(key: key);

//   AddressModels address;
//   AddressModels selectedAddress;

//   @override
//   Widget build(BuildContext context) {
//     print(selectedAddress.id);
//     return Container(
//       margin: EdgeInsets.only(bottom: 20),
//       padding: EdgeInsets.symmetric(horizontal: 13, vertical: 11),
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(11),
//           border: Border.all(
//             color: selectedAddress.id == address.id ? primaryColor : neutral20,
//           )),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Expanded(
//                 child: Row(
//                   children: [
//                     Text("${address.label}",
//                         style: headerTextStyle.copyWith(
//                             fontWeight: FontWeight.w600, fontSize: 15)),
//                     SizedBox(
//                       width: 5,
//                     ),
//                     Container(
//                       width: 5,
//                       height: 5,
//                       decoration: BoxDecoration(
//                           color: Colors.black,
//                           borderRadius: BorderRadius.circular(100)),
//                     ),
//                     SizedBox(
//                       width: 5,
//                     ),
//                     Text("${address.phoneNumber} ",
//                         style: subtitleTextStyle.copyWith(fontSize: 15))
//                   ],
//                 ),
//               ),
//               selectedAddress.id == address.id
//                   ? Icon(
//                       Icons.verified,
//                       color: primaryColor,
//                     )
//                   : SizedBox(
//                       height: 40,
//                     )
//             ],
//           ),
//           SizedBox(
//             height: 5,
//           ),
//           Text("${address.fullAddress} ",
//               style: subtitleTextStyle.copyWith(fontSize: 13))
//         ],
//       ),
//     );
//   }
// }

// class EmptyAddress extends StatelessWidget {
//   const EmptyAddress({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
    
//         Image.asset('assets/images/courier.png',
//           height: 250,
//         ),
//         SizedBox(
//           height: 60,
//         ),
//         Text("Yuk tambahin alamat",
//             style: headerTextStyle.copyWith(
//                 fontSize: 24, fontWeight: FontWeight.w600)),
//         SizedBox(
//           height: 10,
//         ),
//         Text(
//           "Biar kurir cepat sampai kerumah mu ,pastikan alamat sudah benar dan pastikan juga nomor hp aktif ",
//           textAlign: TextAlign.center,
//           style: subtitleTextStyle.copyWith(fontSize: 14, height: 1.4),
//         ),
//         SizedBox(height: 20,),
      
//         TextButton(
//           onPressed: () {
//             Navigator.pushNamed(context, '/add-address');
//           },
//           child: Text("Tambahkan alamat ",
//               style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
//           style: TextButton.styleFrom(
//             backgroundColor: primaryColor,
//             primary: Colors.white,
//             minimumSize: Size(double.infinity, 60),
//             shape: const RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(23)),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
