import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:toast/toast.dart';

import '../utils/util.dart';
import '../../viewmodels/viewmodel.dart';
import 'home_view/home_view.dart';

class RootView extends StatefulWidget {
  const RootView({Key? key}) : super(key: key);

  @override
  State<RootView> createState() => _RootViewState();
}

class _RootViewState extends State<RootView> {
  ////////////////////
  // internet checking start
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  // end internet checking
  ////////////////////

  late CategoryViewModel _categoryViewModel;
  late ProductViewModel _productViewModel;
  late UserViewModel _userViewModel;
  Future<void>? _loadDataFuture;
  bool _isLoading = false;

  ////////////////////
  // internet checking start
  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> _initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      'Couldn\'t check connectivity status -- ${e.message}'.log();
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  Widget _handleNoInternetConnection() => NoInternet(
        callback: () async {
          'Retry connected ...'.log();
          if (_connectionStatus == ConnectivityResult.none) {
            Toast.show(
              'No internet connection',
              gravity: Toast.top,
              duration: 2,
              backgroundRadius: 10.0,
            );
          } else {
            await Future.delayed(
              const Duration(seconds: 5),
            );
            setState(() {
              _loadDataFuture = _loadData();
            });
          }
        },
      );

  // end internet checking
  ////////////////////

  Future<void> _loadData() async {
    _isLoading = true;
    _categoryViewModel = Provider.of<CategoryViewModel>(context, listen: false);
    _productViewModel = Provider.of<ProductViewModel>(context, listen: false);
    _userViewModel = Provider.of<UserViewModel>(context, listen: false)..getImgPathFromLocalData();

    await Future.delayed(
      const Duration(seconds: 5),
    );
    await Future.wait([_categoryViewModel.getCategories(), _productViewModel.getProducts()]);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    _initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    _loadDataFuture = _loadData();
  }

  @override
  void dispose() {
    super.dispose();
    _connectivitySubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'LiteMall',
          style: TextStyle(color: Global.secondColor),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: _isLoading
                ? null
                : () => Navigator.of(context).pushNamed(
                      Global.NOTIFICATION,
                    ),
            icon: Icon(
              CustomIcon.bell,
              color: _isLoading ? Colors.grey : Global.thirdColor,
            ),
          ),
          Consumer<ProductViewModel>(
            builder: (_, pModel, __) {
              return CustomIconButton(
                onPressed: _isLoading ? null : () => Navigator.of(context).pushNamed(Global.CART).then((value) => setState(() => {})),
                icon: CustomIcon.cart,
                iconColor: _isLoading ? Colors.grey : Global.thirdColor,
                showBadge: pModel.cartLists.isNotEmpty ? true : false,
              );
            },
          ),
          const SizedBox(
            width: 10.0,
          ),
        ],
      ),
      body: FutureBuilder<void>(
        future: _loadDataFuture,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.none ||
              snapshot.connectionState == ConnectionState.waiting ||
              snapshot.connectionState == ConnectionState.active) {
            return Center(
              child: LoadingAnimationWidget.waveDots(
                color: Global.secondColor,
                size: 100,
              ),
            );
          }

          if (_connectionStatus == ConnectivityResult.none) {
            return _handleNoInternetConnection();
          }

          if (_categoryViewModel.categories.message != null || _productViewModel.products.message != null) {
            if (_categoryViewModel.categories.message!.indexOf('no internet connection') > -1) {
              return _handleNoInternetConnection();
            } else {
              if (_categoryViewModel.categories.message != null) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      _categoryViewModel.categories.message.toString(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _productViewModel.products.message.toString(),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
          }

          return RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(
                const Duration(seconds: 1),
              );
              setState(() {
                _isLoading = true;
                _loadDataFuture = _loadData();
              });
            },
            child: const HomeView(),
          );
        },
      ),
      bottomNavigationBar: Consumer<UserViewModel>(
        builder: (_, user, __) => BottomNavBar(
          filePath: _userViewModel.filePath,
        ),
      ),
    );
  }
}
