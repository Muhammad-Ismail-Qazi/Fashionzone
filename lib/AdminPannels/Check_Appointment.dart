
import 'package:fashionzone/Components/DrawerComponent.dart';
import 'package:flutter/material.dart';
import 'Check_Customer_details.dart';

class CheckAppointment extends StatefulWidget {
  const CheckAppointment({Key? key}) : super(key: key);

  @override
  State<CheckAppointment> createState() => _CheckAppointmentState();
}

class _CheckAppointmentState extends State<CheckAppointment> with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: const Color.fromARGB(247, 84, 74, 158),
          backgroundColor: const Color.fromARGB(247, 84, 74, 158),
          iconTheme: const IconThemeData(color: Color.fromARGB(247, 84, 74, 158)),
          fontFamily: 'Poppins',
        ),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          drawer: const MyCustomDrawerComponent(),
          appBar: AppBar(
            leading: Builder(
              builder: (context) {
                return GestureDetector(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: const Icon(Icons.menu),
                );
              },
            ),
            backgroundColor: const Color.fromARGB(247, 84, 74, 158),
            title: const Center(child: Text("Fashionzone")),
            bottom: const TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                  text: "PENDING",
                ),
                Tab(
                  text: "COMPLETE",
                ),
              ],
            ),
          actions:const [
            Padding(
              padding: EdgeInsets.only(right: 14.0),
              child: Icon(Icons.notifications),
            )
          ],  
          ),
          body: TabBarView(

            children: [
              ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Material(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      elevation: 5,
                      child: ListTile(
                        leading: const CircleAvatar(
                          backgroundImage: AssetImage('images/ismail.jpg'),
                          radius: 50,
                        ),
                        title: const Text('Muhammad Ismail'),
                        subtitle: const Text('Hair, Color, Massage'),
                        trailing: const Icon(Icons.check_circle),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CheckAppointmentDetails(),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
              ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Material(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      elevation: 5,
                      child: ListTile(
                        leading: const CircleAvatar(
                          backgroundImage: AssetImage('images/ismail.jpg'),
                          radius: 50,
                        ),
                        title: const Text('Muhammad Ismail'),
                        subtitle: const Text('Hair, Color, Massage'),
                        trailing: const Icon(Icons.check_circle),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CheckAppointmentDetails(),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
