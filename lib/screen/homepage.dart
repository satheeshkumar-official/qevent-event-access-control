// import 'package:qevent/controller/user_controller.dart';
// import 'package:qevent/model/user_model.dart';
// import 'package:qevent/utils/session_manager.dart';
// import 'package:flutter/material.dart';
// import 'AddEventPage.dart'; // Import the AddEventForm widget
// import 'EditEventPage.dart'; // Import the EditEventPage widget

// class HomePage extends StatefulWidget {
//   @override
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   List<EventDetails> _events = [];
//   List<EventDetails> _filteredEvents = [];
//   TextEditingController _searchController = TextEditingController();
//   bool isLoading = true;

//   @override
//   void initState() {
//     _filteredEvents = _events;
//     super.initState();
//     initialize();
//   }

//   void initialize() async {
//     await fetchUsersData();
//     await getUserDetails();

//     setState(() {
//       isLoading = false;
//     });
//   }

//   Future<void> fetchUsersData() async {
//     await UserController().retrieveUsers().then((value) {
//       if (value.isNotEmpty) {
//         setState(() {
//           UserModel.allUsers = value;
//         });
//       }
//     });
//   }

//   Future<void> getUserDetails() async {
//     var id = await SessionManager().getUserId();
//     setState(() {
//       UserModel.userModelDetails =
//           UserModel.allUsers.firstWhere((element) => element.userId == id);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Events',
//           style: TextStyle(
//             fontSize: 18.0,
//             color: Colors.green,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(5.0),
//             child: TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 labelText: 'Search ',
//                 prefixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10),
//                   borderSide:
//                       BorderSide(color: Color.fromARGB(255, 215, 248, 215)),
//                 ),
//                 contentPadding:
//                     EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//                 filled: true,
//                 fillColor: Colors.white.withOpacity(0.1),
//               ),
//               onChanged: (value) {
//                 filterEvents(value);
//               },
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: _filteredEvents.length,
//               itemBuilder: (BuildContext context, int index) {
//                 return _buildEventCard(_filteredEvents[index]);
//               },
//             ),
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           final eventDetails = await Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => AddEventForm()),
//           );
//           if (eventDetails != null) {
//             setState(() {
//               _events.add(eventDetails);
//               filterEvents(_searchController.text);
//             });
//           }
//         },
//         elevation: 4,
//         hoverColor: Colors.green[200],
//         tooltip: 'Add Event',
//         child: Icon(Icons.add),
//       ),
//     );
//   }

//   Widget _buildEventCard(EventDetails eventDetails) {
//     return Card(
//       margin: EdgeInsets.all(10),
//       color: Color.fromRGBO(139, 255, 155, 0.871),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//         side: BorderSide(
//           color: Color.fromRGBO(122, 204, 153, 0.5),
//         ),
//       ),
//       child: Column(
//         children: [
//           ListTile(
//             title: Text('Event: ${eventDetails.eventName}'),
//             subtitle: Text('Location: ${eventDetails.location}\n'
//                 'Username: ${eventDetails.username}\n'
//                 'Phone Number: ${eventDetails.phoneNumber}\n'
//                 'UPI No.: ${eventDetails.upiNo}\n'
//                 'Date: ${eventDetails.date.toString()}'),
//             trailing: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 IconButton(
//                   icon: Icon(Icons.edit),
//                   onPressed: () {
//                     _showEditEventDialog(eventDetails);
//                   },
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.delete),
//                   onPressed: () {
//                     setState(() {
//                       _events.remove(eventDetails);
//                       filterEvents(_searchController.text);
//                     });
//                   },
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     // Handle upload file action
//                   },
//                   style: ButtonStyle(
//                     backgroundColor: MaterialStateProperty.all<Color>(
//                         Colors.white // background color
//                         ),
//                     foregroundColor: MaterialStateProperty.all<Color>(
//                       Color.fromARGB(255, 81, 196, 87),
//                     ), // foreground color
//                     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                       RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20.0),
//                       ),
//                     ),
//                     minimumSize: MaterialStateProperty.all<Size>(
//                         Size(120, 40)), // Adjusted minimum size
//                   ),
//                   child: Text('Upload File'),
//                 ),
//                 ElevatedButton(
//                   onPressed: () {
//                     // Handle view file action
//                   },
//                   style: ButtonStyle(
//                     backgroundColor: MaterialStateProperty.all<Color>(
//                         Colors.white // background color
//                         ),
//                     foregroundColor: MaterialStateProperty.all<Color>(
//                       Color.fromARGB(255, 81, 196, 87),
//                     ), // foreground color
//                     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                       RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20.0),
//                       ),
//                     ),
//                     minimumSize: MaterialStateProperty.all<Size>(
//                         Size(120, 40)), // Adjusted minimum size
//                   ),
//                   child: Text('View File'),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void filterEvents(String query) {
//     setState(() {
//       _filteredEvents = _events.where((event) {
//         final username = event.username.toLowerCase();
//         final eventName = event.eventName.toLowerCase();
//         final searchLower = query.toLowerCase();
//         return username.contains(searchLower) ||
//             eventName.contains(searchLower);
//       }).toList();
//     });
//   }

//   void _showEditEventDialog(EventDetails eventDetails) async {
//     final updatedEventDetails = await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           child: EditEventPage(eventDetails: eventDetails),
//         );
//       },
//     );
//     if (updatedEventDetails != null) {
//       setState(() {
//         int index = _events.indexOf(eventDetails);
//         _events[index] = updatedEventDetails;
//         filterEvents(_searchController.text);
//       });
//     }
//   }
// }
