import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sims_popb/data/session_provider.dart';
import 'package:sims_popb/feature/home/provider/account_provider.dart';
import 'package:path/path.dart' as p;

import '../../../data/network/status.dart';
import '../../../utils/resources/assets.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();

  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    fetchProfile();
  }

  void fetchProfile() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AccountProvider>().getProfile();
    });
  }

  void toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void saveProfile(String firstName, String lastName) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      toggleEditing();
      context.read<AccountProvider>().updateProfile(firstName, lastName);
      fetchProfile();
    });
  }

  Future<XFile?> showImagePickerDialog(BuildContext context) async {
    final ImagePicker picker = ImagePicker();

    return showDialog<XFile?>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        title: const Text('Pilih Sumber Gambar'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Kamera'),
              onTap: () async {
                final XFile? image =
                    await picker.pickImage(source: ImageSource.camera);

                if (image != null) {
                  final compressed = await compressImage(imageFile: File(image.path));
                  uploadImage(compressed);
                  Navigator.of(context).pop();
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Galeri'),
              onTap: () async {
                final XFile? image =
                    await picker.pickImage(source: ImageSource.gallery);

                if (image != null) {
                  final compressed = await compressImage(imageFile: File(image.path));
                  uploadImage(compressed);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void uploadImage(XFile file) async {
    context.read<AccountProvider>().updateProfileImage(File(file.path));
  }

  Future<XFile> compressImage({
    required File imageFile,
    int quality=10,
    CompressFormat format=CompressFormat.jpeg,
  }) async {
    final String targetPath = p.join(Directory.systemTemp.path, 'temp.${format.name}');
    final XFile? compressedImage = await FlutterImageCompress.compressAndGetFile(
        imageFile.path,
        targetPath,
        quality: quality,
        format: format
    );

    if (compressedImage==null){
      throw ("Failed to compress the image");
    }

    return compressedImage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Consumer<AccountProvider>(builder: (context, value, _) {
            final imgSrc = value.profileResponse.data?.data?.profileImage ?? '';
            bool isProfileImgNotEmpty =
                imgSrc.isNotEmpty && !imgSrc.endsWith('/null');

            final profile = value.profileResponse.data?.data;
            bool isLoading = value.profileResponse.status == Status.loading;

            if (value.profileResponse.data != null && profile != null) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _emailController.text = profile.email;
                _firstNameController.text = profile.firstName;
                _lastnameController.text = profile.lastName;
              });
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Akun',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () async {
                    if (!isLoading) {
                      await showImagePickerDialog(context);
                    }
                  },
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      isLoading
                          ? Shimmer.fromColors(
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                              child: Container(
                                width: 96,
                                height: 96,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          : CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 48,
                              backgroundImage: isProfileImgNotEmpty
                                  ? NetworkImage(imgSrc)
                                  : AssetImage(Assets.instance.profilePhoto1)
                                      as ImageProvider,
                            ),
                      Positioned(
                        bottom: 1,
                        right: 1,
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 1,
                            ),
                          ),
                          child: const CircleAvatar(
                            radius: 14,
                            backgroundColor: Colors.white,
                            child: Icon(
                              Icons.edit,
                              size: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  isLoading
                      ? 'Loading..'
                      : '${profile?.firstName} ${profile?.lastName}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        readOnly: true,
                        controller: _emailController,
                        decoration: InputDecoration(
                          isDense: true,
                          prefixIcon: Icon(Icons.email_outlined),
                          hintText: '',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Nama Depan',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        readOnly: !_isEditing,
                        controller: _firstNameController,
                        decoration: InputDecoration(
                          isDense: true,
                          prefixIcon: Icon(Icons.person),
                          hintText: '',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Nama Belakang',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        readOnly: !_isEditing,
                        controller: _lastnameController,
                        decoration: InputDecoration(
                          isDense: true,
                          prefixIcon: Icon(Icons.person),
                          hintText: '',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                if (_isEditing) ...[
                  Container(
                    height: 48,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: ElevatedButton(
                      onPressed: () {
                        saveProfile(_firstNameController.text,
                            _lastnameController.text);
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: Text(
                        'Simpan',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: OutlinedButton(
                      onPressed: () {
                        toggleEditing();
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.red),
                        minimumSize: const Size.fromHeight(48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: const Text(
                        'Batalkan',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ] else ...[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: OutlinedButton(
                      onPressed: () {
                        toggleEditing();
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.red),
                        minimumSize: const Size.fromHeight(48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: const Text(
                        'Edit Profile',
                        style: TextStyle(
                            color: Colors.red, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    height: 48,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: ElevatedButton(
                      onPressed: () {
                        context.read<SessionProvider>().logout();
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      child: Text(
                        'Logout',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
                const SizedBox(height: 24),
              ],
            );
          }),
        ),
      ),
    );
  }
}
