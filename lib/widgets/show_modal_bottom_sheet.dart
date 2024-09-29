import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<bool?> showAppModalBottomSheet({
  required BuildContext context,
  required Widget child,
  double? borderRadius,
  bool isDismissible = true,
  double? height,
}) {
  return showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    enableDrag: isDismissible,
    isDismissible: isDismissible,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? 20),
    ),
    builder: (BuildContext context) {
      return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: WillPopScope(
          onWillPop: () async {
            return isDismissible;
          },
          child: Builder(builder: (BuildContext context) {
            if (height == null) {
              return child;
            }
            return SizedBox(
              height: height,
              child: child,
            );
          }),
        ),
      );
    },
  );
}
