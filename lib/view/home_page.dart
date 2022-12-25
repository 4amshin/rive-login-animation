import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //email textField controller
  FocusNode emailFocusNode = FocusNode();
  TextEditingController emailController = TextEditingController();

  //email textField controller
  FocusNode passFocusNode = FocusNode();
  TextEditingController passController = TextEditingController();

  //rive controller & input
  StateMachineController? controller;

  SMIInput<bool>? isChecking;
  SMIInput<double>? numLook;
  SMIInput<bool>? isHandsUp;

  SMIInput<bool>? trigSuccess;
  SMIInput<bool>? trigFail;

  //function
  @override
  void initState() {
    emailFocusNode.addListener((emailFocus));
    passFocusNode.addListener((passFocus));
    super.initState();
  }

  @override
  void dispose() {
    emailFocusNode.removeListener((emailFocus));
    passFocusNode.removeListener((passFocus));
    super.dispose();
  }

  void emailFocus() {
    isChecking?.change(emailFocusNode.hasFocus);
  }

  void passFocus() {
    isHandsUp?.change(passFocusNode.hasFocus);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffd6e2ea),
      body: SafeArea(
        minimum: const EdgeInsets.only(
          left: 25,
          right: 25,
          top: 25,
        ),
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(height: 20),
            Container(
              height: 45,
              width: 45,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/logo/plant_logo.png"),
                ),
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              'Rive + Flutter \nAnimated Guardian \nPolar Bear',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 230,
              width: 230,
              child: RiveAnimation.asset(
                "assets/animation/bear.riv",
                fit: BoxFit.fitHeight,
                stateMachines: const ["Login Machine"],
                onInit: (artboard) {
                  controller = StateMachineController.fromArtboard(
                    artboard,
                    //from rive you can see it in rive editor
                    "Login Machine",
                  );

                  if (controller == null) return;

                  artboard.addController(controller!);
                  isChecking = controller?.findInput("isChecking");
                  numLook = controller?.findInput("numLook");
                  isHandsUp = controller?.findInput("isHandsUp");
                  trigSuccess = controller?.findInput("trigSuccess");
                  trigFail = controller?.findInput("trigFail");
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      focusNode: emailFocusNode,
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[500],
                        ),
                        border: InputBorder.none,
                      ),
                      onChanged: (value) {
                        numLook?.change(value.length.toDouble());
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      focusNode: passFocusNode,
                      controller: passController,
                      decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[500],
                        ),
                        border: InputBorder.none,
                      ),
                      obscureText: true,
                      onChanged: (value) {},
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 64,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff00254d),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        "Login",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
