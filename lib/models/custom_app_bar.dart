import 'package:flutter/material.dart';

class CustomButtomBar extends StatefulWidget {
  const CustomButtomBar({
    required this.color,
    super.key,
  });

  final Color color;

  @override
  State<CustomButtomBar> createState() => CustomBottomBarState();
}

class CustomBottomBarState extends State<CustomButtomBar> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(
        milliseconds: 2000,
      ),
      decoration: BoxDecoration(
        color: /* widget.color */ Colors.teal,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.house,
                size: 36,
              ),
            ),
            Container(
              height: double.infinity,
              width: 50,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white),
              child: Center(
                child: Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.color,
                  ),
                  child: Center(
                    child: Container(
                      height: 15,
                      width: 15,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Container(
                          height: 12,
                          width: 12,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: widget.color),
                          child: Center(
                            child: Container(
                              height: 5,
                              width: 5,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.person_outline_outlined,
                size: 36,
              ),
            )
          ],
        ),
      ),
    );
  }
}