import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';

import '../create_view/create_view.dart';
import '../../viewmodels/user_viewmodel/user_viewmodel.dart';
import '../../utils/util.dart';

class AccountView extends StatefulWidget {
  const AccountView({super.key});

  @override
  State<AccountView> createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  String _imgPath = '';
  File? _imageFile;
  late final UserViewModel _userViewModel;

  Future<void> _onSelectAccountPicturePressed() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;

    _imgPath = result.files.first.path.toString();
    _imageFile = File(_imgPath);

    _userViewModel.filePath = _imgPath;
    _userViewModel.saveImgPathToLocalData();

    setState(() {});
  }

  void _init() async {
    _userViewModel = Provider.of<UserViewModel>(context, listen: false)..getImgPathFromLocalData();
    if (_userViewModel.filePath != '') {
      _imageFile = File(_userViewModel.filePath);
    }
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              child: Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 80,
                      backgroundImage: _imageFile != null
                          ? Image.file(
                              _imageFile!,
                            ).image
                          : const AssetImage('assets/imgs/user_placeholder.jpg'),
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
                                  'Select account picture ...'.log();
                                  await _onSelectAccountPicturePressed().then((value) => Navigator.of(context).pop());
                                },
                                leading: const CircleAvatar(
                                  backgroundColor: Global.fourColor,
                                  child: Icon(
                                    Icons.image_outlined,
                                    color: Global.thirdColor,
                                  ),
                                ),
                                title: const Text(
                                  'Select account picture',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              ListTile(
                                onTap: () async {
                                  'Remove account picture ...'.log();
                                  _userViewModel.removeImgPathFromLocalData().then((value) => Navigator.of(context).pop());
                                  setState(() {
                                    _imageFile = null;
                                  });
                                },
                                leading: const CircleAvatar(
                                  backgroundColor: Global.fourColor,
                                  child: Icon(
                                    Icons.remove,
                                    color: Global.thirdColor,
                                  ),
                                ),
                                title: const Text(
                                  'Remove account picture',
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
            const Padding(
              padding: EdgeInsets.only(top: 16.0, left: 8),
              child: Text(
                'My Account Info',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: TextButton(
                onPressed: () => Navigator.of(context).pushNamed(CreateView.routeName),
                child: const Text(
                  'Create Product',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
