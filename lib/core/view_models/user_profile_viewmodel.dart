import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:footsapp/core/base/base_viewmodels/base_viewmodel.dart';
import 'package:footsapp/core/constants/pref_constants.dart';
import 'package:footsapp/core/constants/value_constants.dart';
import 'package:footsapp/core/di/injection_container.dart';
import 'package:footsapp/core/enums/viewstate.dart';
import 'package:footsapp/core/utils/shared_pref_util.dart';
import 'package:footsapp/data/models/user_data_response.dart';
import 'package:footsapp/data/repo_services/profile_management/profile_manage_repo.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rxdart/rxdart.dart';

class UserProfileViewModel extends BaseViewModel {
  final _profileManageRepo = sl<ProfileManageRepo>();
  final _sharePrefUtil = sl<SharedPrefUtil>();

  Profile userProfile = Profile.initial();

  int _currentSelectedFieldPosition = 0;
  int fieldPositionSegment = 0;

  int get currentSelectedFieldPosition => _currentSelectedFieldPosition;

  void setCurrentSelectedFieldPosition(int val) {
    _currentSelectedFieldPosition = val;
    if (val == 1) {
      fieldPositionSegment = POSITION_SEGMENT_GK;
      userProfile.preferredPosition = 'Goalkeeper';
    } else if (val >= 2 && val <= 5) {
      fieldPositionSegment = POSITION_SEGMENT_DEF;
      userProfile.preferredPosition = 'Defender';
    } else if (val >= 6 && val <= 9) {
      fieldPositionSegment = POSITION_SEGMENT_MID;
      userProfile.preferredPosition = 'Midfielder';
    } else if (val >= 10 && val <= 12) {
      fieldPositionSegment = POSITION_SEGMENT_ATT;
      userProfile.preferredPosition = 'Forward';
    }
    notifyListeners();
  }

  String validateFirstName(String val) {
    if (val.isEmpty) {
      return "Enter your first name";
    }
    if (val.trim().isEmpty) {
      return "Enter your first name";
    }
    if (val.length < 2) {
      return "First Name must have at least 2 characters.";
    }
    return null;
  }

  String validateLastName(String val) {
    if (val.isEmpty) {
      return "Enter your last name";
    }
    if (val.trim().isEmpty) {
      return "Enter your last name";
    }
    if (val.length < 1) {
      return "Last Name must have at least 1 character.";
    }
    return null;
  }

  String validateEmail(String val) {
    if (val.isEmpty) {
      return "Please enter email!";
    }

    final _emailRegExp = RegExp(
        r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?");

    if (val.isNotEmpty) {
      if (!_emailRegExp.hasMatch(val)) {
        return "Invalid Email Address!";
      }
    }

    return null;
  }

  final _isShowLoading = BehaviorSubject<bool>();

  Stream<bool> get isShowLoading => _isShowLoading.stream;

  //profile update
  Future<UserDataResponse> completeProfileUpdate() async {
    //setState(ViewState.Loading);
    final _userDataResponse = await _profileManageRepo
        .postUserProfileUpdate(userProfile.toJsonProfileUpdate());

    if (_userDataResponse.success == true) {
      //setState(ViewState.Loaded);
      _sharePrefUtil.saveBool(IS_LOGGED_IN, true);
      _sharePrefUtil.saveBool(INITIAL_PROFILE_UPDATED, true);
      userProfile = _userDataResponse.profile;
    } else {
      //setState(ViewState.Error);
      errorMessage = 'Please try again!';
    }

    return _userDataResponse;
  }

  //get user profile
  Future<UserDataResponse> getUserProfileData() async {
    final _userDataResponse = await _profileManageRepo.getUserProfileInfo();

    if (_userDataResponse.success == true) {
      userProfile = _userDataResponse.profile;
    } else {
      setState(ViewState.Error);
      errorMessage = 'Please try again!';
    }

    return _userDataResponse;
  }

  Future<void> getImage() async {
    var image = await ImagePicker().getImage(source: ImageSource.gallery);
    if (image != null) {
      var croppedImage = await ImageCropper.cropImage(
        sourcePath: image.path,
        cropStyle: CropStyle.circle,
        compressQuality: 75,
      );
      if (croppedImage != null) {
        var compressedImage =
            await FlutterNativeImage.compressImage(croppedImage.path);
        // setState(() {
        //   _image = compressedImage;
        // });
      }
    }
  }

  @override
  void dispose() {
    _isShowLoading?.close();
    super.dispose();
  }
}
