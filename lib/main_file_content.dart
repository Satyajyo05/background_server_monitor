import 'package:flutter/material.dart';
import 'package:widget_code/otp_page.dart';
import 'settings_page.dart';

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
final _formKey = GlobalKey<FormState>();
void main() {
  runApp(const MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  String dropDownValue = 'Mosip Countries';
  // bool toggleState = false;
  // bool toggleFaceState = false;
  bool dropDownState = false;
  bool radioState1 =false;
  bool radioState2 =false;
  String selectedState = 'All Countries';
  // Widget _buildDropDown() {
  //   return SizedBox(
  //     width: double.infinity,
  //     height: 65,
  //     child: Container(
  //       decoration: BoxDecoration(
  //         border: Border.all(color: Colors.grey),
  //         borderRadius: BorderRadius.circular(10),
  //       ),
  //       child: Padding(
  //         padding: EdgeInsets.only(left: 10),
  //         child: DropdownButton<String>(
  //           value: dropDownValue,
  //           onChanged: (String? value) {
  //             setState(() {
  //               dropDownValue = value!;
  //             });
  //           },
  //           underline: Container(),
  //           icon: Icon(Icons.arrow_drop_down),
  //           iconSize: 36,
  //           elevation: 0,
  //           style: TextStyle(color: Colors.black),
  //           alignment: Alignment.centerRight,
  //           items: ['Mosip Countries', 'All Countries']
  //               .map<DropdownMenuItem<String>>((String value) {
  //             return DropdownMenuItem<String>(
  //               value: value,
  //               child: Text(
  //                 value,
  //                 style: TextStyle(color: Colors.white),
  //               ),
  //             );
  //           }).toList(),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildOptions() {
    return Container(
      height: 60,
      width: 380,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading: const Icon(Icons.public),
        title: Text(selectedState),
        trailing: IconButton(
          onPressed: () {
            setState(() {
              dropDownState = !dropDownState;
            });
            // if(dropDownState == true)
            _openOptions(context); // Pass the BuildContext to open the bottom sheet
          },
          icon: const Icon(Icons.arrow_drop_down),
        ),
      ),
    );
  }


  void _openOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.public),
                title: const Text('All Countries'),
                trailing: IconButton(
                  onPressed: () {
                    setState(() {
                      radioState1 = true;
                      radioState2 = false;
                      selectedState = 'All Countries';
                    });
                    Navigator.pop(context);
                  },
                  icon: radioState1 ? const Icon(Icons.radio_button_checked_outlined) : const Icon(Icons.radio_button_off),
                ),
                onTap: () {

                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.circle),
                title: const Text('Mosip Countries'),
                trailing: IconButton(
                  onPressed: () {
                    setState(() {
                      radioState1 = false;
                      radioState2 = true;
                      selectedState = 'Mosip Countries';
                    });
                    Navigator.pop(context);
                  },
                  icon: radioState2 ? const Icon(Icons.radio_button_checked) : const Icon(Icons.radio_button_off),
                ),
                onTap: () {

                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //actual representation doesn't require an appBar. Hence commented the whole code.
      // // key : _scaffoldKey,
      //  appBar: AppBar(
      //    backgroundColor: Colors.teal,
      //    centerTitle: true,
      //    actions: [
      //      IconButton(
      //        icon: Icon(Icons.settings),
      //        onPressed: () {
      //       _scaffoldKey.currentState!.openEndDrawer();
      //        },
      //      )
      //    ],
      //    title: SizedBox(
      //      height: kToolbarHeight,
      //      width: kToolbarHeight,
      //      child: Center(
      //        child: Image.asset(
      //          'images/MyTrustLogo.png',
      //          fit: BoxFit.contain,
      //        ),
      //      ),
      //    ),
      //  ),
      //  endDrawer: Drawer(
      //    backgroundColor: Colors.teal[50],
      //    shape : RoundedRectangleBorder(
      //      borderRadius: BorderRadius.circular(20),
      //    ),
      //    width: MediaQuery.of(context).size.width*0.7,
      //     child:  ListView(
      //      children: [
      //        ListTile(
      //          leading: Icon(Icons.person),
      //          title : Text('Profile'),
      //        ),
      //        Divider(color: Colors.black,),
      //        ListTile(
      //          title : Text('Bypass OTP'),
      //         trailing: toggleState == true ? IconButton(icon: Icon(Icons.toggle_on), color: Colors.blue, onPressed: (){}, ): Icon(Icons.toggle_off),
      //         onTap:  (){
      //            setState(() {
      //              toggleState = !toggleState;
      //            });
      //         },
      //         // trailing: ,
      //        ),
      //        Divider(color: Colors.black,),
      //         ListTile(
      //          title : Text('Bypass Face Recognition'),
      //          trailing: toggleFaceState == true ? IconButton(icon: Icon(Icons.toggle_on), color: Colors.blue, onPressed: (){}, ): Icon(Icons.toggle_off),
      //          onTap:  (){
      //            setState(() {
      //              toggleFaceState = !toggleFaceState;
      //            });
      //          },
      //          // trailing: ,
      //        ),
      //
      //      ],
      //    )
      //  ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset('images/assets/1.png'),
                Positioned(
                  top: 60.0,
                  right: 20.0,
                  child: Stack(
                    children: [
                      Container(
                        width: 50.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.cyan[600]!.withOpacity(1.0),
                        ),

                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context, MaterialPageRoute(builder: (context) => const SettingsPage()),
                          );
                        },
                        icon: const Icon(Icons.settings, size: 32,),
                        color: Colors.black.withOpacity(1.0),
                        // Set full opacity
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),
            Container(
              constraints: BoxConstraints(
                maxWidth: double.infinity,
                maxHeight: MediaQuery.of(context).size.height*0.6,
              ),
              child: Form(
                key: _formKey,
                child:Container(
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.cyan.shade800, Colors.cyan.shade500,Colors.cyan.shade200],//if u use cyan[900] it gives error as cyan[900] this type is nullable whereeas colors;[] expects non nullable colors
                        stops: const [
                          0.4,
                          0.7,
                          1.0,
                        ]//
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),

                  child: Card(
                    color : Colors.transparent, //if not used, u cannot see the applied gradient colors
                    margin: const EdgeInsets.all(5),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10,),
                          const Text("Create Account", style: TextStyle(fontSize: 25, color: Colors.white,),textAlign: TextAlign.start,),
                          const SizedBox(height: 10,),
                          _buildOptions(),
                          const SizedBox(height: 10),
                          TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                hintText: 'Email',
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                prefixIcon: const Icon(Icons.email),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter your email';
                                } else if (!RegExp(
                                    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                                    .hasMatch(value)) {
                                  return 'Enter valid email';
                                }
                                return null;
                              }),
                          const SizedBox(height: 10),
                          TextFormField(
                              controller: _phoneNumberController,
                              decoration: InputDecoration(
                                // labelText: 'Phone number',
                                // labelStyle: TextStyle(color: Colors.grey),
                                hintText: 'Phone Number',
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                prefixIcon: const Icon(Icons.phone),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter your Phone Number';
                                } else if (!RegExp(r'^(\+91[\s-]?)?[6-9]\d{9}$')
                                    .hasMatch(value)) {
                                  return 'Please Enter Valid Phone Number';
                                }
                                return null;
                              }),
                          const SizedBox(height: 10),
                          Center(
                            child:ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  //   Navigator.push( //this is for navigating to other page but we need it to open up as bottom sheet
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) => OtpPage()),
                                  //   );
                                  //
                                  showModalBottomSheet(
                                    shape: const CircleBorder(
                                      side: BorderSide.none,
                                    ),
                                    context: context,
                                    builder: (BuildContext context){
                                      return const OtpPage();
                                    },
                                  );

                                }
                                else {
                                  print('Enter details again');
                                }
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.teal.shade400),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                alignment: Alignment.center,
                              ),
                              child: const Text('Verify',
                                  style: TextStyle(color: Colors.white)),
                              // shape: RoundedRectangleBorder(
                              //   borderRadius: BorderRadius.circular(10),
                              // ),
                              // backgroundColor: Colors.teal.shade400,

                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
