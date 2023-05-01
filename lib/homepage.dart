import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController textController = TextEditingController();
  String verificationCode = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Belge Doğrulama"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.login)),
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
                  print("sorgulanıyor");
                  verificationCode = textController.text;
                  print(verificationCode);
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
              child: TextButton(onPressed: () {}, child: const Text("Belgemi Nasıl Doğrularım ?")),
            ),
          ],
        ),
      ),
    );
  }
}