import 'package:fishing_app/features/fish_details/presentation/cubit/fish_details_cubit.dart';
import 'package:fishing_app/features/fish_details/presentation/cubit/fish_details_state.dart';
import 'package:fishing_app/router/screen_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class FishDetailsScreen extends StatelessWidget {
  const FishDetailsScreen({required this.fishId, super.key});

  final int fishId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FishDetailsCubit, FishDetailsState>(
      builder: (context, state) {
        return switch (state) {
          FishDetailsInitial() || FishDetailsLoading() => const Center(
            child: CircularProgressIndicator(),
          ),
          FishDetailsLoaded(fish: final fish) => Scaffold(
            backgroundColor: const Color(0xffD4D7B7),
            body: Column(
              spacing: 30,
              children: [
                SizedBox(
                  height: 200,
                  width: .infinity,
                  child: Stack(
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/fishing_logo.png',
                          width: .infinity,
                          height: .infinity,
                          fit: .cover,
                        ),
                      ),
                      Positioned(
                        top: 50,
                        left: 20,
                        child: GestureDetector(
                          onTap: () => context.goNamed(ScreenNames.home),
                          child: Container(
                            height: 48,
                            width: 48,
                            padding: const .all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xffA2B568),
                              borderRadius: .circular(4),
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const .symmetric(horizontal: 24.0, vertical: 20.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: .spaceBetween,
                          children: [
                            Column(
                              spacing: 35,
                              children: [
                                Row(
                                  spacing: 20,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/fish.svg',
                                      alignment: .centerLeft,
                                      width: 28,
                                      height: 28,
                                      fit: .fitHeight,
                                    ),
                                    Text(
                                      fish.name,
                                      style: const TextStyle(
                                        fontFamily: 'Open Sans',
                                        fontWeight: .w700,
                                        fontSize: 24,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  spacing: 20,
                                  children: [
                                    const Icon(
                                      Icons.straighten,
                                      size: 48,
                                      color: Colors.black,
                                    ),
                                    Text(
                                        '${fish.length} cm',
                                        style: const TextStyle(
                                          fontFamily: 'Open Sans',
                                          fontWeight: .w700,
                                          fontSize: 24,
                                        ),

                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
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
                    onTap: () => context.goNamed(ScreenNames.fishingLog),
                    minLeadingWidth: 32,
                    horizontalTitleGap: 25,
                    contentPadding: const .symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
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
                    contentPadding: const .symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
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
                    contentPadding: const .symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
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
          ),
          FishDetailsError() => const Center(
            child: Text('Something went wrong'),
          ),
        };
      },
    );
  }
}