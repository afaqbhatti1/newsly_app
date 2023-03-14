import 'package:flutter/material.dart';
import 'package:newsly_app/Routes/routes_name.dart';
import 'package:newsly_app/resources/widgets/textformfields.dart';
import 'package:newsly_app/utils/snackbars.dart';
import 'package:provider/provider.dart';

import '../../view_models/auth_viewmodel.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthViewModel>(builder: (context, authViewModel, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            padding: const EdgeInsets.all(0.0),
            children: [
              Image.asset('assets/images/logo.png'),
              CustomTextFormField(
                hintText: 'Name',
                obsText: false,
                textController: authViewModel.nameController,
                icon: Icons.person,
                errorText: 'Please Enter Name',
              ),
              const SizedBox(
                height: 2,
              ),
              CustomTextFormField(
                hintText: 'E-mail',
                obsText: false,
                textController: authViewModel.emailController,
                icon: Icons.email,
                errorText: 'Please a valid Email',
              ),
              const SizedBox(
                height: 2,
              ),
              CustomTextFormField(
                hintText: 'Password',
                obsText: true,
                textController: authViewModel.passwordController,
                icon: Icons.lock,
                errorText: 'Please a Enter Password',
              ),
              const SizedBox(
                height: 2,
              ),
              CustomTextFormField(
                hintText: 'DOB 1/18/2002',
                obsText: false,
                textController: authViewModel.dobController,
                icon: Icons.date_range_outlined,
                errorText: 'Please enter DOB',
              ),
              const SizedBox(
                height: 2,
              ),
              CustomTextFormField(
                hintText: 'Phone Number',
                obsText: false,
                textController: authViewModel.phoneNumController,
                icon: Icons.phone,
                errorText: 'Please enter phone no',
              ),
              const SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () async {
                  await authViewModel.signUp(
                    context: context,
                    email: authViewModel.emailController.text,
                    password: authViewModel.passwordController.text,
                    name: authViewModel.nameController.text,
                    phoneNo: authViewModel.phoneNumController.text,
                    dob: authViewModel.dobController.text,
                  );
                  if (authViewModel.message == true) {
                    openIconSnackBar(
                        context,
                        'Successfully SignUp',
                        const Icon(
                          Icons.check,
                          color: Colors.white,
                        ));
                    Navigator.pushReplacementNamed(context, bottomNavBar);
                  } else {
                    openIconSnackBar(
                        context,
                        authViewModel.message.toString(),
                        const Icon(
                          Icons.close,
                          color: Colors.white,
                        ));
                  }
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.blue,
                  ),
                  child: const Center(
                    child: Text(
                      'SignUp',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'or continue with',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
              Consumer<AuthViewModel>(
                builder: (context, value, child) {
                  return InkWell(
                    onTap: () {
                      value.signInWithGoogle(context: context);
                    },
                    child: Image.asset(
                      'assets/images/googlebutton.png',
                      height: 50,
                      width: 40,
                    ),
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account ? ',
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 15),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, logIn);
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                          color: Color(0xff1877F2),
                          fontFamily: 'Poppins',
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
