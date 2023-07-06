import 'package:flutter/material.dart';

import 'package:get/get.dart';

class BantuanView extends GetView {
  const BantuanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BantuanView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'BantuanView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
