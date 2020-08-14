// Created by Hu Wentao.
// Email : hu.wentao@outlook.com
// Date  : 2020/7/4
// Time  : 19:21

import 'dart:typed_data';

import 'package:flui/flui.dart';
import 'package:flutter/material.dart';
import 'package:ga_user/infrastructure/ui/page/edit_user_data_page.dart';
import 'package:ga_user/interface/user_date_vm.dart';
import 'package:get_arch_quick_start/quick_start.dart';
import 'package:get_state/get_state.dart';

///
/// 用户卡片
class UserCardView extends View<UserDateVm> {
  @override
  Widget build(BuildContext c, UserDateVm vm) => ListTile(
        leading: FutureAvatar(
            avatarBytes: vm.getAvatar(), nickname: vm.getNickName()),
        title: Row(
          children: <Widget>[
            Text('${vm.getNickName()}'),
            IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => Navigator.of(c).push(
                    MaterialPageRoute(builder: (c) => EditUserDataPage())))
          ],
        ),
      );
}

///
/// 头像展示
class FutureAvatar extends StatelessWidget {
  final Future<Either<Failure, Uint8List>> avatarBytes;
  final String nickname;
  final ValueNotifier<bool> successNotifier;
  const FutureAvatar(
      {Key key,
      @required this.avatarBytes,
      @required this.nickname,
      this.successNotifier})
      : super(key: key);

  @override
  Widget build(BuildContext context) =>
      FutureBuilder<Either<Failure, Uint8List>>(
          initialData: null,
          future: avatarBytes,
          builder: (c, s) {
            final data = s.data;
            // 初始数据 / 数据为空
            if (data == null) return CircularProgressIndicator();
            return data.fold(
              (l) {
                if (l is NotLoginFailure)
                  return FLAvatar(
                    color: Colors.grey,
                    width: 100,
                    height: 100,
                    text: '未登陆',
                    textStyle: TextStyle(fontSize: 27, color: Colors.white),
                    onTap: () {
                      // TODO 点击头像进入登录页
                    },
                  );

                return FLAvatar(
                  color: Colors.redAccent,
                  width: 100,
                  height: 100,
                  text: '未知错误',
                  textStyle: TextStyle(fontSize: 27, color: Colors.white),
                  onTap: () {
                    // todo 点击头像展示错误
                  },
                );
              },
              (r) {
                successNotifier.value = true;
                final bytes = data.getOrElse(() => null);
                if (bytes == null) {
                  return FLAvatar(
                    color: Colors.blue,
                    width: 100,
                    height: 100,
                    text:
                        '${nickname.padLeft(2).substring(nickname.length - 2, nickname.length)}',
                    textStyle: TextStyle(fontSize: 27, color: Colors.white),
                  );
                }
                return FLAvatar(
                  // 成功获取头像数据
                  image: Image(image: MemoryImage(bytes)),
                  width: 100,
                  height: 100,
                  textStyle: TextStyle(fontSize: 17, color: Colors.white),
                );
              },
            );
          });
}
