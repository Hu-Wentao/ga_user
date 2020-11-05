// Created by Hu Wentao.
// Email : hu.wentao@outlook.com
// Date  : 2020/8/14
// Time  : 22:33
import 'package:flutter/material.dart';
import 'package:ga_user/domain/entities/user.dart';
import 'package:ga_user/infrastructure/ui/editable_info_view.dart';
import 'package:ga_user/interface/user_date_vm.dart';
import 'package:ga_user/profile/user_package.dart';
import 'package:get_state/get_state.dart';

///
/// 是 [UserDataVm]的根页面, 每次进入该Page,都会重载VM
class EditUserDataPage extends View<UserDateVm> {
  EditUserDataPage() : super(isRoot: true);

  @override
  registerVmInstance() => specProfileRegisterFunc[UserDateVm].call();

  @override
  Widget build(BuildContext c, UserDateVm vm) => Scaffold(
        appBar: AppBar(title: Text('编辑资料')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 48, 16, 36),
                child: EditableAvatar(
                  hasUser: vm.m,
                  updateAvatar: vm.updateAvatar,
                  nickname: vm.getNickName(),
                  avatarBytes: vm.getAvatar(),
                ),
              ),
              StringEditableView(
                leading: '昵称',
                showingValue: vm.getNickName(),
                dialogTitle: '修改昵称',
                updateValue: vm.updateNickName,
              ),
              EnumEditableView<Sex>(
                leading: '性别',
                dialogTitle: '修改性别',
                eitherValue: vm.eitherSex(),
                updateValue: vm.updateSex,
                enumTextMap: vm.sexToString,
              ),
              StringEditableView(
                leading: '邮箱',
                showingValue: vm.getEmail(),
                dialogTitle: '修改邮箱',
                updateValue: vm.updateEmail,
              ),
              StringEditableView(
                leading: '手机',
                showingValue: vm.getPhone(),
                dialogTitle: '修改手机号',
                updateValue: vm.updatePhone,
              ),
            ],
          ),
        ),
      );
}
