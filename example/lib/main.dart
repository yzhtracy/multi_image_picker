import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:multi_image_picker_example/DemoLocalizations.dart';

import 'DemoLocalizationsDelegate.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        DemoLocalizationsDelegate.delegate,
      ],
      supportedLocales: [
        const Locale('en'), // English
        const Locale('he', 'IL'), // Hebrew
        const Locale.fromSubtags(
            languageCode: 'zh'), // Chinese *See Advanced Locales below*
      ],
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Asset> images = List<Asset>();
  String _error = 'No Error Dectected';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text(DemoLocalizations.of(context).titleBarTitle),
      ),
      body: Column(
        children: <Widget>[
          Center(child: Text('Error: $_error')),
          RaisedButton(
            child: Text(DemoLocalizations.of(context).imagePick),
            onPressed: loadAssets,
          ),
          Expanded(
            child: buildGridView(),
          )
        ],
      ),
    );
  }

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        // return Image.network('https://upfile.asqql.com/2009pasdfasdfic2009s305985-ts/2020-6/2020679131113978.gif');
        return Image.file(File(asset.filePath));
      }),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';
    try {
      // resultList = await MultiImagePicker.pickImages(
      //   maxImages: 9,
      //   qualityOfImage: 80,
      //   maxHeight: 1024,
      //   maxWidth: 768,
      //   // selectedAssets: ['654C82F9-67F2-4A1E-B5F0-257739167E1B/L0/001'],
      //   cupertinoOptions: CupertinoOptions(
      //       takePhotoIcon: "chat",
      //       selectionStrokeColor: "#ff6179f2",
      //       selectionFillColor: "#ff6179f2"),
      //   materialOptions: MaterialOptions(
      //       allViewTitle: "All Photos", selectCircleStrokeColor: "#ff6179f2"),
      // );E3733F84-50D3-4343-AF8C-D18ABB3CF852/L0/001
      Asset asset = await MultiImagePicker.requestTakePicture();
      resultList.add(asset);
      // print(asset);
      // print(await MultiImagePicker.requestThumbDirectory());
      // for (var asset in assets) {
      //   print(asset.identifier);
      // }
      // print(assets);

      // final fileSize = await MultiImagePicker.requestFileSize(
      //     "334D2E75-7DFD-4D76-B8E3-BB2B5A84B533/L0/001");
      // if (double.parse(fileSize) > 1024 * 1024 * 8) {}
      // print(fileSize);
      // List<Asset> data = await MultiImagePicker.requestMediaData(
      //     qualityOfImage: 80,
      //     maxHeight: 1024,
      //     maxWidth: 768,
      //     selectedAssets: ['196245', '192980']);
      // print(data);
      // Uint8List data = await MultiImagePicker.fetchMediaThumbData("187053", "video");
      // print(data);
      // Uint8List data1 = await MultiImagePicker.fetchMediaThumbData("53F55494-C4C0-4FB7-8365-8326BBC0693D/L0/001");
      // print(data);
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
    });
  }
}
