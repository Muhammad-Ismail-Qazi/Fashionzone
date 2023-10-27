import 'package:fashionzone/Components/BottomNavigationBarComponent.dart';
import 'package:flutter/material.dart';

import '../Components/AppBarComponent.dart';
import '../Components/DrawerComponent.dart';
class ThankYou extends StatelessWidget {
  const ThankYou({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const   Color.fromARGB(247, 245, 237, 237),
      appBar: const MyCustomAppBarComponent(appBarTitle: 'Good Bye :)'),
      drawer: const MyCustomDrawerComponent(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'images/logo.png',
              height: MediaQuery.of(context).size.height*0.25,
              width: MediaQuery.of(context).size.width*0.25,
          ),
         const  SizedBox(
            height: 20,
          ),
          const Text(
            'THANK YOU',
            style: TextStyle(
               color: Colors.black45,
                fontSize: 40,
                fontWeight: FontWeight.w600),
          ),
          const Padding(
            padding: EdgeInsets.all(14.0),
            child: Center(
              child: Text(
                'Your reservation has been processed and will response soon. we are glad you have joined FASHIONZONE. To view your reservation please check the notifaction bell in case of any query or complain plese feel free to contact us',
                style: TextStyle(fontSize:  16, fontFamily: 'Poppins',color: Colors.black45),
              ),
            ),
          )
        ],
      ),
      // bottomNavigationBar: const MyCustomBottomNavigationBar(),
    );
  }
}
