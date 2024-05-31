import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  RxBool unreadNotification = false.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
  }

  Future<bool> loginAsAdmin(
      {required String emailAddress, required String password}) async {
    // FirebaseAuth.instance.signOut();
    try {
      //ToDo: Seperate Login For admin Login
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      // FirebaseAuth.instance.signInWithCredential(credential.credential!);
      print(credential);
      return true;
    } on FirebaseAuthException catch (e) {
      BotToast.closeAllLoading();
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      BotToast.showText(text: e.code);
      return false;
    } catch (e) {
      BotToast.closeAllLoading();
      print(e);
      return false;
    }
  }


  Future<bool> loginWithEmailAndPassword(
      {required String emailAddress, required String password}) async {
    // FirebaseAuth.instance.signOut();
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      // FirebaseAuth.instance.signInWithCredential(credential.credential!);
      print(credential);
      return true;
    } on FirebaseAuthException catch (e) {
      BotToast.closeAllLoading();
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      BotToast.showText(text: e.code);
      return false;
    } catch (e) {
      BotToast.closeAllLoading();
      print(e);
      return false;
    }
  }

  Future<bool> registerUser(
      {required String email, required String password}) async {
    try {
      // UserCredential data =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      // registerUserToBE(
      //     user: user.copyWith(
      //         firebaseUID: data.user?.uid, photo: data.user?.photoURL));
      update();
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      BotToast.showText(text: e.code);
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  sendForgetPasswordEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      BotToast.showText(text: e.code);
      return false;
    } catch (e) {
      BotToast.showText(text: e.toString());
      return false;
    }
  }

  void logout() {
    FirebaseAuth.instance.signOut();
  }

  // Future<bool> updateUserProfile({required UserModel user}) async {
  //   try {
  //     var headers = await AuthRepository.getHeader();
  //     var res = await Dio().put(ApiEndPoints.PROFILE,
  //         data: user.toMap(), options: Options(headers: headers));
  //     print(res.statusCode);
  //     if (res.statusCode == 200) {
  //       dbUser = UserModel.fromMap(res.data['player']);
  //       update();
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   } on DioException catch (e) {
  //     BotToast.showText(text: e.toString());
  //     return false;
  //   } catch (e) {
  //     print(e);
  //     return false;
  //   }
  // }

  // Future getUserProfile(String fID) async {
  //   try {
  //     var headers = await AuthRepository.getHeader();
  //     var res = await Dio().get(ApiEndPoints.getPlayer(fID),
  //         options: Options(
  //             headers: headers,
  //             sendTimeout: const Duration(seconds: 10),
  //             receiveTimeout: const Duration(seconds: 10))).timeout(const Duration(seconds:25));
  //     print(res.data);
  //     if (res.statusCode == 200) {
  //       favSchedules = [];
  //       //Assign data to dbUser;
  //       dbUser = UserModel.fromMap(res.data['user']);
  //       // Save activeScheduleOfFavQuizzes
  //       List list = res.data['activeSchedulesOfFavoriteQuizes'];
  //       for (var element in list) {
  //         favSchedules.add(ScheduleModel.fromMap(element));
  //       }
  //       return true;
  //     } else {
  //       BotToast.closeAllLoading();
  //       return false;
  //     }
  //   }on TimeoutException catch (e) {
  //     print(e.toString());
  //     BotToast.showText(
  //         text: 'Timed Out! Please try again');
  //     BotToast.closeAllLoading();
  //     return false;
  //   }  on DioException catch (e) {
  //     BotToast.showText(
  //         text: e.response?.data['error'] ?? 'Unexpected Error getting user');
  //     BotToast.closeAllLoading();
  //     return false;
  //   } catch (e) {
  //     print(e);
  //     BotToast.closeAllLoading();
  //     return false;
  //   }
  // }

}