import 'package:flutter/material.dart';
import 'login.dart';
import 'package:gsheets/gsheets.dart';

class UserSheetsApi1{
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
  static final _spreadsheetId = '13TGCvgV0tWPX7E-kFxQGfbzggzDOq0zXE9B63DhVKtg';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _userSheet1;
  static Future init() async{
    try {
      final spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
      _userSheet1 = await _getWorkSheet(spreadsheet, title: 'Sheet1');

      final firstRow = UserFields.getFields();
      _userSheet1!.values.insertRow(1, firstRow);
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
  static Future insert(List<Map<String, dynamic>> rowList) async {
    if (_userSheet1 == null) return;

    //final cell = await _userSheet1?.cells.cell(column: 4, row: 2);
    // prints 'new'
    //print(cell?.value);

    var rollNumbers = await _userSheet1?.values.columnByKey('Roll No');
    final current_rollNo = fourController.text;
    //print(current_rollNo);
    if (rollNumbers!.contains(current_rollNo)) {
      print("Duplicate Entries!");
    }
    else {
      print("No repeated roll numbers.");
      _userSheet1!.values.map.appendRows(rowList);
      print("Insertion Successful!!");
    }
  }
}


class UserFields{
  static final String FName= 'First Name';
  static final String MName= 'Middle Name';
  static final String LName= 'Last Name';
  static final  RNo= 'Roll No';
  static final String GSUITE= 'Username';
  static final String Passkey= 'Password';

  static List<String> getFields() => [FName,MName,LName,RNo,GSUITE,Passkey];
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Create Account',
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
TextEditingController oneController = TextEditingController();
TextEditingController twoController = TextEditingController();
TextEditingController threeController = TextEditingController();
TextEditingController fourController = TextEditingController();
TextEditingController fiveController = TextEditingController();
TextEditingController passwordController = TextEditingController();

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(top: 60.0),
                child: const Text(
                  'Create Account',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
              padding: const EdgeInsets.only(top: 40, left:10, right:10),
              child: TextField(
                controller: oneController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'First Name',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20, left:10, right:10),
              child: TextField(
                controller: twoController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Middle Name',
                ),
              ),
            ),
            Container(
              padding:const EdgeInsets.only(top: 20, left:10, right:10),
              child: TextField(
                controller: threeController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Last Name',
                ),
              ),
            ),
            Container(
              padding:const EdgeInsets.only(top: 20, left:10, right:10),
              child: TextField(
                controller: fourController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'StudentID',
                ),
              ),
            ),
            Container(
              padding:const EdgeInsets.only(top: 20, left:10, right:10),
              child: TextField(
                controller: fiveController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                  hintText: 'someone@example.com',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 20, left:10, right:10),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),

            Container(
                height: 80,
                padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                child: ElevatedButton(
                    child: const Text('Create Account'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue, // Background color
                    ),
                    onPressed: () async {
                      String Gsuite = fiveController.text;
                      if (Gsuite.contains('@gmail.com')) {
                        final user = {
                          UserFields.FName: oneController.text,
                          UserFields.MName: twoController.text,
                          UserFields.LName: threeController.text,
                          UserFields.RNo: fourController.text,
                          UserFields.GSUITE: fiveController.text,
                          UserFields.Passkey: passwordController.text,

                        };

                        await UserSheetsApi1.insert([user]);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                        print(oneController.text);
                        print(twoController.text);
                        print(threeController.text);
                        print(fourController.text);
                        print(fiveController.text);
                        print(passwordController.text);
                      }
                      else{
                        showDialog(context: context, builder: (context)=>AlertDialog(
                          title: Text('Please enter a valid email id'),
                          content: ElevatedButton(
                            child: Text("Ok!"),
                            onPressed: (){
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
                Container(
                  padding: const EdgeInsets.only(top: 20, left: 70, right: 10),
                  child: Text('Already have an account?',textAlign: TextAlign.center),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20, left: 1, right: 10),
                  child: InkWell(child: GestureDetector(
                    child: Text('LOGIN',style: TextStyle(fontWeight: FontWeight.w900,color: Colors.blue),),
                    onTap: (){

                      Navigator.push(context,MaterialPageRoute(builder: (context) =>Login()));
                      //print('Heyy! I am Login and I was Clicked!!');
                    },

                  ),
                  ),
                ),

              ],

            ),

          ],
        ));
  }
}
