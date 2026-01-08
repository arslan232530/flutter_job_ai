//import 'dart:io';

//import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:job_board/controllers/image/profile_image_state.dart';
//import 'package:uuid/uuid.dart';

class ProfileImageNotifier extends StateNotifier<ProfileImageState> {
  ProfileImageNotifier() : super(const ProfileImageState());

  final ImagePicker _picker = ImagePicker();

  //final _uuid = Uuid();

  // Dummy setter to test provider
  void setLocalPath(String path) {
    state = state.copyWith(localPath: path);
  }

  void setImageUrl(String url) {
    state = state.copyWith(imageUrl: url);
  }

  void setLoading(bool loading) {
    state = state.copyWith(isLoading: loading);
  }

  Future<void> pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      await cropImage(pickedFile);
    }
  }

  Future<void> cropImage(XFile file) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: file.path,
      maxWidth: 600,
      maxHeight: 800,
      compressQuality: 70,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          lockAspectRatio: true,
          aspectRatioPresets: [CropAspectRatioPreset.ratio5x4],
        ),
        IOSUiSettings(
          title: 'Crop Image',
          aspectRatioPresets: [CropAspectRatioPreset.ratio5x4],
        ),
      ],
    );

    if (croppedFile != null) {
      state = state.copyWith(localPath: croppedFile.path);
    }
  }
}

  // Future<String?> uploadImage() async {
  //   print('fnup caa');
  //   if (state.localPath == null) return null;
  //   state = state.copyWith(isLoading: true);
  //   final file = File(state.localPath!);
  //   final ref = FirebaseStorage.instance
  //       .ref()
  //       .child('profile_images')
  //       .child('${_uuid.v4()}.jpg');

  //   await ref.putFile(file);
  //   final downloadUrl = await ref.getDownloadURL();
  //   print("ref :,$ref");
  //   print("down : $downloadUrl");
  //   state = state.copyWith(imageUrl: downloadUrl, isLoading: false);

  //   return downloadUrl;
  // }
//}
