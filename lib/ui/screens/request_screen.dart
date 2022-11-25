import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/auth_cubit.dart';
import '../../cubit/request_layanan_cubit.dart';
import '/models/request_layanan_model.dart';
import '/ui/widgets/ktitle_widget.dart';
import 'package:flutter/material.dart';

import '/ui/theme.dart';
import 'home_screen.dart';

class RequestScreen extends StatefulWidget {
  RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  @override
  void initState() {
    //load existing tasks when logged in
    context.read<RequestLayananCubit>().fetchRequestsByCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: appBar(),
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: BlocBuilder<RequestLayananCubit, RequestLayananState>(
          builder: (context, state) {
            if (state is FetchRequestLoading) {
              return const CircularProgressIndicator();
            } else if (state is FetchAllRequestSuccess) {
              if (state.requests.isEmpty) {
                return Text(
                  'Kamu belum memiliki Request Layanan',
                  style: blackTextStyle,
                );
              } else {
                return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: state.requests.length,
                  padding: const EdgeInsets.all(defaultMargin),
                  itemBuilder: (context, index) {
                    return ListItemWidget(
                      id: state.requests[index].idPermohonan,
                      status: state.requests[index].status,
                      tanggal: state.requests[index].tanggalPermohonan!,
                      layanan: state.requests[index].layanan,
                      keterangan: state.requests[index].keterangan,
                    );
                  },
                );
              }
            }

            return SizedBox();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          heroTag: const Text('data'),
          backgroundColor: kPrimaryColor,
          onPressed: () {
            context.read<AuthCubit>().signOut();
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomeScreen(),
                ));
          },
          child: const Icon(
            Icons.add,
            size: 40.0,
          )),
    );
  }

  AppBar appBar() {
    return AppBar(
      titleSpacing: defaultMargin,
      elevation: 0.0,
      toolbarHeight: 50,
      backgroundColor: Colors.transparent,
      title: fixedHeaderContentWidget(),
      centerTitle: false,
    );
  }

  Widget fixedHeaderContentWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        SizedBox(
          height: defaultMargin * 2,
        ),
        KtitleWidget('Riwayat'),
        SizedBox(
          height: defaultMargin,
        ),
      ],
    );
  }
}

class ListItemWidget extends StatelessWidget {
  final String? id;
  final Status status;
  final DateTime tanggal;
  final String layanan;
  final String? keterangan;

  ListItemWidget({
    Key? key,
    this.id,
    required this.status,
    required this.tanggal,
    required this.layanan,
    required this.keterangan,
  }) : super(key: key);

  List<String> months = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Augustus',
    'September',
    'Oktober',
    'November',
    'Desember'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: defaultMargin),
      padding: const EdgeInsets.only(bottom: defaultMargin / 2),
      decoration: BoxDecoration(
        color: kWhiteColor,
        boxShadow: [kShadow],
        borderRadius: const BorderRadius.all(Radius.circular(defaultCircular)),
      ),
      child: ListTile(
        onTap: () {},
        shape: RoundedRectangleBorder(
          borderRadius: kBorderRadius,
        ),
        title: itemContentWidget(id, status, tanggal, layanan),
      ),
    );
  }

  Column itemContentWidget(
      String? id, Status status, DateTime tanggal, String layanan) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Chip(
              label: Text(
                status.name,
                style: whiteTextStyle,
              ),
              backgroundColor: status.statusValue[0],
            ),
            Text(
              id.toString(),
              style: blackTextStyle.copyWith(
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.normal,
                  fontSize: 16),
            )
          ],
        ),
        const SizedBox(
          height: defaultMargin / 2,
        ),
        Row(
          children: [
            Text('${tanggal.day} ${months[tanggal.month]} ${tanggal.year}',
                style: greenTextStyle),
            Text(' - ${tanggal.hour}:${tanggal.minute} wib',
                style: greenTextStyle.copyWith(fontWeight: FontWeight.normal))
          ],
        ),
        const SizedBox(
          height: defaultMargin / 2,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Jenis : ',
                style: blackTextStyle.copyWith(
                    fontSize: 16,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.normal)),
            Expanded(
              child: Text(
                overflow: TextOverflow.fade,
                'Layanan $layanan',
                style:
                    blackTextStyle.copyWith(letterSpacing: 0.0, fontSize: 16),
              ),
            )
          ],
        ),
        const SizedBox(
          height: defaultMargin / 2,
        ),
        keterangan == null ? SizedBox() : keteranganWidget(keterangan!)
      ],
    );
  }

  Widget keteranganWidget(String keterangan) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Keterangan : ',
            style: blackTextStyle.copyWith(
              fontSize: 16,
              letterSpacing: 0.0,
            )),
        Text(
          overflow: TextOverflow.fade,
          keterangan,
          style: blackTextStyle.copyWith(
              letterSpacing: 0.0, fontSize: 16, fontWeight: FontWeight.normal),
        )
      ],
    );
  }
}
