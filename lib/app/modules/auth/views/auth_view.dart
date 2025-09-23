import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class AuthView extends StatelessWidget {
  final AuthController controller = Get.find<AuthController>();

  AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: controller.urlTextEditController,
              decoration: InputDecoration(labelText: 'URL M3U'),
            ),
            SizedBox(height: 20),
            Obx(() => controller.isLoading.value
                ? CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.primary,
                  )

                : ElevatedButton(
                onPressed: () {
                  // Chame o método de autenticação do controller aqui
                  controller.createFile();
                },
                child: Text('Autenticar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

