// Created by Hu Wentao.
// Email : hu.wentao@outlook.com
// Date  : 2020/7/4
// Time  : 19:21

import 'dart:typed_data';

import 'package:flui/flui.dart';
import 'package:flutter/material.dart';
import 'package:ga_user/domain/entities/user.dart';
import 'package:ga_user/interface/user_date_vm.dart';
import 'package:get_arch_quick_start/quick_start.dart';
import 'package:get_state/get_state.dart';
import 'package:image_picker/image_picker.dart';

class UserCardView extends View<UserDateVm> {
  @override
  Widget build(BuildContext c, UserDateVm vm) {
    if (vm.vmIsCreating) return CircularProgressIndicator();
    return ListTile(
      leading: Image.network(vm.m.avatar),
      title: Row(
        children: <Widget>[
          Text('${vm.m.nickname}'),
          IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => Navigator.of(c)
                  .push(MaterialPageRoute(builder: (c) => EditUserDataPage())))
        ],
      ),
    );
  }
}

class EditUserDataPage extends View<UserDateVm> {
  @override
  Future<void> onInitState(UserDateVm vm) async {
    return vm.vmUpdate((await vm.getUser(null)).getOrElse(null));
  }
  @override
  Widget build(BuildContext c, UserDateVm vm) => Scaffold(
        appBar: AppBar(title: Text('编辑资料')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: (vm.vmIsCreating)
                ? [CircularProgressIndicator()]
                : <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 48, 16, 36),
                      child: EditableAvatar(
                        updateAvatar: vm.updateAvatar,
                        nickname: vm.m.nickname,
                        avatarBytes: vm.getAvatar,
                      ),
                    ),
                    StringEditableView(
                      leading: '昵称',
                      showingValue: vm.m.nickname,
                      dialogTitle: '修改昵称',
                      updateValue: vm.updateNickName,
                    ),
                    EditableSex(
                      showingSex: vm.m.sex,
                      updateSex: vm.updateSex,
                    ),
                    StringEditableView(
                      leading: '邮箱',
                      showingValue: vm.m.email,
                      dialogTitle: '修改邮箱',
                      updateValue: vm.updateEmail,
                    ),
                    StringEditableView(
                      leading: '手机',
                      showingValue: vm.m.phone,
                      dialogTitle: '修改手机号',
                      updateValue: vm.updatePhone,
                    ),
                  ],
          ),
        ),
      );
}

///
/// 可编辑的性别
class EditableSex extends StatefulWidget {
  final Sex showingSex;
  final Function(Sex nSex) updateSex;

  const EditableSex({
    Key key,
    @required this.showingSex,
    @required this.updateSex,
  }) : super(key: key);

  @override
  _EditableSexState createState() => _EditableSexState();
}

class _EditableSexState extends State<EditableSex> {
  ValueNotifier<Sex> sexNotifier;
  @override
  void initState() {
    sexNotifier = ValueNotifier<Sex>(widget.showingSex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => ListTile(
        leading: Text('性别', style: Theme.of(context).textTheme.subtitle1),
        title: Text(_showSex(widget.showingSex)),
        trailing: IconButton(
            icon: Icon(Icons.chevron_right),
            onPressed: () => showDialog<bool>(
                context: context,
                builder: (c) => AlertDialog(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      title: Text('更改性别'),
                      content: _RadioTileList(sexNotifier: sexNotifier),
                      contentPadding:
                          const EdgeInsets.only(left: 20, right: 20, top: 18),
                      actions: <Widget>[
                        FlatButton(
                          highlightColor: const Color(0x55FF8A80),
                          splashColor: const Color(0x99FF8A80),
                          onPressed: () => _onCancelEdit(c),
                          child: const Text('取消',
                              style: TextStyle(color: Colors.redAccent)),
                        ),
                        FlatButton(
                          onPressed: () async {
                            if (sexNotifier.value != widget.showingSex) {
                              await widget.updateSex(sexNotifier.value);
                              _onConfirmEdit(c);
                            } else
                              _onCancelEdit(c);
                          },
                          child: const Text('保存'),
                        ),
                      ],
                    )).then((dialogReturn) => Scaffold.of(context).showSnackBar(
                  SnackBar(
                      content: Text(dialogReturn ? '正在保存...' : '取消编辑'),
                      duration: const Duration(seconds: 2)),
                ))),
      );

  _onCancelEdit(BuildContext _) => Navigator.pop(_, false);

  _onConfirmEdit(BuildContext _) => Navigator.pop(_, true);
}

class _RadioTileList extends StatefulWidget {
  final ValueNotifier<Sex> sexNotifier;

  const _RadioTileList({Key key, this.sexNotifier}) : super(key: key);

  @override
  __RadioTileListState createState() => __RadioTileListState();
}

class __RadioTileListState extends State<_RadioTileList> {
  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
            Sex.values.length,
            (i) => RadioListTile<Sex>(
                  title: Text(_showSex(Sex.values[i])),
                  value: Sex.values[i],
                  groupValue: widget.sexNotifier.value,
                  onChanged: _refresh,
                )),
      );

  void _refresh(Sex value) => setState(() => widget.sexNotifier.value = value);
}

String _showSex(Sex s) {
  switch (s) {
    case Sex.male:
      return '男';
    case Sex.female:
      return '女';
    default:
      return '未知';
  }
}

///
/// 可编辑的String类型的值
class StringEditableView extends StatefulWidget {
  final String leading;
  final String dialogTitle;
  final String dialogCancelTitle;
  final String dialogConfirmTitle;
  final String editCancelMsg;
  final String editSavingMsg;

  // 正在展示的Value
  final String showingValue;
  final Function(String nValue) updateValue;

  const StringEditableView({
    Key key,
    @required this.updateValue,
    @required this.dialogTitle,
    @required this.showingValue,
    @required this.leading,
    this.dialogCancelTitle: '取消',
    this.dialogConfirmTitle: '保存',
    this.editCancelMsg: '取消编辑',
    this.editSavingMsg: '正在保存...',
  }) : super(key: key);

  @override
  _StringEditableViewState createState() => _StringEditableViewState();
}

class _StringEditableViewState extends State<StringEditableView> {
  TextEditingController ctrl;
  @override
  void initState() {
    super.initState();
    ctrl = TextEditingController(text: widget.showingValue);
  }

  @override
  Widget build(BuildContext context) => ListTile(
      leading: Text(
        widget.leading,
        style: Theme.of(context).textTheme.subtitle1,
      ),
      title: Text('${widget.showingValue}'),
      trailing: IconButton(
          icon: Icon(Icons.chevron_right),
          onPressed: () => showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        title: Text(widget.dialogTitle),
                        content: TextField(
                          controller: ctrl,
                          keyboardType: TextInputType.text,
                        ),
                        contentPadding:
                            const EdgeInsets.only(left: 20, right: 20, top: 18),
                        actions: <Widget>[
                          FlatButton(
                            highlightColor: const Color(0x55FF8A80),
                            splashColor: const Color(0x99FF8A80),
                            onPressed: () => _onCancelEdit(ctx),
                            child: Text(widget.dialogCancelTitle,
                                style: TextStyle(color: Colors.redAccent)),
                          ),
                          FlatButton(
                            onPressed: () async {
                              if (ctrl.text != null) {
                                widget.updateValue(ctrl.text);
                                _onConfirmEdit(ctx);
                              } else
                                _onCancelEdit(ctx);
                            },
                            child: Text(widget.dialogConfirmTitle),
                          ),
                        ],
                      )).then(
                (dialogReturn) => Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(
                  (dialogReturn ?? false)
                      ? widget.editSavingMsg
                      : widget.editCancelMsg,
                ))),
              )));

  _onCancelEdit(BuildContext ctx) => Navigator.of(context).pop(false);

  _onConfirmEdit(BuildContext ctx) => Navigator.of(context).pop(true);
}

///
/// 可编辑的头像
class EditableAvatar extends StatelessWidget {
  final Future<Either<Failure, Uint8List>> avatarBytes;
  final String nickname;
  final Future<void> Function(String filePath) updateAvatar;

  const EditableAvatar({
    Key key,
    @required this.avatarBytes,
    @required this.nickname,
    @required this.updateAvatar,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) => Center(
        child: Stack(
            alignment: Alignment.center,
            overflow: Overflow.visible,
            fit: StackFit.loose,
            children: [
              FutureBuilder<Either<Failure, Uint8List>>(
                  initialData: null,
                  future: avatarBytes,
                  builder: (c, s) {
                    final data = s.data;
                    // 初始数据 / 数据为空
                    if (data == null) return CircularProgressIndicator();
                    // 成功获取头像数据
                    if (data.isRight())
                      return FLAvatar(
                        image: Image(
                            image: MemoryImage(data.getOrElse(() => null))),
                        width: 100,
                        height: 100,
                        textStyle: TextStyle(fontSize: 17, color: Colors.white),
                      );
                    // 其他情况
                    return FLAvatar(
                      color: Colors.blue,
                      width: 100,
                      height: 100,
                      text:
                          '${nickname.padLeft(2).substring(nickname.length - 2, nickname.length)}',
                      textStyle: TextStyle(fontSize: 27, color: Colors.white),
                    );
                  }),
              Positioned(
                right: -15,
                bottom: -15,
                child: IconButton(
                  icon: Icon(Icons.photo_camera),
                  onPressed: () async {
                    // 可以将Picker放到挂载的Module中, 但没有必要
                    final path = (await ImagePicker()
                            .getImage(source: ImageSource.gallery))
                        .path;
                    updateAvatar(path);
                  },
                ),
              )
            ]),
      );
}
