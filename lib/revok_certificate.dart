import 'package:flutter/material.dart';

Future<void> showRevokeCertificate(BuildContext context) {
  TextEditingController controller = TextEditingController();
  return showModalBottomSheet(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 10),
              Text("Revoke Certificate"),
              Divider(
                color: Colors.cyan,
                thickness: 2,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text("Remarks", style: TextStyle(fontWeight: FontWeight.w500)),
                    SizedBox(height: 10),
                    Container(
                      height: 300.0,
                      child: TextFormField(
                        controller: controller,
                        maxLines: null,
                        expands: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.cyan),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.cyan),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(color: Colors.cyan),
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: (){},
                        child: Text('Revoke my certificate'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.cyan,
                          foregroundColor: Colors.white,
                          shape:RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          minimumSize: Size(300,40) //width, height
                        ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Example'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              showRevokeCertificate(context);
            },
            child: Text('Show Bottom Sheet'),
          ),
        ),
      ),
    );
  }
}
