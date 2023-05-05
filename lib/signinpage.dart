import 'package:document_management_system/document_get_page.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './fetchservice/SignIn.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController textMailController = TextEditingController();
  TextEditingController textPasswordController = TextEditingController();

  String Mail = "";
  String Password = "";
  String signInError = "";

  bool isValidEmail(String email) {
    // E-posta adresini doğrulamak için düzenli ifade kullanın
    RegExp emailRegExp =
        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    // E-posta adresi düzenli ifade ile eşleşiyorsa, geçerlidir
    if (!emailRegExp.hasMatch(email)) {
      return false;
    }
    return true;
  }

  Future<SignIn> signIn(String mail, String password) async {
    var url = Uri.parse('https://bysdemo.aymodamobilya.com/Api/SignIn');
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({'Email': '$mail', 'Password': '$password'});
    var response = await http.post(url, headers: headers, body: body);
    if (response.statusCode == 200) {
      return SignIn.fromJson(json.decode(response.body));
    } else {
      return SignIn(signIn: false, signInError: "Bir sorun oluştu", student: Student());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Öğrenci Girişi"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15),
              child: Image.asset(
                "assets/icons/BozokIcon.png",
                fit: BoxFit.fitHeight,
                height: 225,
              ),
            ),
            const Center(
              child: Text(
                "BOZOK BYS",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 15),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: textMailController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'E-Mail',
                          hintText: 'E-Mail',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Lütfen E-Mailinizi giriniz";
                          } else if (!isValidEmail(value)) {
                            return "Lütfen geçerli bir E-Mail giriniz";
                          } else {
                            return null;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        controller: textPasswordController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Şifre',
                          hintText: 'Şifre',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Lütfen şifrenizi giriniz";
                          } else if (value.length < 6) {
                            return "Şifre en az altı karakterdir";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ],
                  )),
            ),
            ElevatedButton.icon(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Mail = textMailController.text;
                  Password = textPasswordController.text;

                  Future<SignIn> signInData = signIn(Mail, Password);
                  signInData.then(
                    (signIn) {
                      if (signIn.signIn!) {
                        //giriş yapılıyor
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DocumentGetPage(
                                    studentID: "1",
                                  )),
                        );
                      } else {
                        setState(() {
                          signInError = signIn.signInError!;
                        });
                      }
                    },
                  );
                }
              },
              icon: const Icon(Icons.login, size: 22),
              label: const Text(
                "Giriş Yap",
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
                child: Text(
              signInError,
              style: const TextStyle(color: Colors.red, fontSize: 18),
            ))
          ],
        ),
      ),
    );
  }
}
