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
//    if (vm.isUserModelReady) return CircularProgressIndicator();
//    if (vm.m.isLeft()) {
//      return Text('${vm.m}');
//    }
    return ListTile(
      leading: _FutureAvatar(
          avatarBytes: vm.getAvatar(), nickname: vm.getNickName()),
      title: Row(
        children: <Widget>[
          Text('${vm.getNickName()}'),
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
//    return vm.vmUpdate((await vm.obsUser(null)));
  }

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
                showingValue: vm.getSex(),
                updateValue: vm.updateSex,
                enumTextMap: <Sex, String>{
                  Sex.male: '男',
                  Sex.female: '女',
                },
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

///
/// 可编辑的枚举类型
///
/// [enumTextMap] 该映射Key的顺序务必于Enum的顺序保持一致,
///   即enum.values[0]务必是Map的第一个元素, 以此类推
class EnumEditableView<T> extends StatefulWidget {
  final String leading;
  final String dialogTitle;
  final T showingValue;
  final Function(T nValue) updateValue;
  final Map<T, String> enumTextMap;

  const EnumEditableView({
    Key key,
    @required this.leading,
    @required this.dialogTitle,
    @required this.showingValue,
    @required this.updateValue,
    @required this.enumTextMap,
  }) : super(key: key);

  @override
  _EnumEditableViewState createState() => _EnumEditableViewState();
}

class _EnumEditableViewState<T> extends State<EnumEditableView<T>> {
  ValueNotifier<T> showingEnumNotifier;
  @override
  void initState() {
    showingEnumNotifier = ValueNotifier<T>(widget.showingValue);
    super.initState();
  }

  @override
  Widget build(BuildContext context) => ListTile(
        leading:
            Text(widget.leading, style: Theme.of(context).textTheme.subtitle1),
        title: Text(widget.showingValue == null
            ? '- -'
            : widget.enumTextMap[widget.showingValue]),
        trailing: IconButton(
            icon: Icon(Icons.chevron_right),
            onPressed: () => widget.showingValue == null
                ? null
                : showDialog<bool>(
                    context: context,
                    builder: (c) => AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          title: Text(widget.dialogTitle),
                          content: _RadioTileList<T>(
                              showingEnumNotifier: showingEnumNotifier,
                              enumTextMap: widget.enumTextMap),
                          contentPadding: const EdgeInsets.only(
                              left: 20, right: 20, top: 18),
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
                                if (showingEnumNotifier.value !=
                                    widget.showingValue) {
                                  await widget
                                      .updateValue(showingEnumNotifier.value);
                                  _onConfirmEdit(c);
                                } else
                                  _onCancelEdit(c);
                              },
                              child: const Text('保存'),
                            ),
                          ],
                        )).then(
                    (dialogReturn) => Scaffold.of(context).showSnackBar(
                          SnackBar(
                              content: Text(dialogReturn ? '正在保存...' : '取消编辑'),
                              duration: const Duration(seconds: 2)),
                        ))),
      );

  _onCancelEdit(BuildContext _) => Navigator.pop(_, false);

  _onConfirmEdit(BuildContext _) => Navigator.pop(_, true);
}

class _RadioTileList<T> extends StatefulWidget {
  final ValueNotifier<T> showingEnumNotifier;
  final Map<T, String> enumTextMap;

  const _RadioTileList({
    Key key,
    @required this.showingEnumNotifier,
    @required this.enumTextMap,
  }) : super(key: key);

  @override
  __RadioTileListState createState() => __RadioTileListState();
}

class __RadioTileListState<T> extends State<_RadioTileList<T>> {
  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
            Sex.values.length,
            (i) => RadioListTile<T>(
                  title: Text(widget.enumTextMap.values.elementAt(i)),
                  value: widget.enumTextMap.keys.elementAt(i),
                  groupValue: widget.showingEnumNotifier.value,
                  onChanged: _refresh,
                )),
      );

  void _refresh(T value) =>
      setState(() => widget.showingEnumNotifier.value = value);
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
class EditableAvatar extends StatefulWidget {
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
  _EditableAvatarState createState() => _EditableAvatarState();
}

class _EditableAvatarState extends State<EditableAvatar> {
  ValueNotifier<bool> _showAvatarEditIconNotifier;
  @override
  void initState() {
    _showAvatarEditIconNotifier = ValueNotifier(false);
    _showAvatarEditIconNotifier.addListener(() => setState(() {}));
    super.initState();
  }

  @override
  void dispose() {
    _showAvatarEditIconNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Center(
        child: Stack(
            alignment: Alignment.center,
            overflow: Overflow.visible,
            fit: StackFit.loose,
            children: [
              _FutureAvatar(
                avatarBytes: widget.avatarBytes,
                nickname: widget.nickname,
                successNotifier: _showAvatarEditIconNotifier,
              ),
              if (_showAvatarEditIconNotifier.value)
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
                      widget.updateAvatar(path);
                    },
                  ),
                )
            ]),
      );
}

///
/// 头像展示
class _FutureAvatar extends StatelessWidget {
  final Future<Either<Failure, Uint8List>> avatarBytes;
  final String nickname;
  final ValueNotifier<bool> successNotifier;
  const _FutureAvatar(
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
