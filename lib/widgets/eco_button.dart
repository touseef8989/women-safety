import 'package:flutter/material.dart';

class EcoButton extends StatelessWidget {
  final String? title;
  final bool? isLoginButton;
  final VoidCallback? onPress;
  final bool? isLoading;
  // final bool _eaditnamec = true;
  // final bool _eaditemailc = true;
  // final bool _eaditpasswordc = true;

  EcoButton({
    Key? key,
    this.title,
    this.isLoading = false,
    this.isLoginButton = false,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: 60,
        margin: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
        width: double.infinity,
        decoration: BoxDecoration(
          color: isLoginButton == false
              ? Colors.white
              : Color.fromARGB(255, 255, 117, 163),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: isLoginButton == false
                  ? Color.fromARGB(255, 255, 117, 163)
                  : Color.fromARGB(255, 255, 117, 163)),
        ),
        child: Stack(
          children: [
            Visibility(
              visible: isLoading! ? false : true,
              child: Center(
                child: Text(
                  title ?? "button",
                  style: TextStyle(
                      color: isLoginButton == false
                          ? Color.fromARGB(255, 255, 117, 163)
                          : Colors.white,
                      fontSize: 16),
                ),
              ),
            ),
            Visibility(
              visible: isLoading!,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
