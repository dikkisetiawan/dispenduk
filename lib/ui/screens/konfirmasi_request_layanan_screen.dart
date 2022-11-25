import 'dart:math';

import 'package:dispenduk/ui/screens/home_screen.dart';

import '/cubit/request_layanan_cubit.dart';
import '/models/request_layanan_model.dart';

import '/ui/screens/request_screen.dart';

import '/ui/theme.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/auth_cubit.dart';
import '../widgets/kprimary_button_widget.dart';
import '../widgets/ktext_field_widget.dart';
import '../widgets/ktitle_widget.dart';

class KonfirmasiRequestLayananScreen extends StatefulWidget {
  KonfirmasiRequestLayananScreen({super.key, required this.layananDipilih});

  final String layananDipilih;

  @override
  State<KonfirmasiRequestLayananScreen> createState() =>
      _KonfirmasiRequestLayananScreenState();
}

class _KonfirmasiRequestLayananScreenState
    extends State<KonfirmasiRequestLayananScreen> {
  final TextEditingController nomorIndukKependudukanController =
      TextEditingController(text: '');
  final TextEditingController idKartuKeluargaController =
      TextEditingController(text: '');
  final TextEditingController namaLengkapController =
      TextEditingController(text: '');
  final TextEditingController tempatLahirController =
      TextEditingController(text: '');

  DateTime? _dateTime;

  List<Status> status = [
    Status.Ditolak,
    Status.Pending,
    Status.Revisi,
    Status.Validasi,
    Status.Verifikasi
  ];

  List<String?> keterangan = [
    'Berkas Kurang',
    'Harap periksa Dokumen anda',
    'Foto KTP anda belum diperbarui',
    null
  ];

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
          height: defaultMargin * 2,
        ),
        Text(
          'Anda Memilih Layanan \n${widget.layananDipilih}',
          style: greenTextStyle,
        ),
        const SizedBox(
          height: defaultMargin,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const KtitleWidget('Konfirmasi Data anda'),
            IconButton(
                onPressed: () {
                  context.read<AuthCubit>().signOut();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ));
                },
                icon: Icon(Icons.logout))
          ],
        ),
        const SizedBox(
          height: defaultMargin,
        ),
        formBuilderWidget(),
        const SizedBox(
          height: defaultMargin,
        ),
        buttonWidget(),
        const SizedBox(
          height: defaultMargin * 2,
        ),
      ],
    );
  }

  Widget formBuilderWidget() {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is AuthSuccess) {
          if (state.user.namaLengkap != null) {
            namaLengkapController.text = state.user.namaLengkap!;
            nomorIndukKependudukanController.text =
                state.user.nomorIndukKependudukan.toString();
            idKartuKeluargaController.text =
                state.user.idKartuKeluarga.toString();
            tempatLahirController.text = state.user.tempatLahir!;

            return formWidget(
              context,
              namaLengkap: state.user.namaLengkap,
              nik: state.user.nomorIndukKependudukan,
              kk: state.user.idKartuKeluarga,
              tempatLahir: state.user.tempatLahir,
            );
          }
        }
        return formWidget(context);
      },
    );
  }

  Form formWidget(BuildContext context,
      {String? namaLengkap, int? nik, int? kk, String? tempatLahir}) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          KtextFieldWidget(
            title: 'Nama Lengkap',
            hintText: namaLengkap ?? 'Nama Lengkap',
            controller: namaLengkapController,
            suffixIcon: const SizedBox(),
          ),
          const SizedBox(
            height: defaultMargin,
          ),
          KtextFieldWidget(
            title: 'Nomor Kartu Keluarga',
            hintText: kk == null ? 'No KK' : kk.toString(),
            controller: idKartuKeluargaController,
            suffixIcon: const SizedBox(),
          ),
          const SizedBox(
            height: defaultMargin,
          ),
          KtextFieldWidget(
            title: 'Nama Induk Kependudukan',
            hintText: nik == null ? 'No NIK' : nik.toString(),
            controller: nomorIndukKependudukanController,
            suffixIcon: const Icon(Icons.no_accounts),
          ),
          const SizedBox(
            height: defaultMargin,
          ),
          KtextFieldWidget(
            title: 'Tempat Lahir',
            hintText: tempatLahir ?? 'Tempat Lahir',
            controller: tempatLahirController,
            suffixIcon: const Icon(Icons.map),
          ),
          const SizedBox(
            height: defaultMargin,
          ),
          dateTimeWidget(context),
          const SizedBox(
            height: defaultMargin,
          )
        ],
      ),
    );
  }

  Row dateTimeWidget(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is AuthSuccess) {
                return tanggalButtonWidget(context, state.user.tanggalLahir);
              }

              return tanggalButtonWidget(context, _dateTime);
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

  KprimaryButtonWidget tanggalButtonWidget(
      BuildContext context, DateTime? tanggalLahir) {
    if (tanggalLahir != null) {
      _dateTime = tanggalLahir;
    }
    return KprimaryButtonWidget(
      buttonColor: kDarkGreyColor.withOpacity(0.5),
      textValue: _dateTime == null
          ? 'Tanggal Lahir'
          : 'Tanggal ${_dateTime!.day} Bulan ${_dateTime!.month} ${_dateTime!.year}',
      textColor: kWhiteColor,
      onPressed: () {
        showDatePickerWidget(context);
      },
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

  BlocConsumer<AuthCubit, AuthState> buttonWidget() {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        print('konfirmasi_layanan_request_screen.dart the state is $state');
        if (state is AuthSuccess) {
          print('update success ${state.user}');

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RequestScreen(),
              ));
        } else if (state is AuthFailed) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: kWarningColor,
              content: Text(
                state.error,
                style: whiteTextStyle,
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
          textValue: 'Konfirmasi Data',
          textColor: kWhiteColor,
          onPressed: () {
            context.read<AuthCubit>().updateCurrentUser(
                nomorIndukKependudukan:
                    int.parse(nomorIndukKependudukanController.text),
                idKartuKeluarga: int.parse(idKartuKeluargaController.text),
                namaLengkap: namaLengkapController.text,
                tempatLahir: tempatLahirController.text,
                tanggalLahir: _dateTime!);

            context.read<RequestLayananCubit>().createRequestLayanan(
                RequestLayananModel(
                    tanggalPermohonan: DateTime.now(),
                    keterangan: keterangan[Random().nextInt(3)],
                    layanan: widget.layananDipilih,
                    status: status[Random().nextInt(4)]));
          },
        );
      },
    );
  }
}
