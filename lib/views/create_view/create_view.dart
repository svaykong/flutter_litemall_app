import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:file_picker/file_picker.dart';
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

  final GlobalKey _formKey = GlobalKey<FormState>();
  final TextEditingController _titleCtr = TextEditingController();
  final TextEditingController _descCtr = TextEditingController();
  final TextEditingController _priceCtr = TextEditingController();
  final TextEditingController _ratingCtr = TextEditingController();

  File? _imgFile;

  void _init() {
    _categoryViewModel = Provider.of<CategoryViewModel>(context, listen: false);
    _productViewModel = Provider.of<ProductViewModel>(context, listen: false);
  }

  Future<void> _onSelectImagePressed() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;

    final imgPath = result.files.first.path.toString();
    _imgFile = File(imgPath);

    setState(() {});
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
      body: Form(
        key: _formKey,
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
                    children: const [
                      CircleAvatar(
                        radius: 80,
                        child: Text('Select Image'),
                      ),
                      Positioned(
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
                child: TextField(
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
                child: TextField(
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
                child: TextField(
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
                child: TextField(
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
              // DropdownButton<String>(
              //   value: _categoryValue,
              //   items: _categoryItems!.map((e) => _buildMenuItem(e)).toList(),
              //   onChanged: (value) {
              //     setState(() {
              //       _categoryValue = value;
              //     });
              //   },
              // ),
              const SizedBox(
                height: 12.0,
              ),
              ElevatedButton(
                onPressed: () async {
                  // widget.product.attributes.title = _titleCtr.text;
                  // widget.product.attributes.description = _descCtr.text;
                  // widget.product.attributes.price = double.parse(_priceCtr.text.parseNum().toString());
                  // widget.product.attributes.rating = double.parse(_ratingCtr.text.parseNum().toString());
                  // if (widget.product.attributes.category.data != null) {
                  //   widget.product.attributes.category.data!.id = getCategory(_categoryValue ?? '');
                  // }
                  //
                  // 'product :: ${widget.product.toJson()}'.log();
                  // await _productViewModel.updateProduct(productId: widget.product.id, requestBody: widget.product).then((status) {
                  //   'response status :: $status'.log();
                  //   if (status) {
                  //     Toast.show('Update success', gravity: Toast.top, duration: 3);
                  //   } else {
                  //     Toast.show('Update failed', gravity: Toast.top, duration: 3);
                  //   }
                  //   Navigator.of(context).pushNamedAndRemoveUntil(Global.ROOT, (route) => false);
                  // });
                },
                child: const Text('Create'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
