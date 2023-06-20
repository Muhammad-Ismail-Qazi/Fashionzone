import 'package:flutter/material.dart';

class MyCustomListTileComponent extends StatefulWidget {
  String servicesName;
  MyCustomListTileComponent({Key? key, required this.servicesName})
      : super(key: key);

  @override
  State<MyCustomListTileComponent> createState() =>
      _MyCustomListTileComponentState();
}

class _MyCustomListTileComponentState extends State<MyCustomListTileComponent> {
  bool selection =false;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      child: ListTile(
        minVerticalPadding: 20,
        contentPadding: const EdgeInsets.all(0),
        leading: Checkbox(
          value: selection,
          activeColor: const Color.fromARGB(247, 84, 74, 158),
          onChanged: (value) {
            setState(() {
              if (selection==false){
                selection=true;
              }
              else if (selection=true){
                selection=false;
              }
            });
          },
        ),
        title: Text(widget.servicesName,
            style: const TextStyle(fontSize: 16, color: Colors.black45)),
        trailing: Expanded(
          child: SizedBox(
            height: 100,
            width: 100,
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Material(
                elevation: 5,
                shadowColor: Colors.black,
                child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        labelText: 'Price',
                        labelStyle: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16,
                            color: Color.fromARGB(247, 84, 74, 158)),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(247, 84, 74, 158),
                              width: 3),
                        ),
                        border: OutlineInputBorder()),
                    style: const TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 16,
                        color: Color.fromARGB(247, 84, 74, 158)),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Price.';
                      }
                      return null;
                    }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
