import 'package:flutter/material.dart';
import 'package:widgets_home/widgets_home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('WidgetsHome Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  await WidgetsHome.createCustomWidget(
                    text: 'Hello, World!',
                    imageUrl:
                    'https://imagen.research.google/main_gallery_images/a-robot-couple-fine-dining.jpg',
                    backgroundColor: '#FFA726',
                    width: 200,
                    height: 200,
                  );
                },
                child: const Text('Create Custom Widget'),
              ),
              // Agrega más botones aquí para probar las otras funciones del paquete
            ],
          ),
        ),
      ),
    );
  }
}
