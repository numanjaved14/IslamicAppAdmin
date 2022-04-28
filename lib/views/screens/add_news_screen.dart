import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:islamic_app_admin/views/screens/news_screen.dart';
import 'package:islamic_app_admin/views/widgets/text_input_field.dart';

import '../../controllers/database_services.dart';

class AddNewsScreen extends StatefulWidget {
  const AddNewsScreen({Key? key}) : super(key: key);

  @override
  State<AddNewsScreen> createState() => _AddNewsScreenState();
}

class _AddNewsScreenState extends State<AddNewsScreen> {
  static bool loading = false;
  Uint8List? _image;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final _date = DateFormat.yMMMEd().format(DateTime.now());

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    loading = false;
    super.dispose();
  }

  void submit(
      String title, String description, String date, Uint8List file) async {
    String response = await DataBaseMethods().uploadNews(
      title: title,
      description: description,
      date: date,
      file: file,
    );
    if (response == 'Success') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const NewsScreen(),
        ),
      );
    } else {
      showInSnackBar('Some Error Occured!');
    }
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();

    XFile? _file = await _imagePicker.pickImage(source: source);

    if (_file != null) {
      return await _file.readAsBytes();
    }

    return 'No Image Selected.';
  }

  void showInSnackBar(String value) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text(value),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add News'),
      ),
      body: loading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  InkWell(
                    onTap: selectImage,
                    child: SizedBox(
                      height: 200,
                      // height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width,
                      child: _image != null
                          ? Image(
                              image: MemoryImage(_image!),
                            )
                          : const Image(
                              image: NetworkImage(
                                  'https://cdn-icons-png.flaticon.com/512/3159/3159331.png'),
                            ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  TextInputField(
                    controller: _titleController,
                    labelText: 'Title',
                    icon: Icons.title,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  TextInputField(
                    controller: _descriptionController,
                    labelText: 'Description',
                    icon: Icons.description,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  ElevatedButton(
                    onPressed: () => {
                      setState(() {
                        loading = true;
                      }),
                      submit(_titleController.text, _descriptionController.text,
                          _date, _image!)
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        fontFamily: 'Gilroy',
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        fixedSize: const Size(200, 40),
                        primary: Theme.of(context).primaryColor),
                  ),
                ],
              ),
            ),
    );
  }
}
