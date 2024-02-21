import 'dart:core';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:test1/IconGallery/GalleryController.dart';
import 'package:test1/IconGallery/GalleryValue.dart';
import 'package:test1/IconGallery/IconGallery.dart';
import 'package:test1/IconGallery/TypeImageImport.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

void main() async {
  await ScreenUtil.ensureScreenSize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Test Comment
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<Uint8List> convert(String path) async {
    final ByteData bytes = await rootBundle.load(path);
    final Uint8List list = bytes.buffer.asUint8List();
    return list;
  }

  Future<File> getImageFileFromAssets(String path) async {
    final ByteData bytes = await rootBundle.load(path);
    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.create(recursive: true);
    await file.writeAsBytes(
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
    return file;
  }

  late Map<TypeImageImport, List> Data;

  Widget? _widget = null;

  late GalleryController galleryController;

  late WidgetsBinding _widgetsBinding;

  initState() {
    _widgetsBinding = WidgetsBinding.instance;
    galleryController =
        GalleryController(GalleryValue(SelectedHeader: '', SelectedImg: ''));
    super.initState();

    _widgetsBinding.addPostFrameCallback((timeStamp) async {
      Data = {
        TypeImageImport.png: [
          'assets/png/c0.png',
          await convert('assets/png/c1.png'),
          'assets/png/c2.png',
          await getImageFileFromAssets('assets/png/c3.png'),
          await getImageFileFromAssets('assets/png/c4.png'),
          await getImageFileFromAssets('assets/png/c5.png'),
          'assets/png/c6.png',
          'assets/png/c7.png',
          await convert('assets/png/c8.png'),
          'assets/png/c9.png',
          await convert('assets/png/c10.png'),
          'assets/png/c11.png',
          'assets/png/c12.png',
          'assets/png/c13.png',
        ],
        TypeImageImport.iconData: [
          Icons.add_alert_outlined,
          MdiIcons.accountChild,
          MdiIcons.accountCog,
          Icons.ac_unit_outlined,
          MdiIcons.abacus,
          MdiIcons.accountHeart,
          Icons.account_balance,
        ],
        TypeImageImport.jpg: [
          'assets/jpg/c42.jpg',
          'assets/jpg/c43.jpg',
          'assets/jpg/c44.jpg',
          'assets/jpg/c45.jpg',
          'assets/jpg/c46.jpg',
          'assets/jpg/c47.jpg',
          'assets/jpg/c48.jpg',
          'assets/jpg/c49.jpg',
          'assets/jpg/c50.jpg',
          'assets/jpg/c51.jpg',
          'assets/jpg/c52.jpg',
          'assets/jpg/c53.jpg',
          'assets/jpg/c54.jpg',
          'assets/jpg/c55.jpg',
        ],
        TypeImageImport.ico: [
          'assets/ico/c100.ico',
          'assets/ico/c101.ico',
          'assets/ico/c102.ico',
          'assets/ico/c103.ico',
          'assets/ico/c104.ico',
          'assets/ico/c105.ico',
          'assets/ico/c106.ico',
          'assets/ico/c107.ico',
        ],
        TypeImageImport.svg: [
          'assets/svg/c80.svg',
          'assets/svg/c81.svg',
          'assets/svg/c82.svg',
          'assets/svg/c83.svg',
          'assets/svg/c84.svg',
          'assets/svg/c85.svg',
        ]
      };
    });
  }

  Future<Widget?> showMessageBoxCategory(context, child) async {
    AlertDialog alertDialog = AlertDialog(
      backgroundColor: Colors.transparent,
      alignment: Alignment.center,
      insetPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      elevation: 0,
      content: child,
    );

    return await showDialog(
        context: context,
        barrierDismissible: true,
        useSafeArea: true,
        builder: (context) {
          double _bottom = MediaQuery.of(context).viewInsets.bottom;
          return Padding(
            padding: EdgeInsets.symmetric(
                vertical: (_bottom > 0.0) ? 20.h : 50.h, horizontal: 0.1.sw),
            child: alertDialog,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              _widget = await showMessageBoxCategory(
                  context,
                  IconGallery(
                      Data: Data, galleryController: galleryController));
              setState(() {});
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              textDirection: TextDirection.rtl,
              children: [
                Text('Icone Select'),
                SizedBox(width: 8),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: FittedBox(child: _widget),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
