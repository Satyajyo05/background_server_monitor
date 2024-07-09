import 'package:widget_code/otp_page.dart';
import 'settings_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_code/user_provider.dart';

final _formKey = GlobalKey<FormState>();
void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
        home: HomePage(),
      )));
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  String selectedState = 'All Countries';
  bool radioState1 = true;
  bool radioState2 = false;
  bool bottomSheetExpanded = false;
  bool dropDownState = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            const SizedBox(height: 10),
            _buildForm(),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  // Widget for the header section
  Widget _buildHeader() {
    return Stack(
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
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsPage()),
                  );
                },
                icon: const Icon(
                  Icons.settings,
                  size: 32,
                ),
                color: Colors.black.withOpacity(1.0),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Widget for the form section
  Widget _buildForm() {
    return Container(
      constraints: BoxConstraints(
        maxWidth: double.infinity,
        maxHeight: MediaQuery.of(context).size.height * 0.6,
      ),
      child: Form(
        key: _formKey,
        child: Container(
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.cyan.shade800,
                Colors.cyan.shade500,
                Colors.cyan.shade200
              ],
              stops: const [0.4, 0.7, 1.0],
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Card(
            color: Colors.transparent,
            margin: const EdgeInsets.all(5),
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Create Account",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _buildOptions(),
                  const SizedBox(height: 10),
                  _buildTextField(
                    controller: _emailController,
                    hintText: 'Email',
                    prefixIcon: const Icon(Icons.email),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter your email';
                      } else if (!RegExp(
                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                          .hasMatch(value)) {
                        return 'Enter valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  _buildTextField(
                    controller: _phoneNumberController,
                    hintText: 'Phone Number',
                    prefixIcon: const Icon(Icons.phone),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter your Phone Number';
                      } else if (!RegExp(r'^(\+91[\s-]?)?[6-9]\d{9}$')
                          .hasMatch(value)) {
                        return 'Please Enter Valid Phone Number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          //   Navigator.push( //this is for navigating to other page but we need it to open up as bottom sheet
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => OtpPage()),
                          //   );

                          showModalBottomSheet(
                            shape: const CircleBorder(
                              side: BorderSide.none,
                            ),
                            context: context,
                            builder: (BuildContext context) {
                              return const OtpPage();
                            },
                          );
                        } else {
                          print('Enter details again');
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.teal.shade400),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
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
    );
  }

  // Widget for the options dropdown
  Widget _buildOptions() {
    return Container(
      height: 60,
      width: 380,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        leading:
            radioState1 ? const Icon(Icons.public) : const Icon(Icons.circle),
        title: Text(selectedState),
        trailing: IconButton(
          onPressed: () {
            setState(() {
              dropDownState = !dropDownState;
            });
            _openOptions(context);
          },
          icon: const Icon(Icons.arrow_drop_down),
        ),
      ),
    );
  }

  // Widget for a text field
  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required Icon prefixIcon,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: prefixIcon,
      ),
      validator: validator,
    );
  }

  // Function to open options bottom sheet
  void _openOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              GestureDetector(
                onTap: () => {
                  print("list tile tapped"),
                  setState(() {
                    radioState1 = true;
                    radioState2 = false;
                    selectedState = 'All Countries';
                  }),
                  Navigator.pop(context),
                },
                child: ListTile(
                  leading: const Icon(Icons.public),
                  title: const Text('All Countries'),
                  trailing: IconButton(
                    onPressed: () {},
                    icon: radioState1
                        ? const Icon(Icons.radio_button_checked_outlined)
                        : const Icon(Icons.radio_button_off),
                  ),
                ),
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
                  icon: radioState2
                      ? const Icon(Icons.radio_button_checked)
                      : const Icon(Icons.radio_button_off),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
