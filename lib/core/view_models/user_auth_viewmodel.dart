import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:footsapp/core/base/base_viewmodels/base_viewmodel.dart';
import 'package:footsapp/core/constants/pref_constants.dart';
import 'package:footsapp/core/di/injection_container.dart';
import 'package:footsapp/core/enums/viewstate.dart';
import 'package:footsapp/core/utils/shared_pref_util.dart';
import 'package:footsapp/data/models/auth_response.dart';
import 'package:footsapp/data/models/user_data_response.dart';
import 'package:footsapp/data/repo_services/login_registration/login_reg_repo.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class UserAuthViewModel extends BaseViewModel {
  final _loginRegRepo = sl<LoginRegRepo>();
  final _sharePrefUtil = sl<SharedPrefUtil>();
  Profile userProfile = Profile.initial();
  var _authResponse;

  //google sign in instances
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
    ],
  );
  String _googleAccessToken;

  // facebook login instances
  final _facebookLogin = FacebookLogin();
  String _facebookAccessToken;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void completeGoogleSignInProcess() async {
    setState(ViewState.Loading);
    final user = await _handleGoogleSignIn();
    if (user != null) {
      _authResponse =
          await _loginRegRepo.postGoogleSocialLogin(_googleAccessToken);
      if (_authResponse.success == true) {
        setState(ViewState.Loaded);
      } else {
        setState(ViewState.Error);
        errorMessage = _authResponse.message;
      }
    } else {
      errorMessage = 'Something went wrong!';
      setState(ViewState.Error);
    }
  }

  Future<AuthResponse> completeFacebookLoginProcess() async {
    final facebookProfile = await _handleFacebookLogin();
    if (facebookProfile != null) {
      setState(ViewState.Loading);
      _authResponse =
          await _loginRegRepo.postFacebookSocialLogin(_facebookAccessToken);
      if (_authResponse.success == true) {
        userProfile.firstName = facebookProfile.firstName;
        userProfile.lastName = facebookProfile.lastName;
        final email = await _facebookLogin.getUserEmail();
        if (email != null) {
          userProfile.email = email;
          print('Hello, $email! You ID: ${facebookProfile.userId}');
        }
        await _sharePrefUtil.saveString(ACCESS_TOKEN, _authResponse.token);
        await _sharePrefUtil.saveString(FIRST_NAME, userProfile.firstName);
        await _sharePrefUtil.saveString(LAST_NAME, userProfile.lastName);
        await _sharePrefUtil.saveString(EMAIL, email ?? '');

        _sharePrefUtil.saveBool(IS_LOGGED_IN, true);
        _sharePrefUtil.saveBool(INITIAL_PROFILE_UPDATED, false);
        setState(ViewState.Loaded);
        return _authResponse;
      } else {
        setState(ViewState.Error);
        errorMessage = _authResponse.message;
        return null;
      }
    } else {
      errorMessage = 'Something went wrong!';
      setState(ViewState.Error);
      return null;
    }
  }

  Future<User> _handleGoogleSignIn() async {
    final GoogleSignInAccount googleSignInAccount =
        await _googleSignIn.signIn();
    if (googleSignInAccount == null) {
      return null;
    }
    try {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      _googleAccessToken = googleSignInAuthentication.accessToken;

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: _googleAccessToken,
      );

      final authResult = await _firebaseAuth.signInWithCredential(credential);
      final User user = authResult.user; //firebase user
      if (user != null) {
        print('$user');
      }

      return user;
    } catch (e) {
      print(e);
      errorMessage = e;
      return null;
    }
  }

  Future<FacebookUserProfile> _handleFacebookLogin() async {
    // Log in
    final res = await _facebookLogin.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);

    if (res.status == FacebookLoginStatus.Success) {
      final FacebookAccessToken accessToken = res.accessToken;
      _facebookAccessToken = res.accessToken.token;
      print('Access token: ${accessToken.token}');

      final profile = await _facebookLogin.getUserProfile();
      print('Hello, ${profile.firstName}! You ID: ${profile.userId}');
      print('Hello, ${profile.lastName}! You ID: ${profile.userId}');

      // Get user profile image url
      final imageUrl = await _facebookLogin.getProfileImageUrl(width: 100);

      User user;

      try {
        final AuthCredential credential =
            FacebookAuthProvider.credential(accessToken.token);

        final authResult = await _firebaseAuth.signInWithCredential(credential);
        user = authResult.user; //firebase user
        if (user != null) {
          print('$user');
        }
      } catch (e) {
        print(e);
        errorMessage = e;
      }
      return profile;
    } else {
      return null;
    }

    // Check result status
    // switch (res.status) {
    //   case FacebookLoginStatus.Success:
    //     break;
    //   case FacebookLoginStatus.Cancel:
    //     // User cancel log in
    //     print('User Canceled');
    //     return null;
    //     break;
    //   case FacebookLoginStatus.Error:
    //     // Log in failed
    //     print('Error while log in: ${res.error}');
    //     return null;
    //     break;
    // }
  }

  void googleSignOut() async {
    await _googleSignIn.signOut();
  }

  //non-social registration
  Future<AuthResponse> completeNonSocialRegistrationProcess(
      email, password) async {
    setState(ViewState.Loading);
    final _authResponse =
        await _loginRegRepo.postNonSocialSignUp(email, password);

    if (_authResponse.success == true) {
      setState(ViewState.Loaded);
      _sharePrefUtil.saveString(ACCESS_TOKEN, _authResponse.token);
      _sharePrefUtil.saveBool(IS_LOGGED_IN, true);
      _sharePrefUtil.saveBool(INITIAL_PROFILE_UPDATED, false);
    } else {
      setState(ViewState.Error);
      errorMessage = 'Email already exists!';
    }

    return _authResponse;
  }

  //non-social login
  Future<AuthResponse> completeNonSocialLoginProcess(email, password) async {
    setState(ViewState.Loading);
    final _authResponse =
        await _loginRegRepo.postNonSocialLogin(email, password);

    if (_authResponse.success == true) {
      setState(ViewState.Loaded);
      _sharePrefUtil.saveString(ACCESS_TOKEN, _authResponse.token);
      _sharePrefUtil.saveBool(IS_LOGGED_IN, true);
    } else {
      setState(ViewState.Error);
      errorMessage = 'Please give proper email and password!';
    }

    return _authResponse;
  }

  bool userInitialProfileUpdated() {
    bool initialProfileUpdated =
        _sharePrefUtil.readBool(INITIAL_PROFILE_UPDATED) ?? false;

    return initialProfileUpdated;
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

  String validatePassword(String val) {
    if (val.trim().isEmpty) {
      return "Please enter password!";
    }
    if (val.length < 5) {
      return "Password must have at least 5 characters.";
    }
    return null;
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

  String validatePhone(String val) {
    if (val.isEmpty) {
      return "Enter your phone number";
    }
    // Check for phone numbers starting with '0'
    // Discard that '0'
    if (val.length > 0 && val[0] == "0") {
      val = val.substring(1, val.length);
    }
//    if (_phoneRegExp.hasMatch(val)) {
//      return null;
//    }
//    return "Invalid Phone Number";
    return null;
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
}
