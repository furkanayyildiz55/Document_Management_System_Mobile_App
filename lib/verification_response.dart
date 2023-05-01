import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class VerificationResponse extends StatefulWidget {
  const VerificationResponse({super.key});

  @override
  State<VerificationResponse> createState() => _VerificationResponseState();
}

class _VerificationResponseState extends State<VerificationResponse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Sorgulama Sonucu"),
      ),
      body: verified(context),
    );
  }

  Padding notVerified() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey[300],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                "Belge Bulunamadı",
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 23),
              ),
              Lottie.asset("assets/lottie/lottie_notVerified.json", height: 120, repeat: true)
            ],
          ),
        ),
      ),
    );
  }

  Column verified(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[300],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  "Doğrulanmış Belge",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 23),
                ),
                Lottie.asset("assets/lottie/lottie_verified.json", height: 100, repeat: false)
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey[300],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              Text(
                "Belge Bilgileri",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(
                height: 15,
              ),
              Wrap(
                spacing: 150,
                runSpacing: 15,
                children: [
                  Text(
                    "Belge Sahibi        : Furkan Ayyıldız",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    "Belge Adı             : Onur Belgesi",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    "Oluşturma Tarihi : 22.04.2023",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Bu belge Yozgat Bozok Üniversitesi tarafından verilmiştir ve onaylanmıştır. ",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  SizedBox(height: 15),
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Container _documentVerificationLoading() {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue,
      ),
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Lottie.asset("assets/lottie/lottie_search_document.json"),
      ),
    );
  }
}
