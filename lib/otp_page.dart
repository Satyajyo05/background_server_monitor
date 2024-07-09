import 'dart:async';
import 'package:flutter/material.dart';
import 'package:widget_code/main.dart';
import 'digital_onboarding_page.dart';
import 'animated_drawer.dart';
import 'package:widget_code/main_home_page.dart';
import 'service calls/getSubscriberOnboarding.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  late List<String> _mobileOtp;
  late List<String> _emailOtp;
  late List<FocusNode> _mobileFocusNodes;
  late List<FocusNode> _emailFocusNodes;
  int _timerSeconds = 30;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _mobileOtp = List.generate(6, (index) => '');
    _emailOtp = List.generate(6, (index) => '');
    _mobileFocusNodes = List.generate(6, (index) => FocusNode());
    _emailFocusNodes = List.generate(6, (index) => FocusNode());
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    for (var node in _mobileFocusNodes) {
      node.dispose();
    }
    for (var node in _emailFocusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timerSeconds > 0) {
          _timerSeconds--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Center(
          child: Text(
            'OTP Verification',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Padding(
        padding:
        EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Enter OTP sent to your mobile:',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: _buildOTPInputFields(
                            _mobileOtp, _mobileFocusNodes),
                      ),
                      const SizedBox(height: 20.0),
                      const Text(
                        'Enter OTP sent to your email:',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: _buildOTPInputFields(
                            _emailOtp, _emailFocusNodes),
                      ),
                      const SizedBox(height: 20.0),
                      _timerSeconds > 0
                          ? Text('Resend the code in $_timerSeconds seconds')
                          : ElevatedButton(
                        onPressed: () {

                          setState(() {
                            _timerSeconds = 30; // Reset timer
                            _startTimer(); // Start timer again
                          });
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
                        child: const Text('Resend OTP', style: TextStyle(color: Colors.white),),
                      ),

                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10,),
              ElevatedButton(
                onPressed: (){
                 // Navigator.push(context, MaterialPageRoute(builder: (context)=> const MainHomePage()));
                  postSubscriberData(context);
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
                child: const Text('Verify', style: TextStyle(color: Colors.white),),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildOTPInputFields(
      List<String> otp, List<FocusNode> focusNodes) {
    return List.generate(
      6,
          (index) => Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextField(
            keyboardType: TextInputType.number,
            maxLength: 1,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20.0, color: Colors.black),
            focusNode: focusNodes[index],
            onChanged: (value) {
              setState(() {
                otp[index] = value;
              });

              if (value.isNotEmpty && index < focusNodes.length - 1) {
                focusNodes[index].unfocus();
                FocusScope.of(context).requestFocus(focusNodes[index + 1]);
              }
            },
            decoration: InputDecoration(
              counterText: "",
              // filled: true,
              // fillColor: Colors.teal,
              contentPadding: const EdgeInsets.all(8.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.0),
                borderSide: const BorderSide(color: Colors.teal, width: 2.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.0),
                borderSide: const BorderSide(color: Colors.teal, width: 2.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.0),
                borderSide: const BorderSide(color: Colors.blue, width: 2.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
