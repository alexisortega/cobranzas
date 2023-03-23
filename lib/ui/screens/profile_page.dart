import 'package:cobranzas/constants.dart';
import 'package:cobranzas/repository/authentication.dart';
import 'package:cobranzas/ui/screens/widgets/profile_widget.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(height: size.height * .01),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 150,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Constants.blueColor.withOpacity(.5),
                        width: 8.0,
                      ),
                    ),
                    child: const CircleAvatar(
                      radius: 60,
                      backgroundImage:
                          ExactAssetImage('assets/images/profile.jpg'),
                    ),
                  ),
                ],
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Row(
                        children: [
                          Text(
                            'John Doe',
                            style: TextStyle(
                              color: Constants.orangeColor,
                              fontSize: 20,
                            ),
                          ),
                          SizedBox(
                              height: 24,
                              child: Image.asset("assets/images/verified.png")),
                        ],
                      ),
                    ),
                  ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'johndoe@gmail.com',
                    style: TextStyle(
                      color: Constants.orangeColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: .3),
              Column(children: [
                GestureDetector(
                  onTap: () {},
                  child: const ProfileWidget(
                    icon: Icons.person,
                    title: 'Mi perfil',
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: const ProfileWidget(
                    icon: Icons.settings,
                    title: 'Configuraciones',
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: const ProfileWidget(
                    icon: Icons.notifications,
                    title: 'otros',
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: const ProfileWidget(
                    icon: Icons.notifications,
                    title: 'otros',
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    authenticationRepository.showcerrarSesion(
                      "¿Realmente quieres salir?",
                      context
                    );
                  },
                  child: const ProfileWidget(
                    icon: Icons.explicit_outlined,
                    title: 'Salir ',
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
