import 'package:flutter/material.dart';

class SearchPlaceholder extends StatelessWidget {
  const SearchPlaceholder({
    Key? key,
    this.onTap,
    this.child,
  }) : super(key: key);

  final VoidCallback? onTap;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    Widget container = Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 20.0),
      height: height * 0.06,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: child ??
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Search Product Name',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[500],
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.search,
                color: Colors.black54,
              ),
              const SizedBox(
                width: 10.0,
              ),
            ],
          ),
    );

    return onTap != null ? GestureDetector(onTap: onTap, child: container) : container;
  }
}
