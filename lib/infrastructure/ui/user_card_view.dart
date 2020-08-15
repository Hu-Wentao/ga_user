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
          builder: (c, s) => s.data.safeFold(
                (l) => FLAvatar(
                  color: (l is NotLoginFailure) ? Colors.grey : Colors.red,
                  width: 100,
                  height: 100,
                  text: (l is NotLoginFailure) ? '未登录' : 'Error',
                  textStyle: TextStyle(fontSize: 27, color: Colors.white),
                  onTap: () => l.errDialog(c),
                ),
                (r) {
                  successNotifier.value = true;
                  return FLAvatar(
                    // 成功获取头像数据
                    color: r == null ? Colors.blue : null,
                    image: r == null ? null : Image(image: MemoryImage(r)),
                    text: r == null
                        ? '${nickname.padLeft(2).substring(nickname.length - 2, nickname.length)}'
                        : null,
                    width: 100,
                    height: 100,
                    textStyle: TextStyle(fontSize: 17, color: Colors.white),
                  );
                },
                onNull: () => CircularProgressIndicator(),
              ));
}
