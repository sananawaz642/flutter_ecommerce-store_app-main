// ignore_for_file: avoid_print

import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_flutter/admin_app/dashboard/views/admin_dashboard.dart';
import 'package:e_commerce_flutter/core/collection_path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AdminAuthController extends GetxController {
  RxBool unreadNotification = false.obs;
  @override
  Future<void> onInit() async {
    super.onInit();
  }

  Future<bool> loginWithEmailAndPassword(
      {required String emailAddress, required String password,bool? isAdmin}) async {
        try {
          final data = await FirebaseFirestore.instance.collection(CollectionPaths.admins).where('email', isEqualTo: emailAddress).where('password', isEqualTo: password).get();
        if (data.docs.isNotEmpty) {
          Get.offAll(const AdminDashboard());
          return true;
        }else{
          BotToast.showText(text: 'Invalid Credentials');
          return false;
        }
        } catch (e) {
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