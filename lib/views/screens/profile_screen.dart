import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newsly_app/models/user_model.dart';
import 'package:newsly_app/resources/widgets/textformfields.dart';
import 'package:newsly_app/utils/snackbars.dart';
import 'package:newsly_app/view_models/auth_viewmodel.dart';
import 'package:provider/provider.dart';

class ProfilScreen extends StatelessWidget {
  const ProfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: const Text(
            'Profile',
            style: TextStyle(color: Colors.blue),
          ),
          actions: [
            Consumer<AuthViewModel>(builder: (context, authViewModel, child) {
              return IconButton(
                onPressed: () => authViewModel.logout(context: context),
                icon: const Icon(
                  Icons.login,
                  color: Colors.blue,
                ),
              );
            }),
          ],
        ),
        body: Consumer<AuthViewModel>(builder: (context, authViewModel, child) {
          return FutureBuilder(
            future: FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .get(),
            builder: (context,
                AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                    snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting ||
                  !snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
                  snapshot.data!;

              UserModel user = UserModel.fromJson(documentSnapshot.data()!);

              authViewModel.nameController.text = user.fullName;
              authViewModel.emailController.text = user.email;
              authViewModel.phoneNumController.text = user.phoneNum.toString();
              authViewModel.dobController.text = user.dob.toString();

              return Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView(
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      const Text(
                        'Your Profile',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 26.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Image.network(
                        'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
                        height: 200,
                      ),
                      Text(
                        authViewModel.emailController.text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20.0,
                          letterSpacing: 5.0,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                          hintText: 'Enter your name',
                          obsText: false,
                          textController: authViewModel.nameController,
                          icon: Icons.perm_identity,
                          errorText: 'enter your name'),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomTextFormField(
                          hintText: 'Enter your phone Number',
                          obsText: false,
                          textController: authViewModel.phoneNumController,
                          icon: Icons.phone,
                          errorText: 'enter your phoneNo.'),
                      const SizedBox(
                        height: 5,
                      ),
                      CustomTextFormField(
                          hintText: 'Enter your DOB',
                          obsText: false,
                          textController: authViewModel.dobController,
                          icon: Icons.date_range,
                          errorText: 'enter your DOB'),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () async {
                          UserModel updatedUser = UserModel(
                            followedCategories: [],
                            savedArticle: [],
                            id: FirebaseAuth.instance.currentUser!.uid,
                            email: authViewModel.emailController.text,
                            fullName: authViewModel.nameController.text,
                            phoneNum: authViewModel.phoneNumController.text,
                            dob: authViewModel.dobController.text,
                          );
                          openIconSnackBar(
                            context,
                            'Your profile updated',
                            const Icon(
                              Icons.check,
                              color: Colors.white,
                            ),
                          );
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .update(updatedUser.toJson());
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
                              'Update Profile',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }));
  }
}
