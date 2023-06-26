import 'package:flutter/material.dart';
import 'package:rick_and_morty/constants/app_border_radius.dart';
import 'package:rick_and_morty/constants/app_padding.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({this.child, Key? key}) : super(key: key);

  final Widget? child;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(AppPadding.small),
        margin: const EdgeInsets.symmetric(
          horizontal: AppPadding.medium,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: AppBorderRadius.small,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              offset: const Offset(0, 2),
              blurRadius: 4,
              spreadRadius: 2,
            ),
          ],
        ),
        child: child,
      );
}
