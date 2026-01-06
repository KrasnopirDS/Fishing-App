
import 'dart:io';

import 'package:fishing_app/di/get_it.dart';
import 'package:fishing_app/features/create_location/presentation/cubit/create_location_cubit.dart';
import 'package:fishing_app/features/create_location/presentation/cubit/create_location_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class CreateLocationScreen extends StatefulWidget {
  const CreateLocationScreen({super.key});

  @override
  State<CreateLocationScreen> createState() => _CreateLocationScreenState();
}

class _CreateLocationScreenState extends State<CreateLocationScreen> {
  late final TextEditingController _locationNameController;
  final _cubit = getIt<CreateLocationCubit>();

  @override
  void initState() {
    super.initState();
    _locationNameController = TextEditingController();
  }

  @override
  void dispose() {
    _locationNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocConsumer<CreateLocationCubit, CreateLocationState>(
        listener: (context, state) {
          if (state.status == .success) {
            context.pop();
          }
          if (state.status == .error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error ?? 'Error saving location')),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xffD4D7B7),
            appBar: AppBar(
              leadingWidth: 60,
              backgroundColor: Colors.transparent,
              leading: GestureDetector(
                onTap: () => context.pop(),
                child: Center(
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xffAEBE7C),
                      borderRadius: .circular(4),
                    ),
                    alignment: .center,
                    child: SvgPicture.asset(
                      'assets/icons/canceled.svg',
                      width: 21,
                      height: 21,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              title: const Text(
                'New Location',
                style: TextStyle(
                  fontWeight: .w700,
                  fontFamily: 'Inter',
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const .symmetric(horizontal: 24, vertical: 24),
              child: Column(
                mainAxisAlignment: .start,
                crossAxisAlignment: .start,
                spacing: 8,
                children: [
                Row(
                spacing: 16,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                      const Text(
                      'Location name',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 48,
                      width: 270,
                      child: TextField(
                        controller: _locationNameController,
                        onChanged: _cubit.nameChanged,
                        decoration: InputDecoration(
                          hintText: 'Enter location name',
                          hintStyle: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            color: Colors.black,
                          ),
                          filled: true,
                          fillColor: const Color(0xffAEBE7C),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: .circular(4),
                            borderSide: const BorderSide(
                              color: Color(0xff1C5440),
                              width: 2,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: .circular(4),
                            borderSide: const BorderSide(

                                color: Color(0xff1C5440),
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                const Text(
                  'Add Photos',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
                GestureDetector(
                  onTap: takePicture,
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xffAEBE7C),
                      borderRadius: .circular(4),
                      image: state.imageUrl != null
                          ? DecorationImage(
                        image: FileImage(File(state.imageUrl!)),
                        fit: BoxFit.cover,
                      )
                          : null,
                    ),
                    child: state.imageUrl == null
                        ? const Icon(
                      Icons.camera_alt,
                      color: Colors.black,
                      size: 31,
                    )
                        : null,
                  ),
                ),
              ],
            ),
            ],
          ),
          Column(
          crossAxisAlignment: .start,
          children: [
          const Text(
          'Location',
          style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 12,
          color: Colors.black,
          ),
          ),
          GestureDetector(
          onTap: () {},
          child: Container(
          padding: const .all(10),
          decoration: BoxDecoration(
          color: const Color(0xffAEBE7C),
          borderRadius: .circular(4),
          border: .all(
          color: const Color(0xff1C5440),
          width: 2,
          ),
          ),
          child: SvgPicture.asset(
          'assets/icons/location.svg',
          width: 144,
          height: 112,
          fit: BoxFit.cover,
          ),
          ),
          ),
          ],
          ),
          Row(
          mainAxisAlignment: .spaceBetween,
          children: [
          Column(
          children: [
          const Text(
          'Data and Time',
          style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 12,
          color: Colors.black,
          ),
          ),
          GestureDetector(
          onTap: () {},
          child: Container(
          width: 48,
          height: 48,

          decoration: BoxDecoration(
          color: const Color(0xffAEBE7C),
          borderRadius: .circular(4),
          ),
          child: const Icon(
          Icons.calendar_month_outlined,
          color: Colors.black,
          size: 31,
          ),
          ),
          ),
          ],
          ),
          GestureDetector(
          onTap: _cubit.addLocation,
          child: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
          color: const Color(0xffAEBE7C),
          borderRadius: .circular(4),
          ),
          alignment: .center,
          child: const Icon(
          Icons.check,
          size: 32,
          color: Colors.black,
          ),
          ),
          ),
          ],
          ),
          ],
          ),
          ),
          );
        },
      ),
    );
  }

  Future<void> takePicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: .gallery);

    if (pickedFile == null) return;

    final appDir = await getApplicationDocumentsDirectory();
    final fileName = path.basename(pickedFile.path);

    final savedImage = await File(
      pickedFile.path,
    ).copy('${appDir.path}/$fileName');

    _cubit.imageUrlChanged(savedImage.path);
  }
}
