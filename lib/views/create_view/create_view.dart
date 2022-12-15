import 'package:flutter/material.dart';

class CreateView extends StatefulWidget {
  const CreateView({Key? key}) : super(key: key);

  static const routeName = '/create_view';

  @override
  State<CreateView> createState() => _CreateViewState();
}

class _CreateViewState extends State<CreateView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create View'),
      ),
    );
  }
}
