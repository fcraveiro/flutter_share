import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/services/constants.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;

class Sharear extends StatefulWidget {
  const Sharear({Key? key}) : super(key: key);

  @override
  State<Sharear> createState() => _SharearState();
}

class _SharearState extends State<Sharear> {
  TextEditingController textdata = TextEditingController();
  static const imageurl =
      'https://static.cryptoid.com.br/wp-content/uploads/2018/10/iStock-871148930-1440x564_c.jpg';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 35),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: TextField(
                    controller: textdata,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text('Digite o Texto'))),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: elevatedEstilo2,
                onPressed: () async {
                  if (textdata.value.text.isNotEmpty) {
                    await Share.share(textdata.value.text);
                  }
                },
                child: const Text('Compartilhar Texto'),
              ),
              const SizedBox(height: 15),
              const Text('Compartilhar Imagem da internet'),
              const SizedBox(height: 25),
              SizedBox(
                width: MediaQuery.of(context).size.width - 100,
                height: 200,
                child: Image.network(
                  imageurl,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              ElevatedButton(
                style: elevatedEstilo2,
                onPressed: () async {
                  final uri = Uri.parse(imageurl);
                  final response = await http.get(uri);
                  final bytes = response.bodyBytes;
                  final temp = await getTemporaryDirectory();
                  final path = '${temp.path}/image.jpg';
                  File(path).writeAsBytesSync(bytes);
                  await Share.shareFiles([path], text: 'Image Shared');
                },
                child: const Text('Compartilhar Imagem'),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text('Compartilhar Imagem da Galary'),
              const SizedBox(height: 15),
              ElevatedButton(
                style: elevatedEstilo2,
                onPressed: () async {
                  final result = await FilePicker.platform.pickFiles();
                  List<String>? filesss = result?.files
                      .map((file) => file.path)
                      .cast<String>()
                      .toList();
                  if (filesss == null) {
                    return;
                  }
                  await Share.shareFiles(filesss);
                },
                child: const Text('Compartilhar da Galeria'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


/*
                  pick image from Galery
                   final imagepick = await ImagePicker().pickImage(source: ImageSource.gallery);
                   if(imagepick == null){
                     return;
                  }
                  await Share.shareFiles([imagepack.path]);
                   pick image from camera
                   final imagepick = await ImagePicker().pickImage(source: ImageSource.camera);
                   if(imagepick == null){
                     return;
                   }
                  await Share.shareFiles([imagepack.path]);
                   pick Video from  Galary
                   final imagepick = await ImagePicker().pickVideo(source: ImageSource.gallery);
                   if(imagepick == null){
                     return;
                   }
                  await Share.shareFiles([imagepack.path]);
*/