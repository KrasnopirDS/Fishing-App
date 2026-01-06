import 'dart:io';

import 'package:fishing_app/di/get_it.dart';
import 'package:fishing_app/features/create_fish/presentation/cubit/create_fish_cubit.dart';
import 'package:fishing_app/features/create_fish/presentation/cubit/create_fish_state.dart';
import 'package:fishing_app/router/screen_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class CreateFishScreen extends StatefulWidget {
  const CreateFishScreen({required this.locationId, super.key});

  final int locationId;

  @override
  State<CreateFishScreen> createState() => _CreateFishScreenState();
}

class _CreateFishScreenState extends State<CreateFishScreen> {
  late final TextEditingController _fishNameController;
  late final TextEditingController _fishLengthController;
  late final TextEditingController _fishWeightController;
  late final TextEditingController _baitController;
  late final TextEditingController _noteController;

  final _cubit = getIt<CreateFishCubit>();

  @override
  void initState() {
    super.initState();
    _fishNameController = TextEditingController();
    _fishLengthController = TextEditingController();
    _fishWeightController = TextEditingController();
    _baitController = TextEditingController();
    _noteController = TextEditingController();
    _cubit.locationIdChanged(widget.locationId);
  }

  @override
  void dispose() {
    _fishNameController.dispose();
    _fishLengthController.dispose();
    _fishWeightController.dispose();
    _baitController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: BlocConsumer<CreateFishCubit, CreateFishState>(
        listener: (context, state) {
          if (state.status == .success) {
            context.goNamed(
              ScreenNames.sightings,
              pathParameters: {'locationId': widget.locationId.toString()},
            );
          }
          if (state.status == .error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error ?? 'Error saving fish')),
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
                onTap: () => context.goNamed(
                  ScreenNames.sightings,
                  pathParameters: {'locationId': widget.locationId.toString()},
                ),
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
                'New Catch',
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
                'Catch name',
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
                  controller: _fishNameController,
                  onChanged: _cubit.nameChanged,
                  decoration: InputDecoration(
                      hintText: 'Enter catch name',
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
          'Catch length in cm',
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
          controller: _fishLengthController,
          onChanged: _cubit.lengthChanged,
          decoration: InputDecoration(
          hintText: 'Enter catch length',
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
          Column(
          crossAxisAlignment: .start,
          children: [
          const Text(
          'Catch weight in kg',
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
          controller: _fishWeightController,
          onChanged: _cubit.weightChanged,
          decoration: InputDecoration(
          hintText: 'Enter catch weight',
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
          Column(
          crossAxisAlignment: .start,
          children: [
          const Text(
          'Bait',
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
          controller: _baitController,
          onChanged: _cubit.baitChanged,
          decoration: InputDecoration(
          hintText: 'Enter bait',
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
          Column(
          crossAxisAlignment: .start,
          children: [
          const Text(

          'Add note',
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
          controller: _noteController,
          onChanged: _cubit.notesChanged,
          decoration: InputDecoration(
          hintText: 'Enter add note',
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
          onTap: _cubit.addFish,
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