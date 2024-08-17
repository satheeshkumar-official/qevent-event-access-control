import 'package:flutter/material.dart';
import 'package:verification/screen/login_screen.dart';
import 'package:verification/screen/master/masterlogin.dart';
import 'user_detail.dart';
import 'package:firebase_core/firebase_core.dart';

// replace your apikey,appid,messagingsenderid,projectid form firebase
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: '', appId: '', messagingSenderId: '', projectId: ''));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(10, 23, 59, 28)),
        useMaterial3: true,
        fontFamily: 'Futura', // Change font to Futura
        primarySwatch: Colors.teal,
      ),
      home: LoginScreen(),
    );
  }
}

class Home extends StatefulWidget {
  final String d;

  const Home(this.d, {Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState(d);
}

class _HomeState extends State<Home> {
  final String d;
  int _selectedIndex = 0;

  final TextEditingController _searchText = TextEditingController();
  bool _isSearching = false;

  List<Map<String, String>> userData = [
    {'id': '4071838468', 'username': 'Asrin', 'place': 'New York'},
    {'id': '4071836420', 'username': 'Gayathri', 'place': 'Los Angeles'},
    {'id': '4071905796', 'username': 'Nanthini', 'place': 'London'},
    {'id': '4071841540', 'username': 'Shifana', 'place': 'Paris'},
    {'id': ' 4071839492', 'username': 'Shobi', 'place': 'Tokyo'}
  ];

  List<Map<String, String>> _filteredUsers = [];

  _HomeState(this.d);

  @override
  void initState() {
    super.initState();
    _filteredUsers.addAll(userData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _searchBox(),
          Expanded(
            child: _isSearching ? _searchListView() : _eventGrid(),
          ),
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Colors.white,
      //   items: <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.event_note),
      //       label: 'Event',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.add),
      //       label: 'Pepols',

      //     ),
      //   ],
      //   currentIndex: _selectedIndex,
      //   selectedItemColor: Color.fromARGB(255, 63, 170, 89),
      //   onTap: _onItemTapped,
      // ),
    );
  }

  PreferredSize _appBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80),
      child: AppBar(
        title: Text('people'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          // IconButton(
          //   icon: Icon(Icons.qr_code_scanner),
          //   onPressed: () {
          //     print('QR code icon pressed');
          //   },
          // ),
          // IconButton(
          //   icon: Icon(Icons.person),
          //   onPressed: () {
          //     print('Profile icon pressed');
          //   },
          // ),
        ],
        flexibleSpace: Container(
          decoration: _boxDecoration(),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SafeArea(
            child: const SizedBox(height: 60),
          ),
        ),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      borderRadius: const BorderRadius.vertical(
        bottom: Radius.circular(20),
      ),
      gradient: LinearGradient(
        colors: [
          Color.fromARGB(255, 43, 129, 16),
          Color.fromARGB(255, 42, 173, 37)
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    );
  }

  Widget _searchBox() {
    widget.d;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          TextField(
            textAlign: TextAlign.start,
            controller: _searchText,
            onChanged: (value) {
              setState(() {
                _isSearching = value.isNotEmpty;
                _filteredUsers = userData.where((user) {
                  return d!.contains(value);
                }).toList();
              });
            },
            decoration: InputDecoration(
              filled: true,
              fillColor: Color.fromRGBO(230, 241, 234, 1),
              prefixIcon: const Icon(Icons.tag_faces_outlined),
              hintText: 'scan',
              contentPadding: const EdgeInsets.all(0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          if (_isSearching)
            InkWell(
              onTap: () {
                setState(() {
                  _searchText.clear();
                  _isSearching = false;
                  _filteredUsers.clear();
                  _filteredUsers.addAll(userData);
                });
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.close),
              ),
            ),
        ],
      ),
    );
  }

  Widget _searchListView() {
    return ListView.builder(
      itemCount: _filteredUsers.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: ListTile(
              title: Text(
                _filteredUsers[index]['username']!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              subtitle: Text(
                _filteredUsers[index]['place']!,
                style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontSize: 16,
                ),
              ),
              leading: CircleAvatar(
                backgroundImage: AssetImage(
                    'assets/images/${_filteredUsers[index]['username']}.jpg'),
              ),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        UserDetailsPage(user: _filteredUsers[index]),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _eventGrid() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.1,
        ),
        itemCount: userData.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(
                      'assets/images/${userData[index]['username']}.png'),
                ),
                SizedBox(height: 8),
                Text(
                  userData[index]['username']!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  userData[index]['place']!,
                  style: TextStyle(
                    fontStyle: FontStyle.normal,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

void _showUserDetails(BuildContext context, Map<String, String> user) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => UserDetailsPage(user: user),
    ),
  );
}
