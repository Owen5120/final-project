import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gsheets/gsheets.dart';
import 'StaffHomepage.dart';
import 'staffsignup.dart';
void main() => runApp(const StaffSignup());

class StaffLogin extends StatelessWidget {
  const StaffLogin({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}
class UserSheetsApi3{
  static const _credentials = r''' 
  {
  "type": "service_account",
  "project_id": "fr-attendance-system",
  "private_key_id": "68cd118876cdb7c8f81c2fd0cff6990edcc4c9b1",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDyDbhkytZeUHCC\nfxc4//dPYqy2Yu6jqG7K8MCaaR2dJOuuat9eCjp8sqxJN2OeL9OO+lZMstTp6ybU\njF75EViGwlwGn9bZzfKCMUhjsap5R/GPe0Ad8u+qfH2CPJCDuBYXRR02K/SVl139\nncWfC1XMMKpEMcWKEwla+JxJ7wYc0wj3e6QVG0TSzbc4BVFzZTgNXpHfM/Lk5uy0\n/+F+TOZa4VoTEF7L8P2HwLNRuntNMlJDXke1DtUOuByd4g1a9zaABpAk7dmQ1o4s\nMheOQm0ndZLzpXyOvuLLIDSgx7oB77Q+EdAVUZIkwT24wk+N3pCm9oIkIt7kc5NC\n9zAOSTUtAgMBAAECggEAHiCBC+KHLfP7HPLulASf5nyUnJrRswL6zz2J624b5nw6\n7VmV9aF2SCEA+pfvSTgQr+IOrbswbvD6w0e5Zmy3RQaZ56UrW66beYLizK3HVxMS\nSNaBU3jyRZj7EiOxpQNblIfgq+ZqqdfONgvWFgaWJjUEbDp5qMbXyj/ZTAZ5D0si\n/Qbjk9b2knsLMmP0BntJmoJfnvi2suN/lu4oox+LtrbfcBmtseTHmyQkbII20Jjn\nHZ0KzYx8mJq9iMiU9Bjx6mgAxcJxwVJwwUYFc2tJyfZ6AUxYC2ezahKFPzEBJklF\n/wcUnBy5BrOAqmMiW7CG2Fe+GFXlEYZFurcXaACXgQKBgQD/WgNNvOMWMxJ0Kt1v\nL2j2amngvpncsickqKjQLUMTtghm3vx0azFlILd7mMu0xAcQ5U29/mbc5ILFmFve\nG6Ql8tFKd0/OsC1xir92E9W4n2PIEuiPOCkbcYV8EMmKUWfUEGWFgHddhyiGhy/x\nNBvdgkf17ekEwTwdK9N4DpcpIQKBgQDyqxAvmAGfp88rZ9HY1jGrYDvl96KaJkCJ\nDAC2U0LKQZeynaZ0SwQHQOmIjCCqhAfk/OT+wfH/+gXyEuvonKHutWHdBQvu8/yv\nbEpHjIqbksNdWr+VgIWvMP7Tf8Jrl7lcCr14RUiEKTUvZe07xVlLlHQYx1ioma5O\nC3Ba2Q/OjQKBgQDO3reqdQpsY7fhkRCQERKx/4gDYab5GwOHOXR6IxEimOi5npFc\nJ7N+wEClyyXNLrqiv4J6F+5xqlcfic1zZWVYsR1JfNuVETnfsI5oNK2Cwu5tmpP5\n43+6EgAYgOkmO8koDpiQzYDmrqbwRflbKeIhVHjEDpgnF/2BjI3nx7pCwQKBgFiQ\nEdIs2brY1YTz2OQYF/yBnJqrK86yUy8xEDl6XY/PLHvliVA76HZ1PEW3Tlys3uy1\nVyWaxqUzLGRSf4JfV8H0tIijRN2qcffbv6gpJJTulRpG+lCnnSJ48SdjIyN9Ngrf\naJKyRmrlVyG7Qz9jINmyjkRUzIiLvc+B4TlmqpwpAoGAeiduf2t+XGwtzf+XAlS2\n5lcA49caTypwBG7oZX8soMWCVFyMtszGmLOlINOAR9JO9aebcdVrMRK3lqZcVIDG\nvnWF7bNt4kR9zOlVbYx88m5AOpK/156jD8F6k48DmTlqCJpaG5iFzi4fSjmP91e7\nmLxUXZRQ5cNrxi2JGEf8ulQ=\n-----END PRIVATE KEY-----\n",
  "client_email": "mini-project-sem5@fr-attendance-system.iam.gserviceaccount.com",
  "client_id": "105098431325622100803",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/mini-project-sem5%40fr-attendance-system.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
  ''';
  static final _spreadsheetId = '1sSsTsbVrkN6ho12diucExIEl8j-gwd_3Z0FqqJUONT0';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _userSheet;
  static Future init() async{
    try {
      final spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
      _userSheet = await _getWorkSheet(spreadsheet, title: 'Sheet1');

      final firstRow = UserFields.getFields();
      _userSheet!.values.insertRow(1, firstRow);
    }catch(e){
      print('Init Error: $e');
    }
  }
  static Future <Worksheet> _getWorkSheet(
      Spreadsheet spreadsheet,{
        required String title,
      }
      )async{
    try{
      return await spreadsheet.addWorksheet(title);
    }catch(e){
      return spreadsheet.worksheetByTitle(title)!;
    }
  }

  static Future insert(List<Map<String, dynamic>> rowList) async{
    if(_userSheet == null) return;

    _userSheet!.values.map.appendRows(rowList);
  }

}
String staffid = "";
class UserFields{
  static final String GSUITE_ID = 'Username';
  static final String Password = 'Password';
  static final String LoginTimeStamp = 'LoginTimeStamp';
  static List<String> getFields() => [GSUITE_ID,Password,LoginTimeStamp];
}
TextEditingController nameController = TextEditingController();
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  bool _validate_name = false;
  TextEditingController passwordController = TextEditingController();
  bool _validate_password = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ListView(
        children: <Widget>[
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(top: 100, bottom: 20),
              child: const Text(
                'WELCOME!',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 30),
              )),
          Icon(
            Icons.person_outline,
            color: Colors.blue,
            size: 70.0,
          ),
          Form(
            child: Column(
              children: <Widget>[Container(
                padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                child: TextFormField(
                  maxLength: 45,
                  controller: nameController,
                  style: TextStyle(height: 2.0),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                      BorderSide(width: 3, color: Colors.black), //<-- SEE HERE
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    labelText: 'Enter Username',
                    errorText: _validate_name
                        ? "Please Enter your Username"
                        : null,
                  ),

                ),
              ),
                Container(
                  padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: TextFormField(
                    obscureText: true,
                    style: TextStyle(height: 2.0),
                    controller: passwordController,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        BorderSide(width: 3, color: Colors.black),
                        //<-- SEE HERE
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      labelText: 'Enter Password',
                      errorText: _validate_password
                          ? "Please Enter a Password"
                          : null,
                    ),

                  ),
                ),
              ],
            ),
          ),

          Container(
              height: 100,
              padding: const EdgeInsets.only(top: 30, left: 110, right: 110),
              child: ElevatedButton(
                  child: const Text('Login', style: TextStyle(fontSize: 25),),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          )
                      )
                  ),

                  onPressed: () async {
                    //final _spreadsheetId = '1OwiWJJ9PR-18gCIPn30XVWdBzPoRg7Chjetn7mfqtvs';
                    //final range = 'Sheet1!A:A';
                    final user = {
                      UserFields.GSUITE_ID: nameController.text,
                      UserFields.Password: passwordController.text,
                      UserFields.LoginTimeStamp: '${DateTime.now()}',
                    };


                    print(nameController.text);
                    print(passwordController.text);
                    print(DateTime.now());

                    setState(() {
                      nameController.text.isEmpty
                          ? _validate_name = true
                          : _validate_name = false;
                      passwordController.text.isEmpty ?
                      _validate_password = true : _validate_password = false;
                    });
                    staffid = nameController.text;
                    if (staffid.contains('@staff.bham.ac.uk')) {
                      await UserSheetsApi3.insert([user]);
                      if (_validate_name != true &&
                          _validate_password != true) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const StaffHomePage()),
                        );
                      }
                    }
                    else {
                      showDialog(context: context, builder: (context) =>
                          AlertDialog(
                            title: Text("Check staff id and password"),
                            content: ElevatedButton(
                              child: Text("Ok!"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ));
                    }
                  }
              )
          ),
          Row(
            children: <Widget>[
              const Text('New Staff?', style: TextStyle(fontSize: 15,),),
              TextButton(
                child: const Text(
                  'Sign up',
                  style: TextStyle(fontSize: 15,
                    decoration: TextDecoration.underline,),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const StaffSignup()),
                  );
                },
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ],
      ),
    );
  }
}