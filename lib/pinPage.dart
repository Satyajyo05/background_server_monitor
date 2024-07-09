import 'package:flutter/material.dart';

class PinEntryBottomSheet extends StatefulWidget {
  @override
  _PinEntryBottomSheetState createState() => _PinEntryBottomSheetState();
}

class _PinEntryBottomSheetState extends State<PinEntryBottomSheet> {
  bool _obscureTextCurrent = true;
  bool _obscureTextNew = true;
  bool _obscureTextReEnter = true;

  final TextEditingController _currentPinController = TextEditingController();
  final TextEditingController _newPinController = TextEditingController();
  final TextEditingController _reEnterPinController = TextEditingController();

  void _toggleCurrentPinVisibility() {
    setState(() {
      _obscureTextCurrent = !_obscureTextCurrent;
    });
  }

  void _toggleNewPinVisibility() {
    setState(() {
      _obscureTextNew = !_obscureTextNew;
    });
  }

  void _toggleReEnterPinVisibility() {
    setState(() {
      _obscureTextReEnter = !_obscureTextReEnter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Please Enter PIN',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Your services will get secured with this PIN',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            _buildPinInputField(
              controller: _currentPinController,
              labelText: 'Please Enter Current Pin',
              obscureText: _obscureTextCurrent,
              toggleVisibility: _toggleCurrentPinVisibility,
            ),
            SizedBox(height: 20),
            _buildPinInputField(
              controller: _newPinController,
              labelText: 'Please Set New PIN',
              obscureText: _obscureTextNew,
              toggleVisibility: _toggleNewPinVisibility,
            ),
            SizedBox(height: 20),
            _buildPinInputField(
              controller: _reEnterPinController,
              labelText: 'Please Re-Enter New PIN',
              obscureText: _obscureTextReEnter,
              toggleVisibility: _toggleReEnterPinVisibility,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPinInputField({
    required TextEditingController controller,
    required String labelText,
    required bool obscureText,
    required VoidCallback toggleVisibility,
  }) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: labelText,
              border: OutlineInputBorder(),
            ),
          ),
        ),
        IconButton(
          icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
          onPressed: toggleVisibility,
        ),
      ],
    );
  }
}

void showPinDialog(BuildContext context) {
  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.45,
        minChildSize: 0.0,
        maxChildSize: 0.8,
        expand: false,
        builder: (context, scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: PinEntryBottomSheet(),
          );
        },
      );
    },
  );
}
