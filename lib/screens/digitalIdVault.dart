import 'package:flutter/material.dart';

class DigitalIdVaultScreen extends StatefulWidget {
  const DigitalIdVaultScreen({super.key});

  @override
  State<DigitalIdVaultScreen> createState() => _DigitalIdVaultScreenState();
}

class _DigitalIdVaultScreenState extends State<DigitalIdVaultScreen> {
  List<Map<String,String>> images = [
  {'imagePath':'images/assets/bg01.png', 'name':"Driving License",},
    { 'imagePath': 'images/assets/bg01.png', 'name':"Personal Identification",},
    { 'imagePath': 'images/assets/bg01.png', 'name':"Social Benefit card",},
    { 'imagePath':'images/assets/bg01.png', 'name':"Life Insurance",},
{'imagePath':'images/assets/bg01.png','name': "Tax Return",},
    { 'imagePath':'images/assets/bg01.png', 'name':"Birth Certificate",},
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_circle_left,color: Colors.cyan,size: 35,),
              ),
              SizedBox(width: 65),
              Center(child:Text("Digital ID Vault")),
            ],
          )
        ),
        body: Column(
          children: [
            Text('All Documents',style: TextStyle(fontSize: 20),),
            SizedBox(height: 10,),
            Expanded(
              child: _buildDocuments(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocuments() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 3,
        crossAxisSpacing: 3,
      ),
      itemCount: images.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Image.asset(images[index]['imagePath']!, width: 100,height: 100,),
                Text(images[index]['name']!),
              ],
            ),
          ),
        );
      },
    );
  }
}

