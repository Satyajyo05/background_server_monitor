import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class QuickSignPage extends StatefulWidget {
  const QuickSignPage({super.key});

  @override
  State<QuickSignPage> createState() => _QuickSignPageState();
}

class _QuickSignPageState extends State<QuickSignPage> {
  late List<String> _signingPin;
  late List<FocusNode> _signingPinFocusNodes;

  @override
  void initState() {
    super.initState();
    _signingPin = List.generate(4, (index) => '');
    _signingPinFocusNodes = List.generate(4, (index) => FocusNode());
  }

  @override
  void dispose() {
    for (var node in _signingPinFocusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  List<Widget> _buildSigningPinFields(List<String> pin, List<FocusNode> focusNodes) {
    return List.generate(4, (index) =>
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: TextField(
              keyboardType: TextInputType.number,
              maxLength: 1,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20.0, color: Colors.black),
              focusNode: focusNodes[index],
              onChanged: (value) {
                setState(() {
                  pin[index] = value;
                });
                if (value.isNotEmpty && index < focusNodes.length - 1) {
                  focusNodes[index].unfocus();
                  FocusScope.of(context).requestFocus(focusNodes[index + 1]);
                }
              },
              decoration: InputDecoration(
                counterText: "",
                contentPadding: const EdgeInsets.all(8.0),
                border:OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.teal, width: 2.0),
                )
              ),
            ),
          ),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20,),
          Text("Signing PIN"),
          SizedBox(height: 20,),
          Text("Please Enter Signing Certificate Pin"),
          SizedBox(height: 20,),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color : Colors.white,
                ),
                width: 250,
                height:200,
                child:Row(
                children: _buildSigningPinFields(_signingPin, _signingPinFocusNodes),
              ),
              ),
          ),
          SizedBox(height: 20,),
          FilledButton.tonal(
            onPressed: (){},
            child: Text('Submit'),
          )
        ],
      ),
    );
  }
}

void showQuickSign(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          width: 500,
          height: 400,
        child:QuickSignPage(),
        ),
      );
    },
  );
}
