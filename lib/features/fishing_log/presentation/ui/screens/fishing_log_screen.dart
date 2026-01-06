import 'dart:io';
import 'package:fishing_app/features/fishing_log/presentation/cubit/fishing_log_cubit.dart';
import 'package:fishing_app/features/fishing_log/presentation/cubit/fishing_log_state.dart';
import 'package:fishing_app/router/screen_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class FishingLogScreen extends StatelessWidget {
  const FishingLogScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffD4D7B7),
      appBar: AppBar(
        titleTextStyle: const TextStyle(
          fontFamily: 'Open Sans',
          fontWeight: .w800,
          fontSize: 24,
          color: Color(0xff15282F),
        ),
        backgroundColor: const Color(0xffAEBE7C),
        title: const Text('Fishing Log'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const .symmetric(horizontal: 8, vertical: 8),
        child: BlocBuilder<FishingLogCubit, FishingLogState>(
          builder: (context, state) {
            return switch (state) {
              FishingLogInitial() || FishingLogLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
              FishingLogLoaded(locations: final locations) => ListView.separated(
                itemBuilder: (context, index) {
                  final location = locations[index];
                  return GestureDetector(
                    onTap: () {
                      context.pushNamed(
                        ScreenNames.sightings,
                        pathParameters: {'locationId': location.id.toString()},
                      );
                    },
                    child: Container(
                      height: 64,
                      decoration: const BoxDecoration(
                        color: Color(0xffAEBE7C),
                        borderRadius: .all(Radius.circular(4)),
                      ),
                      child: Row(
                        spacing: 10,
                        mainAxisAlignment: .start,
                        children: [
                          ClipRRect(
                            borderRadius: const .all(Radius.circular(4)),
                            child: Image.file(
                              File(location.imageUrl),
                              width: 64,
                              height: 64,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 64,
                                  height: 64,
                                  color: const Color(
                                    0xffAEBE7C,
                                  ).withValues(alpha: 0.5),
                                  child: const Icon(
                                    Icons.image_not_supported_outlined,
                                    color: Color(0xff15282F),
                                    size: 24,
                                  ),
                                );
                              },
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const .only(top: 8, right: 8),
                              child: Column(
                                spacing: 10,
                                crossAxisAlignment: .start,
                                children: [
                                  Row(
                                    mainAxisAlignment: .spaceBetween,
                                    children: [
                                      Text(
                                        location.name,
                                        style: const TextStyle(
                                          fontFamily: 'Open Sans',
                                          fontWeight: .w400,
                                          fontSize: 14,
                                          color: Color(0xff15282F),
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {},
                                        child: const Icon(Icons.edit, size: 24),
                                      ),


                                    ],
                                  ),
                                  Text(
                                    '${location.date?.day} ${location.date?.month} ${location.date?.year}',
                                    style: const TextStyle(
                                      fontFamily: 'Open Sans',
                                      fontWeight: .w300,
                                      fontSize: 13,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 8);
                },
                itemCount: locations.length,
              ),
              FishingLogError() => Center(child: Text(state.message)),
            };
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushNamed(ScreenNames.createLocation),
        backgroundColor: const Color(0xffA2B568),
        foregroundColor: const Color(0xff15282F),
        shape: RoundedRectangleBorder(borderRadius: .circular(4)),
        child: const Icon(Icons.add, size: 21),
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xffAEBE7C),
        child: ListView(
          padding: .zero,
          children: [
            const DrawerHeader(
              padding: .zero,
              margin: .zero,
              decoration: BoxDecoration(color: Color(0xff42705C)),
              child: SizedBox(
                height: 150,
                child: Align(
                  alignment: .bottomLeft,
                  child: Padding(
                    padding: .only(left: 10, bottom: 14),
                    child: Text(
                      'Fishing mesh',
                      style: TextStyle(
                        fontFamily: 'Open Sans',
                        fontWeight: .w800,
                        fontSize: 24,
                        color: Color(0xffAEBE7C),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ListTile(
              onTap: () => context.pop(),
              minLeadingWidth: 32,
              horizontalTitleGap: 25,
              contentPadding: const .symmetric(horizontal: 10, vertical: 10),
              leading: SvgPicture.asset(
                'assets/icons/book.svg',
                alignment: .centerLeft,
                width: 32,
                height: 32,
                fit: BoxFit.cover,
              ),
              title: const Text(
                'Fishing Log',
                style: TextStyle(
                  fontWeight: .w800,
                  fontSize: 20,
                  fontFamily: 'Open Sans',
                ),
              ),
            ),
            ListTile(
              onTap: () => context.goNamed(ScreenNames.home),
              minLeadingWidth: 32,
              horizontalTitleGap: 10,
              contentPadding: const .symmetric(horizontal: 10, vertical: 10),
              leading: SvgPicture.asset(
                'assets/icons/fish.svg',
                alignment: .centerLeft,
                width: 48,
                height: 24,
                fit: BoxFit.cover,
              ),
              title: const Text(
                'Catches',
                style: TextStyle(
                  fontWeight: .w800,
                  fontSize: 20,
                  fontFamily: 'Open Sans',
                ),
              ),
            ),
            ListTile(
              minLeadingWidth: 32,
              horizontalTitleGap: 23,
              contentPadding: const .symmetric(horizontal: 10, vertical: 10),
              leading: SvgPicture.asset(


                'assets/icons/location.svg',
                alignment: .centerLeft,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
              title: const Text(
                'Location',
                style: TextStyle(
                  fontWeight: .w800,
                  fontSize: 20,
                  fontFamily: 'Open Sans',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
