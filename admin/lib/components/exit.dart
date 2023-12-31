import 'package:flutter/material.dart';

class ExitItem extends StatelessWidget {
  final String buttonText;
  final String routePath;
  final MaterialColor color;

  const ExitItem(
      {super.key,
      required this.buttonText,
      required this.routePath,
      required this.color});

  void goToScreen(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(routePath);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        goToScreen(context);
      },
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.6),
              color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(
          buttonText,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
