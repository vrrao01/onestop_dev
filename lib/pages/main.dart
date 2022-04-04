// import 'package:blogss/Rssfeed.dart';
// import 'package:flutter/material.dart';
// import 'package:blogss/IPsettings.dart';
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Home(),
//     );
//   }
// }

import '../ipsettings/IPsettings.dart';
//import 'package:blogss/hosteldetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());
bool fg=true;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Thanks giving')),
        body: DropDown(),
      ),
    );
  }
}

class DropDown extends StatefulWidget {
  @override
  DropDownWidget createState() => DropDownWidget();
}

class DropDownWidget extends State {
  TextEditingController roomController = TextEditingController();
  TextEditingController blockController = TextEditingController();
  TextEditingController floorController = TextEditingController();
   hostelDetails hostel=hostelDetails("nothing", "--", "--=-=-===","something") ;
   String dropdownValue="No Value";
final _keyform= GlobalKey<FormState>();
  List <String> spinnerItems = [
    'No Value',
    'Barak',
    'Umiam',
    'Brahmaputra',
    'Manas',
    'Dihing',
    'Dibang',
    'Married Scholars',
    'Siang',
    'Dhansiri',
    'Subhansiri',
    'Kapili',
    'Kameng'
  ] ;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child : Form(
         key: _keyform,
         child: Center(
           child :
           Padding(
          padding: const EdgeInsets.all(8.0),
            child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),

              child: DropdownButton<String>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_drop_down),
                iconSize: 24,
                elevation: 16,
                style:const TextStyle(color: Colors.red, fontSize: 18),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (data) {
                  setState(() {
                    dropdownValue = data!;
                     hostel.hostelName=dropdownValue;
                  });
                },

                items: spinnerItems.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),

            Text('Selected Hostel = ' + dropdownValue,
                style: const TextStyle
                  (fontSize: 22,
                    color: Colors.black)),
            Padding(
              padding: const EdgeInsets.all(8.0),

              child: TextFormField(
                // Tell your textfield which controller it owns
                  validator: (value){
                    if(value==null || value.isEmpty){return "Remember your room number correctly";}
                    return null;
                  },
                  controller: roomController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  // controller.text = someString;
                  // controller.selection = TextSelection.fromPosition(TextPosition(offset: controller.text.length));
                  // // Every single time the text changes in a
                  // TextField, this onChanged callback is called
                  // and it passes in the value.
                  //
                  // Set the text of your controller to
                  // to the next value.
                  onChanged: (v){ roomController.text = v;hostel.roomNo=v;roomController.selection = TextSelection.fromPosition(TextPosition(offset: roomController.text.length));},
                  decoration: const InputDecoration(
                    labelText: 'Room No.',

                  )
              ),
            ),
Padding(
  padding: const EdgeInsets.all(8.0),
  child:   TextFormField(
      validator: (value){
        if(value==null || value.isEmpty){return "remember your block number correctly";}
        return null;
      },
    controller: blockController,
    keyboardType: TextInputType.text,
      onChanged: (v){ blockController.text = v;hostel.block=v;blockController.selection = TextSelection.fromPosition(TextPosition(offset: blockController.text.length));},
      decoration: const InputDecoration(
        labelText: 'Block No.',

      )
  ),
),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                  validator: (value){
                    if(value==null || value.isEmpty){return "remember your floor number correctly";}
                    return null;
                  },
                  controller: floorController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChanged: (v){ floorController.text = v;hostel.floor=v;floorController.selection = TextSelection.fromPosition(TextPosition(offset: floorController.text.length));},
                  decoration: const InputDecoration(
                    labelText: 'Floor No.',

                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(onPressed: (){
                if (_keyform.currentState!.validate()){
                fg=false;
                Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage(),settings: RouteSettings(
                  arguments: hostel,
                )),
              );}}, child: const Text("Load Data"),color: Colors.blue[600],),
            )

          ]),
        ),
      ),
    ),);
  }
}

