import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:litemall_app/models/product_model.dart';
import 'package:litemall_app/utils/common.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../../utils/global.dart';
import '../../viewmodels/category_viewmodel/category_viewmodel.dart';
import '../../viewmodels/product_viewmodel/product_viewmodel.dart';

class CreateView extends StatefulWidget {
  const CreateView({Key? key}) : super(key: key);

  static const routeName = '/create_product';

  @override
  State<CreateView> createState() => _CreateViewState();
}

class _CreateViewState extends State<CreateView> {
  late final CategoryViewModel _categoryViewModel;
  late final ProductViewModel _productViewModel;
  List<String>? _categoryItems;
  String? _categoryValue = '';

  final GlobalKey<FormState> _createFormKey = GlobalKey<FormState>();
  final TextEditingController _titleCtr = TextEditingController(text: '');
  final TextEditingController _descCtr = TextEditingController(text: '');
  final TextEditingController _priceCtr = TextEditingController(text: '');
  final TextEditingController _ratingCtr = TextEditingController(text: '');
  final TextEditingController _quantityCtr = TextEditingController(text: '');
  File? _imgFile;

  // loading create status
  bool _loading = false;

  void _init() {
    _categoryViewModel = Provider.of<CategoryViewModel>(context, listen: false);
    _productViewModel = Provider.of<ProductViewModel>(context, listen: false);
    _categoryItems = _categoryViewModel.categories.data!.map((e) => e.attributes.title).toList();
    _categoryValue = _categoryItems![0];
  }

  Future<void> _onSelectImagePressed() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;

    final imgPath = result.files.first.path.toString();

    ImageProperties properties = await FlutterNativeImage.getImageProperties(imgPath);
    final height = properties.height ?? 300;
    final width = properties.width ?? 600;
    File compressedFile = await FlutterNativeImage.compressImage(
      imgPath,
      quality: 80,
      targetWidth: 600,
      targetHeight: (height * 600 / width).round(),
    );

    // _imgFile = File(imgPath);
    _imgFile = compressedFile;

    setState(() {});
  }

  Future<void> _onCreatePressed() async {
    if (_createFormKey.currentState!.validate()) {
      setState(() {
        _loading = true;
      });

      'imgFile path :: ${_imgFile?.path}'.log();
      if (_imgFile != null) {
        await _productViewModel.uploadImage(imgFile: _imgFile!).then((value) => 'upload response status :: $value'.log());
        'response upload image :: ${_productViewModel.imgResponse}'.log();

        final requestBody = ProductSubData.toJsonBody(
          title: _titleCtr.text,
          rating: _ratingCtr.text,
          description: _descCtr.text,
          quantity: _quantityCtr.text,
          category: getCategory(_categoryValue ?? '').toString(),
          thumbnail: _productViewModel.imgResponse!.id.toString(),
          price: _priceCtr.text,
        );

        await _productViewModel.createProduct(requestBody: requestBody).then((status) {
          'response update product status :: $status'.log();
          if (status) {
            Toast.show('Create success', gravity: Toast.top, duration: 3);
          } else {
            Toast.show('Create failed', gravity: Toast.top, duration: 3);
          }
        });

        await Future.delayed(const Duration(seconds: 1)).then(
          (value) => Navigator.of(context).popUntil((route) => route.isFirst),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void dispose() {
    super.dispose();
    _titleCtr.dispose();
    _descCtr.dispose();
    _ratingCtr.dispose();
    _priceCtr.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Product'),
      ),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Form(
                key: _createFormKey,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 12.0,
                      ),
                      GestureDetector(
                        child: Center(
                          child: Stack(
                            children: [
                              _imgFile != null
                                  ? CircleAvatar(
                                      radius: 80,
                                      backgroundImage: Image.file(_imgFile!).image,
                                    )
                                  : const CircleAvatar(
                                      radius: 80,
                                      child: Text('Select Image'),
                                    ),
                              const Positioned(
                                bottom: 0,
                                right: 0,
                                child: CircleAvatar(
                                  backgroundColor: Global.fourColor,
                                  child: Icon(
                                    Icons.camera_alt_sharp,
                                    color: Global.thirdColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (_) {
                              return SingleChildScrollView(
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
                                  child: Container(
                                    alignment: Alignment.center,
                                    color: Global.firstColor,
                                    height: height / 6,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Center(
                                          child: SizedBox(
                                            width: MediaQuery.of(context).size.width * 0.1,
                                            child: const Divider(
                                              color: Global.fourColor,
                                              thickness: 2.5,
                                            ),
                                          ),
                                        ),
                                        ListTile(
                                          onTap: () async {
                                            'Selected image ...'.log();
                                            await _onSelectImagePressed().then((value) => Navigator.of(context).pop());
                                          },
                                          leading: const CircleAvatar(
                                            backgroundColor: Global.fourColor,
                                            child: Icon(
                                              Icons.image_outlined,
                                              color: Global.thirdColor,
                                            ),
                                          ),
                                          title: const Text(
                                            'Choose Image',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Title cannot be empty';
                            }
                            return null;
                          },
                          controller: _titleCtr,
                          decoration: const InputDecoration(
                            label: Text('Title'),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Description cannot be empty';
                            }
                            return null;
                          },
                          controller: _descCtr,
                          decoration: const InputDecoration(
                            label: Text('Description'),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Price cannot be empty';
                            }
                            return null;
                          },
                          controller: _priceCtr,
                          decoration: const InputDecoration(
                            label: Text('Price'),
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Rating cannot be empty';
                            }
                            return null;
                          },
                          controller: _ratingCtr,
                          decoration: const InputDecoration(
                            label: Text('Rating'),
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Quantity cannot be empty';
                            }
                            return null;
                          },
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: _quantityCtr,
                          decoration: const InputDecoration(
                            label: Text('Quantity'),
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      DropdownButton<String>(
                        value: _categoryValue,
                        items: _categoryItems!.map((e) => _buildMenuItem(e)).toList(),
                        onChanged: (value) {
                          setState(() {
                            _categoryValue = value;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      ElevatedButton(
                        onPressed: _onCreatePressed,
                        child: const Text('Create'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  DropdownMenuItem<String> _buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
      );
}
