import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:widget_code/MRZ data/retrievedData.dart';
import 'package:widget_code/user_provider.dart';

import 'models/user.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildImage(String path) {
    return Center(
      child: Image.asset(
        path,
        width: 250,
        height: 250,
        fit: BoxFit.contain,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    User? user = userProvider.user;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Digital Signature'),
        centerTitle: true,
      ),
      backgroundColor: Colors.cyan[50],
      body: Column(
        children: [
          Container(
            width: double.infinity, // Ensures the container occupies the full width of the screen
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.cyan.shade200,
                  Colors.cyan.shade300,
                  Colors.cyan.shade400
                ],
                stops: const [0.4, 0.7, 1.0],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Welcome Back',style: TextStyle(color: Colors.cyan[800]),),
                  Text('${user?.primaryIdentifier}',style: TextStyle(fontWeight: FontWeight.bold),),
                  //const Text( style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('Digital Signature Credits',style: TextStyle(color: Colors.cyan[800])),
                  const Text('10',style: TextStyle(fontWeight: FontWeight.bold),),
                  Text('Account Type',style: TextStyle(color:Colors.cyan[800])),
                  const Text('Self', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          Container(
            height: 100,
            color: Colors.grey[100],
            child: TabBar(
              dividerColor: Colors.transparent,
              controller: _tabController,
              labelPadding: const EdgeInsets.symmetric(horizontal: 0.0),
              indicatorColor: Colors.cyan,
              tabs: [
                Tab(
                  icon: Transform.scale(
                    scale: 1.8,
                    child: Image.asset('images/assets/Inprogress.png'),
                  ),
                ),
                Tab(
                  icon: Transform.scale(
                    scale: 1.8,
                    child: Image.asset('images/assets/completed.png'),
                  ),
                ),
                Tab(
                  icon: Transform.scale(
                    scale: 1.8,
                    child: Image.asset('images/assets/declined.png'),
                  ),
                ),
                Tab(
                  icon: Transform.scale(
                    scale: 1.8,
                    child: Image.asset('images/assets/expired.png'),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildImage('images/assets/no_docs.png'),
                  _buildImage('images/assets/no_docs.png'),
                  _buildImage('images/assets/no_docs.png'),
                  _buildImage('images/assets/no_docs.png'),
                ],
              ),
            ),
          ),
          const Spacer(), // Add a spacer to push the buttons up
          Column(
            children: [
              Container(
                color: Colors.grey[200],
                width: double.infinity,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Center(
                    child: Text('View all'),
                  ),
                ),
              ),
              Container(
                color: Colors.cyan,
               // width: double.infinity,
               //  decoration: BoxDecoration(
               //    borderRadius: BorderRadius.circular(10),
               //  ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0,horizontal: 10),
                  child: Center(
                    child: Text('Sign Document'),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
