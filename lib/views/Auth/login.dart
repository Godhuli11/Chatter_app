import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_threads/controllers/auth_controller.dart';
import 'package:my_threads/widgets/auth_input.dart';
import 'package:get/get.dart';
import 'package:form_validator/form_validator.dart';
import '../../routes/routes_name.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _form =  GlobalKey<FormState>();
  final TextEditingController emailController =
      TextEditingController(text: "");
  final TextEditingController passwordController =
  TextEditingController(text: "");
  final AuthController authController = Get.put(AuthController());


 //Submit method
  void submit () {
    if(_form.currentState!.validate()){
      authController.login(emailController.text, passwordController.text);
    }
  }


  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: _form,
              child: Column(
                children: [
                  Image.asset("assets/images/logo.png",
                    width: 60,
                  height: 60,),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Login",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),),
                        Text("Welcome Back")
                      ],
                    ),
                  ),
                const SizedBox(height: 20,),
                  AuthInput(
                    label: "Email",
                    hintText: "Enter your email",
                    controller: emailController,
                    validatorCallback: ValidationBuilder().email().build(),),
                  const SizedBox(height: 20,),
                   AuthInput(
                    label: "Password",
                    hintText: "Enter your password",
                    isPasswordField: true,
                    controller: passwordController,
                     validatorCallback: ValidationBuilder().required().build(),),
                   const SizedBox(height: 20,),
                  ElevatedButton(onPressed: submit,
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(const Size.fromHeight(40),
                        ),
                      ),
                      child: const Text("Submit")),
                  const SizedBox(height: 20,),
                  Text.rich(TextSpan(
                    children: [TextSpan(text: "Sign up ",
                    style: TextStyle(fontWeight: FontWeight.bold),
                    recognizer: TapGestureRecognizer()..onTap = () => Get.toNamed(RouteNames.register)),],
                    text: "Don't have an account? "
                  ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
