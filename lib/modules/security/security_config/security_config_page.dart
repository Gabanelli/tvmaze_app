import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:tvmaze_app/modules/security/security_config/security_config_controller.dart';

class SecurityConfigPage extends GetView<SecurityConfigController> {
  const SecurityConfigPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Security')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text('Set auth PIN'),
                    Row(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
