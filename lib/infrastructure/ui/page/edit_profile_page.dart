/////
///// [Author] Alex (https://github.com/AlexVincent525)
///// [Date] 2020/5/22 15:38
/////
//import 'dart:ui' as ui;
//
//import 'package:ga_user/domain/entities/user.dart';
//import 'package:ga_user/interface/user_date_vm.dart';
//import 'package:get_arch_quick_start/qs_infrastructure.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:get_state/get_state.dart';
//
//final currentUser = User.fromResult(
//    id: null,
//    nickname: null,
//    email: null,
//    regTime: null,
//    phone: null,
//    avatar: null,
//    sex: null,
//    token: null);
//
//class EditProfilePage extends View<UserDateVm> {
//  final TextEditingController signatureController = TextEditingController(
//    text: currentUser.nickname ?? '快来填写你的签名吧~',
//  );
//
//  final Widget saveButton = IconButton(
//    icon: Icon(Icons.save),
//    onPressed: () {},
//  );
//
//  @override
//  Widget build(BuildContext context, UserDateVm vm) => Scaffold(
//        body: FixedAppBarWrapper(
//          appBar: FixedAppBar(
//            title: Text('${currentUser.nickname}的个人资料'),
//            actions: <Widget>[saveButton],
//          ),
//          body: ListView(
//            padding: EdgeInsets.zero,
//            children: <Widget>[
//              SizedBox(
//                height: 250.w,
//                child: ClipRect(
//                  child: Stack(
//                    children: <Widget>[
//                      /// ... 头像背景
//                      SizedBox.expand(
//                        child: Image(
//                          image: MemoryImage(r),
//                          fit: BoxFit.fitWidth,
//                        ),
//                      ),
//                      BackdropFilter(
//                        filter: ui.ImageFilter.blur(sigmaX: 20, sigmaY: 20),
//                        child: Container(
//                          color: Color.fromARGB(120, 50, 50, 50),
//                        ),
//                      ),
//                      /// ... 头像选择
//                      Center(
//                        child: ClipOval(
//                          child: SizedBox.fromSize(
//                            size: Size.square(116.0.w),
//                            child: GestureDetector(
//                              onTap: () {
//                                // todo 跳转到...
////                navigatorState.pushNamed(Routes.openjmuImageCrop);
//                              },
//                              child: Stack(
//                                children: <Widget>[
//                                  UserAPI.getAvatar(size: 116.0),
//                                  Positioned.fill(
//                                    child: DecoratedBox(
//                                      decoration: BoxDecoration(
//                                        border: Border.all(
//                                          color: Colors.white54,
//                                          width: 5.0.w,
//                                        ),
//                                        color: Colors.black45,
//                                        shape: BoxShape.circle,
//                                      ),
//                                      child: Icon(
//                                        Icons.photo_camera,
//                                        size: 48.0.w,
//                                        color: Colors.white60,
//                                      ),
//                                    ),
//                                  ),
//                                ],
//                              ),
//                            ),
//                          ),
//                        ),
//                      )
//                    ],
//                  ),
//                ),
//              ),
//              sectionWidget(
//                context: context,
//                title: '个性签名',
//                child: TextField(
//                  controller: signatureController,
//                  decoration: InputDecoration(
//                    focusedBorder: UnderlineInputBorder(
//                      borderSide:
//                          BorderSide(color: context.themeData.primaryColor),
//                    ),
//                    contentPadding: EdgeInsets.only(bottom: 6.0.h),
//                    isDense: true,
//                  ),
//                  scrollPadding: EdgeInsets.zero,
//                ),
//              ),
//              sectionWidget(
//                context: context,
//                title: '性别',
//                child: Text(
//                  vm.sexToString[Sex.male], // todo ...
//                ),
//              ),
//            ],
//          ),
//        ),
//      );
//
//  /// Section widget.
//  /// 区域部件
//  Widget sectionWidget({
//    @required String title,
//    @required Widget child,
//    @required BuildContext context,
//  }) =>
//      Container(
//        margin: EdgeInsets.only(
//          top: 30.0.h,
//          bottom: 6.0.h,
//        ),
//        padding: EdgeInsets.symmetric(
//          horizontal: 30.0.w,
//        ),
//        child: Column(
//          mainAxisSize: MainAxisSize.min,
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: <Widget>[
//            Text(
//              title,
//              style: TextStyle(fontSize: 18.0.sp),
//            ),
//            SizedBox(height: 10.0.h),
//            DefaultTextStyle(
//              style: context.themeData.textTheme.bodyText2.copyWith(
//                fontSize: 22.sp,
//              ),
//              child: child,
//            ),
//          ],
//        ),
//      );
//}
