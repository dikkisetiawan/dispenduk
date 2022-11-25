import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/info_layanan_widget.dart';
import '../widgets/ktitle_widget.dart';
import '/cubit/auth_cubit.dart';

import '../theme.dart';
import '../widgets/ktext_field_widget.dart';
import '../widgets/kprimary_button_widget.dart';
import 'konfirmasi_request_layanan_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.layananDipilih});

  final String layananDipilih;

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController(text: '');
  final TextEditingController passwordController =
      TextEditingController(text: '');
  final TextEditingController confirmPasswordController =
      TextEditingController(text: '');

  bool passwordVisible = false;
  bool passwordConfrimationVisible = false;
  bool isChecked = false;
  bool isPasswordMatch = false;

  @override
  void dispose() {
    // TODO: implement dispose
    emailController;
    passwordController;
    confirmPasswordController;
    super.dispose();
  }

  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: bodyWidget(context),
    );
  }

  ListView bodyWidget(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(defaultMargin),
      physics: const BouncingScrollPhysics(),
      children: [
        const SizedBox(
          height: defaultMargin * 3,
        ),
        InfoLayananWidget(layananDipilih: widget.layananDipilih),
        const SizedBox(
          height: defaultMargin,
        ),
        const KtitleWidget('Harap Mendaftar \nterlebih dahulu'),
        const SizedBox(
          height: defaultMargin,
        ),
        formWidget(),
        const SizedBox(
          height: defaultMargin,
        ),
        consentWidget(),
        const SizedBox(
          height: defaultMargin,
        ),
        buttonWidget(),
        const SizedBox(
          height: defaultMargin * 2,
        ),
        loginLinkWidget(context),
      ],
    );
  }

  Row loginLinkWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Sudah Punya Akun? ",
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
    );
  }

  BlocConsumer<AuthCubit, AuthState> buttonWidget() {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        print('the state is $state');
        if (state is AuthSuccess) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => KonfirmasiRequestLayananScreen(
                    layananDipilih: widget.layananDipilih),
              ));
        } else if (state is AuthFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: kWarningColor,
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
          buttonColor: kPrimaryColor,
          textValue: 'Register',
          textColor: kWhiteColor,
          onPressed: () {
            isChecked
                ? context.read<AuthCubit>().signUp(
                      email: emailController.text,
                      password: passwordController.text,
                    )
                : ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: kWarningColor,
                      content: const Text(
                        'Apakah anda setuju dengan Syarat dan Ketentuan di atas?',
                      ),
                    ),
                  );
          },
        );
      },
    );
  }

  Row consentWidget() {
    return Row(
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
              color: isChecked ? kPrimaryColor : Colors.transparent,
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
              'Dengan membuat akun, anda setuju ',
              style: greyTextStyle,
            ),
            Text(
              ' Syarat & Ketentuan',
              style: buttonTextStyle,
            ),
          ],
        ),
      ],
    );
  }

  Form formWidget() {
    return Form(
      child: Column(
        children: [
          KtextFieldWidget(
            hintText: 'Email',
            controller: emailController,
            suffixIcon: const SizedBox(),
          ),
          const SizedBox(
            height: defaultMargin,
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
            height: defaultMargin,
          ),
          KtextFieldWidget(
            hintText: 'Confirm Password',
            controller: confirmPasswordController,
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
            height: defaultMargin,
          ),
        ],
      ),
    );
  }
}
