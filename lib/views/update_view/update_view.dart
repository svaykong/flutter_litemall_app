import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import '../../utils/common.dart';
import '../../viewmodels/category_viewmodel/category_viewmodel.dart';
import '../../models/product_model.dart';
import '../../utils/global.dart';
import '../../viewmodels/product_viewmodel/product_viewmodel.dart';

class UpdateView extends StatefulWidget {
  const UpdateView({
    Key? key,
    required this.product,
    this.onUpdate,
  }) : super(key: key);

  static const routeName = '/update_view';

  final ProductSubData product;
  final VoidCallback? onUpdate;

  @override
  State<UpdateView> createState() => _UpdateViewState();
}

class _UpdateViewState extends State<UpdateView> {
  late final CategoryViewModel _categoryViewModel;
  late final ProductViewModel _productViewModel;
  List<String>? _categoryItems;
  String? _categoryValue = '';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleCtr;
  late final TextEditingController _descCtr;
  late final TextEditingController _priceCtr;
  late final TextEditingController _ratingCtr;
  late final TextEditingController _quantityCtr;
  File? _imgFile;

  void _init() {
    _categoryViewModel = Provider.of<CategoryViewModel>(context, listen: false);
    _categoryItems = _categoryViewModel.categories.data!.map((e) => e.attributes.title).toList();
    if (widget.product.attributes.category.data != null) {
      _categoryValue = widget.product.attributes.category.data!.jsonAttributes!['title'].toString();
      _categoryValue = _categoryValue!.indexOf(',') > -1 ? _categoryValue!.substring(0, _categoryValue!.indexOf(',')) : _categoryValue;
      _categoryValue = _categoryValue!.substring(0, 1).toUpperCase() + _categoryValue!.substring(1, _categoryValue!.length);
    } else {
      _categoryItems = ['', ..._categoryItems!];
    }

    _productViewModel = Provider.of<ProductViewModel>(context, listen: false);

    _titleCtr = TextEditingController(text: widget.product.attributes.title);
    _descCtr = TextEditingController(text: widget.product.attributes.description);
    _priceCtr = TextEditingController(text: widget.product.attributes.price.toString());
    _ratingCtr = TextEditingController(text: widget.product.attributes.rating.toString());
    _quantityCtr = TextEditingController(text: widget.product.attributes.quantity.toString());
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
      appBar: AppBar(title: const Text('Update Product')),
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
                    children: [
                      CircleAvatar(
                        radius: 80,
                        backgroundImage: widget.product.attributes.thumbnail.data == null
                            ? null
                            : _imgFile == null
                                ? NetworkImage(Global.host + widget.product.attributes.thumbnail.data!.attributes.url)
                                : Image.file(
                                    _imgFile!,
                                  ).image,
                        child: widget.product.attributes.thumbnail.data != null ? null : const Text('No image'),
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
                                    'Update image ...'.log();
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
                                    'Update Image',
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Title cannot be empty';
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Description cannot be empty';
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Price cannot be empty';
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Rating cannot be empty';
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                onPressed: () async {
                  widget.product.attributes.title = _titleCtr.text;
                  widget.product.attributes.description = _descCtr.text;
                  widget.product.attributes.price = double.parse(_priceCtr.text.parseNum().toString());
                  widget.product.attributes.rating = double.parse(_ratingCtr.text.parseNum().toString());
                  if (widget.product.attributes.category.data != null) {
                    widget.product.attributes.category.data!.id = getCategory(_categoryValue ?? '');
                  }
                  widget.product.attributes.quantity = int.parse(_quantityCtr.text.parseNum().toString());
                  'product :: ${widget.product.toJson()}'.log();
                  if (_formKey.currentState!.validate()) {
                    'imgFile path :: ${_imgFile?.path}'.log();

                    int? thumbnailId = widget.product.attributes.thumbnail.data?.id;
                    if (_imgFile != null) {
                      await _productViewModel.uploadImage(imgFile: _imgFile!);
                      thumbnailId = _productViewModel.imgResponse?.id;
                    }
                    widget.product.attributes.thumbnail.data?.id = thumbnailId!;
                    await _productViewModel.updateProduct(productId: widget.product.id, requestBody: widget.product).then((status) {
                      'response status :: $status'.log();
                      if (status) {
                        Toast.show('Update success', gravity: Toast.top, duration: 3);
                      } else {
                        Toast.show('Update failed', gravity: Toast.top, duration: 3);
                      }
                      Navigator.of(context).pushNamedAndRemoveUntil(Global.ROOT, (route) => false);
                    });
                  }
                },
                child: const Text('Update'),
              ),
            ],
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
