import 'package:cobranzas/constants.dart';
import 'package:cobranzas/models/animations_transtions.dart';

import 'package:cobranzas/ui/screens/widgets/signin_page.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int currentIndex = 0;

  late String pres1;
  late String pres2;
  late String pres3;
  @override
  void initState() {
    super.initState();
    pres1 = "assets/imagenPres2.png";
    pres2 = 'assets/imagenPres.png';
    pres3 = 'assets/imagenPres3.png';
  }

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20, top: 20),
            child: InkWell(
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (_) => const SignIn())); // LOGIN
              }, //to login screen. We will update later
              child: const Text(
                'Omitir',
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          )
        ],
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView(
            onPageChanged: (int page) {
              setState(() {
                currentIndex = page;
              });
            },
            controller: _pageController,
            children: [
              createPage(
                image: pres1,
                title: Constants.titleOne,
                description: Constants.descriptionOne,
              ),
              createPage(
                image: pres2,
                title: Constants.titleTwo,
                description: Constants.descriptionTwo,
              ),
              createPage(
                image: pres3,
                title: Constants.titleThree,
                description: Constants.descriptionThree,
              ),
            ],
          ),
          Positioned(
            bottom: 80,
            left: 30,
            child: Row(
              children: _buildIndicator(),
            ),
          ),
          Positioned(
            bottom: 60,
            right: 30,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Constants.blueColor,
              ),
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      if (currentIndex < 2) {
                        currentIndex++;
                        if (currentIndex < 3) {
                          _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn);
                        }
                      } else {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const SignIn())); //LOGIN
                      }
                    });
                  },
                  icon: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Colors.orange,
                  )),
            ),
          ),
        ],
      ),
    );
  }

  //Extra Widgets

  //Create the indicator decorations widget
  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 10.0,
      width: isActive ? 20 : 8,
      margin: const EdgeInsets.only(right: 5.0),
      decoration: BoxDecoration(
        color: Constants.blueColor,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

//Create the indicator list
  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];

    for (int i = 0; i < 3; i++) {
      if (currentIndex == i) {
        indicators.add(_indicator(true));
      } else {
        indicators.add(_indicator(false));
      }
    }

    return indicators;
  }
}

// ignore: camel_case_types
class createPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const createPage({
    Key? key,
    required this.image,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 150, top: 10),
      child: Container(
        height: size.height,
        width: size.width,
        color: Colors.transparent,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.35,
                width: size.width * .75,
                child: shakeTransition(
                  duration: const Duration(milliseconds: 400),
                  offset: 140.0,
                  axis: Axis.vertical,
                  child: Container(
                    color: Colors.transparent,
                    child: Image.asset(image),
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              shakeTransition(
                duration: const Duration(milliseconds: 900),
                offset: 140.0,
                axis: Axis.horizontal,
                child: Container(
                  color: Colors.transparent,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Constants.blueColor,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              shakeTransition(
                duration: const Duration(milliseconds: 900),
                offset: 140.0,
                axis: Axis.vertical,
                child: Container(
                  height: 40,
                  color: Colors.transparent,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Text(
                      description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Constants.orangeColor,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
