import 'package:flutter/material.dart';
class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController _ipController = TextEditingController(text: 'http://164.52.198.75:8081');
  bool toggleState = false;
  bool toggleFaceState = false;
  String _newIpAddress = '';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Settings', style:TextStyle(fontSize : 30)),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10,),
          const ListTile(
            title: Text('IP Address', style: TextStyle(fontWeight: FontWeight.bold),),
          ),
           Padding(
             padding: const EdgeInsets.all(15),
             child: TextField(
            controller: _ipController,
            onChanged: (newValue){
              _newIpAddress = newValue;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              )
            ),
             ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: ElevatedButton(
            onPressed: (){
              setState(() {
                  _ipController.text = _newIpAddress;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.cyan[500],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )
            ),
            child:const Text('Change IP Adress', style: TextStyle(color:Colors.white),),
          ),
          ),
          ListTile(
            title : const Text('Bypass OTP',style: TextStyle(fontWeight: FontWeight.bold),),
            trailing: toggleState == true ?
            IconButton(icon:
            const Icon(Icons.toggle_on),
              color: Colors.blue,
              iconSize: 40,
              padding: const EdgeInsets.all(8),
              onPressed: (){}, ):
            IconButton(
              icon: const Icon(Icons.toggle_off),
              color: Colors.grey,
              iconSize: 40,
              padding: const EdgeInsets.all(8),
              onPressed: () {},
            ),
              onTap: () {
                setState(() {
                  toggleState = !toggleState;
                });
              }
            // trailing: ,
          ),
          ListTile(
            title: const Text(
              'Bypass Photo',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            trailing: toggleFaceState
                ? IconButton(
              icon: const Icon(Icons.toggle_on),
              color: Colors.blue,
              iconSize: 40,
              padding: const EdgeInsets.all(8),
              onPressed: () {},
            )
                : IconButton(
              icon: const Icon(Icons.toggle_off),
              color: Colors.grey,
              iconSize: 40,
              padding: const EdgeInsets.all(8),
              onPressed: () {},
            ),
            onTap: () {
              setState(() {
                toggleFaceState = !toggleFaceState;
              });
            },
          ),

          const ListTile(
            title: Text('App version', style: TextStyle(fontWeight: FontWeight.bold),),
            trailing: Text('3.0.22',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
          ),
        ],
      ),

    );
  }
}
