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
  final TextEditingController tempatLahirController =
      TextEditingController(text: '');

  DateTime? _dateTime;
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
      backgroundColor: kBackgroundColor,
      body: bodyWidget(context),
    );
  }

  ListView bodyWidget(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(defaultMargin),
      physics: const BouncingScrollPhysics(),
      children: [
        const KtitleWidget(),
        const SizedBox(
          height: defaultMargin,
        ),
        formWidget(context),
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
                builder: (context) => const KonfirmasiRequestLayananScreen(),
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
                      namaLengkap: 'test user',
                      email: 'testuser@gmail.com',
                      password: '123456',
                      idKartuKeluarga: 234234312,
                      nomorIndukKependudukan: 36235235,
                      tanggalLahir: _dateTime!,
                      tempatLahir: 'surabaya',
                    )
                : ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: kWarningColor,
                      content: const Text(
                        'Are you agree with our Tems & Conditions?',
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
    );
  }

  Form formWidget(BuildContext context) {
    return Form(
      child: Column(
        children: [
          KtextFieldWidget(
            hintText: 'Name',
            controller: nameController,
            suffixIcon: const SizedBox(),
          ),
          const SizedBox(
            height: defaultMargin,
          ),
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
            hintText: 'No KK',
            controller: idKartuKeluargaController,
            suffixIcon: const Icon(Icons.card_membership),
          ),
          const SizedBox(
            height: defaultMargin,
          ),
          KtextFieldWidget(
            hintText: 'NIK',
            controller: nomorIndukKependudukanController,
            suffixIcon: const SizedBox(),
          ),
          const SizedBox(
            height: defaultMargin,
          ),
          KtextFieldWidget(
            hintText: 'Tempat Lahir',
            controller: tempatLahirController,
            suffixIcon: const SizedBox(),
          ),
          const SizedBox(
            height: defaultMargin,
          ),
          dateTimeWidget(context)
        ],
      ),
    );
  }

  Row dateTimeWidget(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: KprimaryButtonWidget(
            buttonColor: kDarkGreyColor,
            textValue: _dateTime == null
                ? 'Tanggal Lahir'
                : 'Tanggal ${_dateTime!.day} Bulan ${_dateTime!.month} ${_dateTime!.year}',
            textColor: kWhiteColor,
            onPressed: () {
              showDatePickerWidget(context);
            },
          ),
        ),
        IconButton(
            onPressed: () {
              showDatePickerWidget(context);
            },
            icon: Icon(
              Icons.date_range,
              color: kDarkGreyColor,
            ))
      ],
    );
  }

  Future<DateTime?> showDatePickerWidget(BuildContext context) =>
      showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime.now())
          .then((date) {
        setState(() {
          _dateTime = date;
        });
      });
}

class KtitleWidget extends StatelessWidget {
  const KtitleWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
