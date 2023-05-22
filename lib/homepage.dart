import 'dart:ui';

import 'package:document_management_system/constant/inform_dialog.dart';
import 'package:document_management_system/signinpage.dart';
import 'package:document_management_system/verification_response.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:lottie/lottie.dart';

import 'constant/blurry_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController textController = TextEditingController();
  String verificationCode = "";
  bool hasInternet = false;

  @override
  void initState() {
    super.initState();
    EthernetConnection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Belge Doğrulama"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignInPage(),
                    ));
              },
              icon: const Icon(Icons.login)),
        ],
        elevation: 0,
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
              padding: EdgeInsets.only(top: 20, bottom: 15),
              child: Form(
                key: _formKey,
                child: TextFormField(
                  controller: textController,
                  maxLength: 12,
                  textCapitalization: TextCapitalization.characters,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Belge Kodu',
                    hintText: 'Belge Kodu',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Lütfen belge kodunu giriniz";
                    } else if (value.length != 12) {
                      return "Belge kodu 12 karakterdir, lütfen tamamlayınız";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  verificationCode = textController.text;
                  print("sorgulanıyor");
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            VerificationResponse(verificationCode: verificationCode),
                      ));
                }
              },
              icon: const Icon(Icons.find_in_page, size: 22),
              label: const Text(
                "Sorgula",
                style: TextStyle(fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: TextButton(
                  onPressed: () {
                    _informDialog(context);
                    print("object");
                  },
                  child: const Text("Belgemi Nasıl Doğrularım ?")),
            ),
          ],
        ),
      ),
    );
  }

  _informDialog(BuildContext context) {
    continueCallBack() => {
          Navigator.of(context).pop(),
        };
    InformDialog informDialog = InformDialog(continueCallBack);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return informDialog;
      },
    );
  }

  _showDialog(BuildContext context) {
    continueCallBack() => {
          Navigator.of(context).pop(),
          EthernetConnection()
          // code on continue comes here
        };
    BlurryDialog alert = BlurryDialog("Uyarı!", "İnternet bağlanatınız yok !", continueCallBack);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  EthernetConnection() async {
    hasInternet = await InternetConnectionChecker().hasConnection;
    if (!hasInternet) {
      _showDialog(context);
    }
  }
}
