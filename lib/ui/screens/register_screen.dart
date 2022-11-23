import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/cubit/auth_cubit.dart';

import '../theme.dart';
import '../widgets/ktext_field_widget.dart';
import '../widgets/kprimary_button_widget.dart';
import 'konfirmasi_request_layanan_screen.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController(text: '');
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passwordController =
      TextEditingController(text: '');
  final TextEditingController idKartuKeluargaController =
      TextEditingController(text: '');
  final TextEditingController nomorIndukKependudukanController =
      TextEditingController(text: '');
  final TextEditingController tanggalLahirController =
      TextEditingController(text: '');
  final TextEditingController tempatLahirController =
      TextEditingController(text: '');

  bool passwordVisible = false;
  bool passwordConfrimationVisible = false;
  bool isChecked = false;
  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Register new\naccount',
                    style: blackTextStyle,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
              const SizedBox(
                height: 48,
              ),
              Form(
                child: Column(
                  children: [
                    KtextFieldWidget(
                      hintText: 'Name',
                      controller: nameController,
                      suffixIcon: const SizedBox(),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    KtextFieldWidget(
                      hintText: 'Email',
                      controller: emailController,
                      suffixIcon: const SizedBox(),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    KtextFieldWidget(
                      hintText: 'Password',
                      controller: passwordController,
                      obscureText: !passwordVisible,
                      suffixIcon: IconButton(
                        color: kDarkGreyColor,
                        splashRadius: 1,
                        icon: Icon(passwordVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined),
                        onPressed: togglePassword,
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isChecked = !isChecked;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isChecked ? kBlueColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(4.0),
                        border: isChecked
                            ? null
                            : Border.all(color: kDarkGreyColor, width: 1.5),
                      ),
                      width: 20,
                      height: 20,
                      child: isChecked
                          ? const Icon(
                              Icons.check,
                              size: 20,
                              color: Colors.white,
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'By creating an account, you agree to our',
                        style: greyTextStyle,
                      ),
                      Text(
                        'Terms & Conditions',
                        style: buttonTextStyle,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthSuccess) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              KonfirmasiRequestLayananScreen(),
                        ),
                        (route) => false);
                  } else if (state is AuthFailed) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red.shade700,
                        content: Text(
                          state.error,
                        ),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return KprimaryButtonWidget(
                    buttonColor: kBlueColor,
                    textValue: 'Register',
                    textColor: Colors.white,
                    onPressed: () {
                      isChecked
                          ? context.read<AuthCubit>().signUp(
                                namaLengkap: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                idKartuKeluarga: int.tryParse(
                                        idKartuKeluargaController.text) ??
                                    0,
                                nomorIndukKependudukan: int.tryParse(
                                        nomorIndukKependudukanController
                                            .text) ??
                                    0,
                                tanggalLahir: DateTime.tryParse(
                                    tanggalLahirController.text)!,
                                tempatLahir: tempatLahirController.text,
                              )
                          : ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.red.shade700,
                                content: const Text(
                                  'Are you agree with our Tems & Conditions?',
                                ),
                              ),
                            );
                    },
                  );
                },
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: greyTextStyle,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(
                        context,
                      );
                    },
                    child: Text(
                      'Login',
                      style: buttonTextStyle,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
