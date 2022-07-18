import 'package:flutter/material.dart';
import 'package:freshmarket/providers/store_provider.dart';
import 'package:freshmarket/ui/global/widget/skeleton.dart';
import 'package:freshmarket/ui/home/theme.dart';
import 'package:provider/provider.dart';

class ListOutlet extends StatefulWidget {
  const ListOutlet({Key? key}) : super(key: key);

  @override
  State<ListOutlet> createState() => _ListOutletState();
}

class _ListOutletState extends State<ListOutlet> {
  final Future<String> delay = Future<String>.delayed(
    const Duration(seconds: 2),
    () => 'Data Loaded',
  );
  @override
  void initState() {
    super.initState();
    getInit();
  }

  getInit() async {
    await Provider.of<StoreProvider>(context, listen: false).getAllOutlet();
  }

  @override
  Widget build(BuildContext context) {
    StoreProvider listOutlet = Provider.of<StoreProvider>(context);
    print(listOutlet);

    return Scaffold(
      appBar: AppBar(
        title: Text("List outlet",
            style: headerTextStyle.copyWith(
                fontSize: 18, fontWeight: FontWeight.w600)),
        centerTitle: true,
        backgroundColor: lightModeBgColor,
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
          tooltip: 'Kembali ke halaman product',
          onPressed: () {
            // handle the press
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: lightModeBgColor,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          children: [
            FutureBuilder(
                future: delay,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return 
                    Column(
                      children:listOutlet.listStore.map((store) {
                          return  Container(
                            width: double.infinity,
                        margin: EdgeInsets.only(bottom: 20),
                        padding:
                            EdgeInsets.symmetric(horizontal: 13, vertical: 11),
                        decoration: BoxDecoration(
                          color: (store.distance ?? 0) > 25 ? alertColorSurface : lightModeBgColor,
                            borderRadius: BorderRadius.circular(11),
                            border: Border.all(
                              color:   (store.distance ?? 0) > 25 ? alertColor : neutral20 ,
                            )),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${store.name}",
                              style: headerTextStyle.copyWith(
                                  fontSize: 15, fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(" ${(store.distance ?? 0) < 1 ? (((store.distance ?? 0) * 1000).toInt()) : store.distance!.toInt()} ${(store.distance ?? 0) < 1 ? 'M' : 'KM'} dari jarak lokasi anda",
                                style: subtitleTextStyle.copyWith(fontSize: 13))
                          ],
                        ),
                      );
                      
                    }).toList()
                    );
                    
                  } else {
                    return Skeleton();
                  }
                })
 
            // Container(
            //   margin: EdgeInsets.only(bottom: 20),
            //   padding: EdgeInsets.symmetric(horizontal: 13, vertical: 11),
            //   decoration: BoxDecoration(
            //       color: alertColorSurface,
            //       borderRadius: BorderRadius.circular(11),
            //       border: Border.all(
            //         color: alertColor,
            //       )),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         "Fresmarket cileunyi",
            //         style: headerTextStyle.copyWith(
            //             fontSize: 15, fontWeight: FontWeight.w600),
            //       ),
            //       SizedBox(
            //         height: 8,
            //       ),
            //       Text("5km dari jalan raya cikalang 312",
            //           style: subtitleTextStyle.copyWith(fontSize: 13))
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
