
import '../imports.dart';

class verifiedTag extends StatelessWidget {
  const verifiedTag({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 17.h,
        width: 17.h,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Center(
          child: Icon(
            Icons.check,
            size: 12.sp,
            color: Colors.white,
          ),
        ),
      );
  }
}