import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_code/scan_qr.dart';
import 'package:widget_code/src/dialogHelper.dart';
import 'notification_page.dart';
import 'profile_page.dart';
import 'dashboard_page.dart';
import 'sign_document.dart';
import 'revok_certificate.dart';
import 'show_qr_code.dart';
import 'package:widget_code/MRZ data/retrievedData.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:widget_code/connectivity/connectivity.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'user_provider.dart';
import 'models/user.dart';
import 'service calls/getCertificateDetailsBySubscriberUniqueId.dart';
import 'screens/digitalIdVault.dart';

class MainHomePage extends StatefulWidget {
 // final User user;
  const MainHomePage({super.key});
  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage>
    with SingleTickerProviderStateMixin {
  DialogHelper dialogHelper = DialogHelper();
  late TabController _tabController;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _checkNetworkConnection(context);
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {
        selectedIndex = _tabController.index;
      });
    });

  }

  //checking connectivity throughout the app

 Future<void> _checkNetworkConnection(BuildContext context) async{
    ConnectivityCode connectivityCode = ConnectivityCode();
    var connectivityResult = await connectivityCode.getConnection();

    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "Unable to connect to internet",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      print('No internet connection.');
      return;
    }

  }

  //icon first and text next in settings
  Widget _buildFrontTile(IconData icons, String text) {
    return ListTile(
      leading: Icon(
        icons,
        color: Colors.white,
      ),
      title: Text(text, style: const TextStyle(color: Colors.white)),
    );
  }

  // text first and icon next in settings
  Widget _buildBackTile(String text, IconData icons) {
    return ListTile(
      title: Text(text, style: const TextStyle(color: Colors.white)),
      trailing: Icon(
        icons,
        color: Colors.white,
      ),
    );
  }

//for the container that contains details like name, credits etc

  Widget _buildInfoContainer(Uint8List bytes) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    User? user = userProvider.user;
    return Container(
      constraints: const BoxConstraints(),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFFFFFF),
            Color(0xFF179F9F),
          ],
          stops: [0.2, 1.0],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           ClipOval(
             child : Image.memory(
               bytes,
               fit: BoxFit.cover,
               height: 80,
               width: 80,
             )
           ),
            SizedBox(width: 20,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(user!.primaryIdentifier,
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.normal)),
                SizedBox(
                  height: 4,
                ),
                Text(
                  'credits:',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  'subscription validity',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  'Total subscription',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  'One time activation',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  'Last Login',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //function for building grids for each tab
  Widget _buildTabBarView(
      List<String> imagePaths, TabController tabController, Uint8List bytes) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: imagePaths.length,
      itemBuilder: (BuildContext context, int index) {
        String imageName = _getImageName(imagePaths[index]);
        return GestureDetector(
          onTap: () {
            final int tabIndex = tabController.index;
            _navigateToPage(tabIndex, index,bytes);
          },
          child: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              border: Border.all(
                color: Colors.black12,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  imagePaths[index],
                  width: 50,
                  height: 50,
                ),
                Text(
                  imageName,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  //function to get name of the image to place it under the image in every tab view controller grid
  String _getImageName(String imagePath) {
    List<String> parts = imagePath.split('/');
    String fileNameWithExtension = parts.last;
    List<String> fileNameParts = fileNameWithExtension.split('.');
    return fileNameParts.first;
  }

  //formating passport details like dob, expiry date etc
  String formatDateString(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  //for certificate
  Future<void> fetchDataAndShowModal(BuildContext context) async {
    try {
      await postCertificateData(context);
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  //navigation to different pages upon clicking each grid of tabs
  void _navigateToPage(int tabIndex, int index, Uint8List bytes) {

    switch (tabIndex) {
      case 0:
        switch (index) {
          case 0:
            showProfilePage(context,bytes);
            break;
          case 1:
          fetchDataAndShowModal(context);
            break;
          case 2:
            dialogHelper.showPins(context);
            break;
          case 3:
            dialogHelper.showPins(context);
          case 4:
            // Get.to(
            //   () => const RevokeCertificate(),
            //   transition: Transition.circularReveal,
            //   duration: const Duration(seconds: 1),
            // );
            showRevokeCertificate(context);
            break;
        }
        break;
      case 1:
        switch (index) {
          case 0:
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const DashBoardPage()));
            break;
          case 1:
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SignDocumentPage()));
            break;
        }
        break;
      case 2:
        switch (index) {
          case 1:
            Navigator.push(context, MaterialPageRoute(builder: (context)=>DigitalIdVaultScreen()));
            break;
          case 2:
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => ShowQR()));
            break;
          case 3:
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => QRScanner()));
            break;
        }
        break;
      case 3:
        break;
    }
  }

  //list and funtion for carousel items at the bottom
  List<String> carouselImagePaths = [
    'images/assets/2.png',
    'images/assets/3.png',
    'images/assets/4.png',
    'images/assets/5.png',
    'images/assets/6.png',
    'images/assets/7.png',
  ];

  List<Widget> buildCarouselItems(List<String> imagePaths) {
    return imagePaths.map((imagePath) {
      return Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.contain,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    User? user = userProvider.user;
    String subscriberSelfieBase64 = user!.subscriberSelfie;
    Uint8List bytes = base64Decode(subscriberSelfieBase64);
    return GetMaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: AppBar(
            leading: const Icon(Icons.menu),
            title: Center(
              child: SizedBox(
                height: kToolbarHeight,
                width: kToolbarHeight,
                child: Image.asset(
                  'images/assets/MyTrustLogo@3x.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(
                  Icons.notifications_active_outlined,
                  color: Colors.cyan[400],
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NotificationPage()));
                },
              ),
            ],
          ),
        ),
       // backgroundColor: Colors.cyan[50],
        body: Column(
          children: [
            _buildInfoContainer(bytes),
            const SizedBox(height: 10),
            SizedBox(
              height: 100,
              child: TabBar(
                dividerColor: Colors.transparent,
                controller: _tabController,
                labelPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                indicatorColor: Colors.cyan,
                tabs: [
                  Tab(
                    icon: Transform.scale(
                      scale: 1.8,
                      child: Image.asset('images/assets/MyID.png'),
                    ),
                  ),
                  Tab(
                    icon: Transform.scale(
                      scale: 1.8,
                      child: Image.asset('images/assets/DigitalSignature.png'),
                    ),
                  ),
                  Tab(
                    icon: Transform.scale(
                      scale: 1.8,
                      child: Image.asset('images/assets/digitalVault.png'),
                    ),
                  ),
                  Tab(
                    icon: Transform.scale(
                      scale: 1.8,
                      child: Image.asset('images/assets/digitalForum.png'),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          _buildTabBarView([
                            'images/assets/profile.png',
                            'images/assets/certificate info.png',
                            'images/assets/change pin.png',
                            'images/assets/reset pin.png',
                            'images/assets/revoke certificate.png',
                            'images/assets/totp.png',
                          ], _tabController,bytes),
                          _buildTabBarView([
                            'images/assets/profile.png',
                            'images/assets/certificate info.png',
                            'images/assets/change pin.png',
                            'images/assets/reset pin.png',
                            'images/assets/revoke certificate.png',
                          ], _tabController,bytes),
                          _buildTabBarView([
                            'images/assets/profile.png',
                            'images/assets/certificate info.png',
                            'images/assets/show qr code.png',
                            'images/assets/Scan QR Code.png',
                          ], _tabController, bytes),
                          ListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              ListTile(
                                title: const Text('Social Beneficiary Form'),
                                trailing: Text(
                                  'view',
                                  style: TextStyle(color: Colors.cyan[200]),
                                ),
                                shape: const RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Colors.white24,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 200),
                      child: CarouselSlider(
                        items: buildCarouselItems(carouselImagePaths),
                        options: CarouselOptions(
                          autoPlay: true,
                          aspectRatio: 2.0,
                          enlargeCenterPage: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
