import 'dart:io';
import 'dart:typed_data';
import 'package:dispenduk/cubit/current_user_cubit.dart';
import 'package:dispenduk/ui/theme.dart';
import 'package:dispenduk/ui/widgets/kprimary_button_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import '../../services/storage_service.dart';

class StorageScreen extends StatefulWidget {
  const StorageScreen({Key? key}) : super(key: key);

  @override
  State<StorageScreen> createState() => _State();
}

class _State extends State<StorageScreen> {
  bool _uploadRunning = false;
  String _buttonCaption = "Pilih File untuk Upload";
  UploadTask? _task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(),
      body: ListView(padding: const EdgeInsets.all(defaultMargin), children: [
        Card(
            color: kSecondaryColor,
            child: Column(children: [
              Container(height: defaultMargin),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultMargin),
                  child: Text(
                      'Upload beberapa file hasil scanning Foto Dokumen anda',
                      textAlign: TextAlign.center,
                      style: blackTextStyle.copyWith(letterSpacing: 0.0))),
              Container(height: defaultMargin),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                ElevatedButton(
                    onPressed: _uploadRunning
                        ? null
                        : () async {
                            var img = await _pickImage();
                            if (img == null) return;

                            try {
                              _task = StorageService.uploadItem(
                                  File(img.path), img.name);

                              _uploadRunning = true;
                              setState(() {});

                              _task!.snapshotEvents.listen((snapshot) {
                                if (snapshot.state == TaskState.running) {
                                  _buttonCaption =
                                      "Sedang Upload ... ${(100.0 * (snapshot.bytesTransferred / snapshot.totalBytes)).toStringAsFixed(0)}%";
                                  _uploadRunning = true;
                                  setState(() {});
                                  return;
                                }

                                if (snapshot.state == TaskState.success) {
                                  _uploadRunning = false;
                                  _buttonCaption = "Pilih file untuk Upload";
                                  _task = null;
                                  setState(() {});
                                  return;
                                }
                              });
                            } on FirebaseException catch (ex) {
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      backgroundColor: kWarningColor,
                                      content: Text(ex.message!)));
                            }
                          },
                    child: Text(_buttonCaption)),
                Container(width: 10),
                if (_uploadRunning && _task != null)
                  IconButton(
                      onPressed: () async {
                        await _task!.cancel();
                        _uploadRunning = false;
                        _buttonCaption = "Pilih File untuk Upload";
                        setState(() {});
                      },
                      icon: Icon(Icons.stop_circle_outlined,
                          size: 36, color: kPrimaryColor))
              ]),
              Container(height: 10)
            ])),
        Container(height: defaultMargin),
        FutureBuilder(
            future: StorageService.getData(
                context.read<CurrentUserCubit>().getUid()),
            initialData: const <String>[],
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  if (_uploadRunning) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  var data = snapshot.data as List<FileDataModel>;
                  if (data.isEmpty) {
                    return Card(
                        color: Colors.grey.shade300,
                        child: const Padding(
                            padding: EdgeInsets.all(defaultMargin),
                            child: Center(
                                child: Text(
                                    "Belum ada data, harap upload beberapa File Scan Dokumen"))));
                  } else {
                    return Column(
                        children: data
                            .map((item) => FileWidget(
                                  content: item.content,
                                  fileName: item.name,
                                  uploadDate: item.uploadDate,
                                  deleteFunction: () async {
                                    await StorageService.deleteItem(
                                        item.reference);

                                    setState(() {});
                                  },
                                ))
                            .toList());
                  }
                }
              }

              return const Center(child: CircularProgressIndicator());
            })
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(defaultMargin),
        child: KprimaryButtonWidget(
          buttonColor: kPrimaryColor,
          textValue: 'Selesai',
          textColor: kWhiteColor,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  AppBar appBarWidget() => AppBar(
      backgroundColor: kPrimaryColor,
      title: Text(
        'Upload File Anda',
        style: blackTextStyle.copyWith(color: kWhiteColor),
      ));

  Future<XFile?> _pickImage() async {
    final ImagePicker picker = ImagePicker();

    return await picker.pickImage(source: ImageSource.gallery);
  }
}

class FileWidget extends StatelessWidget {
  final Uint8List content;
  final String fileName;
  final DateTime uploadDate;
  final Function() deleteFunction;

  const FileWidget(
      {Key? key,
      required this.content,
      required this.fileName,
      required this.uploadDate,
      required this.deleteFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.only(bottom: defaultMargin),
        elevation: 20,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(defaultCircular)),
        color: kWhiteColor,
        child: Padding(
          padding: const EdgeInsets.all(defaultMargin / 2),
          child: Row(children: [
            Image.memory(
              content,
              height: 60,
              width: 100,
              fit: BoxFit.contain,
            ),
            Container(width: 10),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fileName,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Container(height: 5),
                Text(DateFormat("dd.MM.yyyy HH:mm").format(uploadDate),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.w500))
              ],
            )),
            Container(width: 10),
            IconButton(
                onPressed: () async => await deleteFunction(),
                icon: const Icon(
                  Icons.delete,
                  color: Colors.redAccent,
                ))
          ]),
        ));
  }
}
