import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddNewRecipient extends StatefulWidget {
  const AddNewRecipient({super.key});

  @override
  State<AddNewRecipient> createState() => _AddNewRecipientState();
}


class _AddNewRecipientState extends State<AddNewRecipient> {
  TextEditingController _emailController = TextEditingController();

  //bool isChecked1=true;
  bool isChecked2 = false;
  bool isChecked3 = false;
  String _dropdownValue = 'Choose Organisation';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 20,
        ),
        Text(
          "Signatory Email",
          textAlign: TextAlign.left,
        ),
        Padding(
          padding: EdgeInsets.all(15),
          child: TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
                hintText: "Enter email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  gapPadding: 1.0,
                )),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(0),
          child: Container(
            width: 280,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey), // Border color
              borderRadius: BorderRadius.circular(8), // Border radius
              color: Colors.cyan, // Background color of the dropdown button
            ),
            child: DropdownButton(
              items: const [
                DropdownMenuItem<String>(
                  child: Text('Self', style: TextStyle(color: Colors.white)),
                  value: "Self",
                ),
                DropdownMenuItem<String>(
                    child: Text(
                      'Organisation',
                      style: TextStyle(color: Colors.white),
                    ),
                    value: "Organisation"),
                DropdownMenuItem<String>(
                    child: Text(
                      'Choose Organisation',
                      style: TextStyle(color: Colors.white),
                    ),
                    value: "Choose Organisation"),
              ],
              value: _dropdownValue,
              onChanged: dropdownCallback,
              hint: Text('Choose Organization'),
              focusColor: Colors.cyan,
              underline: Container(
                // To hide the default underline
                height: 0,
                color: Colors.transparent,
              ),
              //  dropdownColor: Colors.cyan,
              //  isExpanded: true,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        _buildAddNewRecipientPageContents('Signature Mandatory', true),
        _buildAddNewRecipientPageContents('Allow comments', isChecked2),
        _buildAddNewRecipientPageContents('Allow anyone can sign', isChecked3),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children:[
       _buildElevatedButton('Cancel', Colors.red),
        _buildElevatedButton("Confirm", Colors.cyan),
      ],
    ),
    ],
    );
  }

  Widget _buildAddNewRecipientPageContents(String text, bool? _isChecked) {
    return CheckboxListTile(
        title: Text(text),
        controlAffinity: ListTileControlAffinity.trailing,
        value: _isChecked,
        onChanged: (bool? value) {
          setState(() {
            if (text == 'Allow comments') {
              isChecked2 = value ?? false;
            } else if (text == 'Allow anyone can sign') {
              isChecked3 = value ?? false;
            }
          });
        });
  }

  void dropdownCallback(String? _selectedValue) {
    if (_selectedValue is String) {
      setState(() {
        _dropdownValue = _selectedValue;
      });
    }
  }

  _buildElevatedButton(String text, MaterialColor col) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor:col,
        foregroundColor: Colors.white,
        minimumSize: Size(50,30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        )
      ),
      onPressed: () {},
      child: Text(text),
    );
  }
}

void addNewRecipients(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: AddNewRecipient(),
        );
      });
}
