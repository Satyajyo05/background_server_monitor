import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:widget_code/user_provider.dart';
import 'main_home_page.dart';
import 'models/user.dart';
import 'package:intl/intl.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  void _toggle() => animationController.isCompleted
      ? animationController.reverse()
      : animationController.forward();

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  Widget _buildFrontTile(IconData icons, String text) {
    return ListTile(
      leading: Icon(
        icons,
        color: Colors.black,
      ),
      title: Text(text, style: const TextStyle(color: Colors.black)),
    );
  }

  Widget _buildBackTile(String text, IconData icons) {
    return ListTile(
      title: Text(text, style: const TextStyle(color: Colors.black)),
      trailing: Icon(
        icons,
        color: Colors.black,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    User? user = userProvider.user;
    String subscriberSelfieBase64 = user!.subscriberSelfie;
    Uint8List bytes = base64Decode(subscriberSelfieBase64);
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget? _) {
        var scale = 1 - (animationController.value * 0.3);
        var maxSide = MediaQuery.of(context).size.width;
        var side = (maxSide * (animationController.value * 0.6));
        return GestureDetector(
          onTap: _toggle,
          child: Stack(
            children: [
              Material(
                color: Colors.transparent,
                child: SafeArea(
                  child: Theme(
                    data: ThemeData(brightness: Brightness.dark),
                    child: SizedBox(
                      width: double.infinity,
                      height: double.infinity,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xFFFFFFFF),
                              Color(0xFF179F9F),
                            ],
                            stops: [0.05, 1.0],
                          ),
                        ),
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            ListTile(
                              title: Column(
                                //mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ClipOval(
                                      child: Image.memory(
                                    bytes,
                                    fit: BoxFit.cover,
                                    height: 80,
                                    width: 80,
                                  )),
                                  SizedBox(width: 10),
                                  Text(
                                    'Welcome ${user!.primaryIdentifier}',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              color: Colors.black,
                              thickness: 2,
                            ),
                            _buildFrontTile(Icons.person,
                                'Profile'), //for icons at the front
                            _buildFrontTile(Icons.settings, 'Settings'),
                            _buildFrontTile(Icons.line_style, 'Appearances'),
                            _buildBackTile(
                                'About MyTrust App',
                                Icons
                                    .arrow_forward_ios), //for icons at the trailing end
                            _buildBackTile(
                                'Share MyTrust App', Icons.arrow_forward_ios),
                            _buildBackTile('Feedback', Icons.arrow_forward_ios),
                            _buildFrontTile(Icons.logout, 'Logout'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Transform(
                transform: Matrix4.identity()
                  ..translate(side)
                  ..scale(scale),
                alignment: Alignment.centerLeft,
                child: const MainHomePage(),
              )
            ],
          ),
        );
      },
    );
  }
}
