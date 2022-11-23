import 'package:dispenduk/ui/screens/register_screen.dart';
import 'package:flutter/material.dart';

import '/models/layanan_model.dart';
import '/ui/theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: kategoriLayananList.length,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: appBarWidget(),
        body: TabBarView(children: [
          tabBarViewWidget(context),
          tabBarViewWidget(context),
          tabBarViewWidget(context),
          tabBarViewWidget(context),
          tabBarViewWidget(context),
          tabBarViewWidget(context)
        ]),
      ),
    );
  }

  Widget tabBarViewWidget(BuildContext context) {
    int mapIndex = 0;
    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(defaultMargin),
      children: layananList.keys.map((e) {
        mapIndex++;
        return listTileWidget(e, mapIndex, context);
      }).toList(),
    );
  }

  Widget listTileWidget(String key, int mapIndex, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: defaultMargin),
      child: ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RegisterScreen(),
              ));
        },
        shape: RoundedRectangleBorder(borderRadius: kBorderRadius),
        contentPadding: const EdgeInsets.symmetric(
            vertical: defaultMargin, horizontal: defaultMargin / 2),
        tileColor: kWhiteColor,
        hoverColor: kSecondaryColor,
        leading: CircleAvatar(
          backgroundColor: kPrimaryColor,
          radius: 20,
          child: Text(
            mapIndex.toString(),
            style: whiteTextStyle.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              layananList[key]!,
              style: greenTextStyle,
            ),
            Text(
              'Syarat: KTP, Surat',
              style: greyTextStyle.copyWith(fontSize: 14),
            )
          ],
        ),
        trailing: const Text('20 Menit'),
      ),
    );
  }

  AppBar appBarWidget() => AppBar(
        elevation: 2.0,
        backgroundColor: kWhiteColor,
        centerTitle: true,
        toolbarHeight: 120,
        title: Text(
          'Layanan Dispenduk',
          style: blackTextStyle,
        ),
        bottom: tabBarWidget(),
      );

  TabBar tabBarWidget() {
    return TabBar(
      physics: const BouncingScrollPhysics(),
      indicatorColor: kPrimaryColor,
      labelPadding: const EdgeInsets.all(defaultMargin / 2),
      labelColor: kPrimaryColor,
      labelStyle: greenTextStyle,
      unselectedLabelColor: kDarkGreyColor,
      isScrollable: true,
      tabs: kategoriLayananList.keys.map((e) => tabBarItemWidget(e)).toList(),
    );
  }

  Widget tabBarItemWidget(String key) {
    return Column(
      children: [
        Icon(
          kategoriLayananList[key],
          color: kDarkGreyColor,
          size: 40,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          key,
        ),
      ],
    );
  }
}
