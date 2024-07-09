import 'package:flutter/material.dart';
class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifications', style: TextStyle(fontWeight: FontWeight.w400),),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('images/assets/notification_info_image.png',width: 400,height: 300,),
          const Text('No notifications', style: TextStyle(fontSize: 20),),
        ],
      ),
    );
  }
}