import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:file_picker/file_picker.dart';
import 'package:widget_code/pinPage.dart';
import 'src/dialogHelper.dart';
import 'Sign Document Nav Pages/QuickSignPage.dart';
import 'show_qr_code.dart';
import 'Sign Document Nav Pages/addNewRecipient.dart';

class SignDocumentPage extends StatefulWidget {
  const SignDocumentPage({super.key});

  @override
  State<SignDocumentPage> createState() => _SignDocumentPageState();
}

class _SignDocumentPageState extends State<SignDocumentPage> {
  bool isChecked = false;
  bool isDisableChecked = false;
  bool isAllSignsreqChecked = true;
  // DialogHelper dialogHelper = DialogHelper();


  Widget _buildListItem(String title, bool checked, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 16,
            ),
          ),
          trailing: checked
              ? const Icon(
                  Icons.check_box,
                  size: 30,
                  color: Colors.grey,
                )
              : const Icon(
                  Icons.check_box_outline_blank,
                  size: 30,
                  color: Colors.grey,
                ),
             onTap: onTap,
        ),
      ),
    );
  }

  // disable order and all signs required
  Widget _openFields() {
    return Column(
      children: [
        _buildListItem(
          'Disable Order',
          isDisableChecked,
          () {
            setState(() {
              isDisableChecked = !isDisableChecked;
            });
          },
        ),
        _buildListItem(
          'All Signs Req.',
          isAllSignsreqChecked,
          () {
            setState(() {
              isAllSignsreqChecked = !isAllSignsreqChecked;
            });
          },
        ),
      ],
    );
  }

  // No of signs required list tile
  Widget _openSingleField() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          title: const Text('No of Signs required'),
          trailing: Container(
            width: 100,
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: '',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget _buildTextFormField() {
  //   return TextFormField(
  //     controller: _enterPin,
  //     initialValue: null,
  //   );
  // }

  Widget _buildButton(String text, double w, double h, int index) {
    return Container(
      width: w,
      height: h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xFF179F9F),
      ),
      // color: Color(0xFF179F9F),
      child: ListTile(
        onTap: () {
          if(index == 1)
         showQuickSign(context);
          else if(index == 0)
          Navigator.push(context,MaterialPageRoute(builder: (context)=>ShowQR()));
         else if(index == 2)
            addNewRecipients(context);
        },
        title: Center(
            child: Text(
          text,
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        )),
      ),
    );
  }

  //picking file from device
  void _pickFile(BuildContext context) async{
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      PlatformFile file = result.files.first;
      print('File name: ${file.name}');
      print('File path: ${file.path}');
    } else {
      print("picked nothing");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign New Document'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: GestureDetector(
                onTap: ()=> _pickFile(context),
                child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'images/assets/add_doc.png',
                        width: 50,
                        height: 50,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text('Upload Document'),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ),
            _CustomListTile(
              text: 'Days to complete',
              icon: Icons.rectangle_outlined,
              onTap: () {},
            ),
            _CustomListTile(
              text: 'Automatic Remainders',
              icon: Icons.toggle_off_outlined,
              onTap: () {},
            ),
            _CustomListTile(
              text: 'Add Signatories',
              icon: isChecked ? Icons.check_box : Icons.check_box_outline_blank,
              onTap: () {
                setState(() {
                  isChecked = !isChecked;
                });
              },
            ),
            if (isChecked) _openFields(),
            if (isChecked && !isAllSignsreqChecked) _openSingleField(),
            if (!isChecked)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildButton("continue", 150, 40,0),
                  _buildButton("Quick Sign", 150, 40,1),
                ],
              ),
            if (isChecked)
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildButton('Add New Recipient', 350, 40,2),
                  SizedBox(
                    height: 10,
                  ),
                  _buildButton('Continue', 350, 40,3),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _CustomListTile extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback onTap;

  const _CustomListTile({
    required this.text,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            leading: Text(
              text,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
            ),
            trailing: Icon(
              icon,
              size: 30,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}
