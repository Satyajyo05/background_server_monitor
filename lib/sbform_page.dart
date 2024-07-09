import 'package:flutter/material.dart';
class SBCFormPage extends StatefulWidget {
  const SBCFormPage({super.key});

  @override
  State<SBCFormPage> createState() => _SBCFormPageState();
}

class _SBCFormPageState extends State<SBCFormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title : const Text('SBC form')
      ),
    );
  }
}

