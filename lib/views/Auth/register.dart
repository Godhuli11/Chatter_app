import 'package:form_validator/form_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_threads/controllers/auth_controller.dart';
import 'package:my_threads/utils/helper.dart';
import 'package:my_threads/widgets/auth_input.dart';
import 'package:get/get.dart';

import '../../routes/routes_name.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

// class _RegisterState extends State<Register> {
//   final GlobalKey<FormState> _form =  GlobalKey<FormState>();
//   final TextEditingController nameController =
//   TextEditingController(text: "");
//   final TextEditingController emailController =
//   TextEditingController(text: "");
//   final TextEditingController passwordController =
//   TextEditingController(text: "");
//   final TextEditingController cpasswordController =
//   TextEditingController(text: "");
//   final AuthController controller = Get.put(AuthController());
//
//   //Submit method
//
//   void submit () {
//
//       if(_form.currentState!.validate()){
//         controller.register(nameController.text, emailController.text, passwordController.text);
//       }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.all(10.0),
//             child: Form(
//               key: _form,
//               child: Column(
//                 children: [
//                       Image.asset("assets/images/logo.png",
//                         width: 60,
//                         height: 60,),
//                       Align(
//                         alignment: Alignment.topLeft,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text("Register",
//                               style: TextStyle(
//                                 fontSize: 25,
//                                 fontWeight: FontWeight.bold,
//                               ),),
//                             Text("Welcome to Threads redefined")
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 20,),
//                       AuthInput(
//                         label: "Name",
//                         hintText: "Enter your name",
//                         controller: nameController,
//                         validatorCallback: ValidationBuilder().required().minLength(3).maxLength(50).build(),),
//                       const SizedBox(height: 20,),
//                       AuthInput(
//                         label: "Email",
//                         hintText: "Enter your email",
//                         controller: emailController,
//                         validatorCallback: ValidationBuilder().required().email().build(),),
//                       const SizedBox(height: 20,),
//                       AuthInput(
//                         label: "Password",
//                         hintText: "Enter your password",
//                         isPasswordField: true,
//                         controller: passwordController,
//                         validatorCallback: ValidationBuilder().required().minLength(6).maxLength(50).build(),),
//                       const SizedBox(height: 20,),
//                       AuthInput(
//                         label: "Confirm Password",
//                         hintText: "Confirm your password",
//                         isPasswordField: true,
//                         controller: cpasswordController,
//                         validatorCallback:(arg){
//                           if(passwordController.text != arg){
//                             return "Passwords donot match";
//                           }
//                           return null;
//                         },),
//                       const SizedBox(height: 20,),
//                       Obx(() => ElevatedButton(onPressed: submit,
//                           style: ButtonStyle(
//                             minimumSize: MaterialStateProperty.all(const Size.fromHeight(40),
//                             ),
//                           ),
//                           child: Text( controller.registerLoading.value ? "Processing..." : "Submit"),)),
//                       const SizedBox(height: 20,),
//                       Text.rich(TextSpan(
//                           children: [TextSpan(text: "Login",
//                               style: TextStyle(fontWeight: FontWeight.bold),
//                               recognizer: TapGestureRecognizer()..onTap = () => Get.toNamed(RouteNames.login)),],
//                           text: "Already have an account? "
//                       ))
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController(text: "");
  final TextEditingController emailController = TextEditingController(text: "");
  final TextEditingController passwordController = TextEditingController(text: "");
  final TextEditingController cpasswordController = TextEditingController(text: "");
  final AuthController controller = Get.put(AuthController());

  // Submit method
  void submit() {
    if (_form.currentState!.validate()) {
      controller.register(nameController.text, emailController.text, passwordController.text);
    }
  }

  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    cpasswordController.dispose();

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
                  Image.asset(
                    "assets/images/logo.png",
                    width: 60,
                    height: 60,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Register",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("Welcome to Threads redefined"),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  AuthInput(
                    label: "Name",
                    hintText: "Enter your name",
                    controller: nameController,
                    validatorCallback: ValidationBuilder().required().minLength(3).maxLength(50).build(),
                  ),
                  const SizedBox(height: 20,),
                  AuthInput(
                    label: "Email",
                    hintText: "Enter your email",
                    controller: emailController,
                    validatorCallback: ValidationBuilder().required().email().build(),
                  ),
                  const SizedBox(height: 20,),
                  AuthInput(
                    label: "Password",
                    hintText: "Enter your password",
                    isPasswordField: true,
                    controller: passwordController,
                    validatorCallback: ValidationBuilder().required().minLength(6).maxLength(50).build(),
                  ),
                  const SizedBox(height: 20,),
                  AuthInput(
                    label: "Confirm Password",
                    hintText: "Confirm your password",
                    isPasswordField: true,
                    controller: cpasswordController,
                    validatorCallback: (arg) {
                      if (passwordController.text != arg) {
                        return "Passwords don't match";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20,),
                  Obx(() => ElevatedButton(
                    onPressed: submit,
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all(const Size.fromHeight(40)),
                    ),
                    child: Text(controller.registerLoading.value ? "Processing..." : "Submit"),
                  )),
                  const SizedBox(height: 20,),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "Login",
                          style: TextStyle(fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()..onTap = () => Get.toNamed(RouteNames.login),
                        ),
                      ],
                      text: "Already have an account? ",
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
