import 'package:flutter/material.dart';
import 'package:flutter_vc_zegocloud/keys.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: 'Name');
  final _idController = TextEditingController(text: 'ID');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Video Call App'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              TextFormField(controller: _nameController),
              SizedBox(
                height: 20,
              ),
              TextFormField(controller: _idController),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text('Call'),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CallPage(
                callID: _idController.text.toString(),
                uName: _nameController.text.toString()),
          ));
        },
      ),
    );
  }
}

class CallPage extends StatelessWidget {
  const CallPage({Key? key, required this.callID, required this.uName})
      : super(key: key);
  final String callID;
  final String uName;

  @override
  Widget build(BuildContext context) {
    return ZegoUIKitPrebuiltCall(
      appID:
          APP_ID, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
      appSign: APP_SIGN,
      userID: uName + '123',
      userName: uName,
      callID: callID,
      // You can also use groupVideo/groupVoice/oneOnOneVoice to make more types of calls.
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
        ..onOnlySelfInRoom = (_) => Navigator.of(context).pop(),
    );
  }
}
