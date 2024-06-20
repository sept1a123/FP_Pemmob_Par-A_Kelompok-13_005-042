import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class DataPenggunaPage extends StatelessWidget {
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Pengguna'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(Icons.person, color: Colors.green),
                    title: Text(
                       box.read('displayName') ?? "",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                    },
                  ),
                  Divider(color: Colors.green[300], thickness: 1),
                  ListTile(
                    leading: Icon(Icons.info, color: Colors.green),
                    title: Text(
                       box.read('email') ?? "",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      
                    },
                  ),
                  Divider(color: Colors.green[300], thickness: 1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
