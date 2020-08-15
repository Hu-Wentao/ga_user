// Created by Hu Wentao.
// Email : hu.wentao@outlook.com
// Date  : 2020/8/14
// Time  : 22:36

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:ga_user/domain/entities/user.dart';
import 'package:ga_user/infrastructure/ui/user_card_view.dart';
import 'package:get_arch_quick_start/qs_base.dart';
import 'package:get_arch_quick_start/qs_domain.dart';
import 'package:get_arch_quick_start/qs_infrastructure.dart';
import 'package:get_arch_quick_start/qs_interface.dart';
import 'package:image_picker/image_picker.dart';

///
/// 可编辑的枚举类型
///
/// [enumTextMap] 该映射Key的顺序务必于Enum的顺序保持一致,
///   即enum.values[0]务必是Map的第一个元素, 以此类推
class EnumEditableView<T> extends StatefulWidget {
  final String leading;
  final String dialogTitle;
  final Either<Failure, T> eitherValue;
  final Future<Either<Failure, Unit>> Function(T nValue) updateValue;
  final Map<T, String> enumTextMap;

  const EnumEditableView({
    Key key,
    @required this.leading,
    @required this.dialogTitle,
    @required this.eitherValue,
    @required this.updateValue,
    @required this.enumTextMap,
  }) : super(key: key);

  @override
  _EnumEditableViewState<T> createState() => _EnumEditableViewState<T>();
}

class _EnumEditableViewState<T> extends State<EnumEditableView<T>> {
  ValueNotifier<T> showingEnumNotifier;
  @override
  void initState() {
    showingEnumNotifier =
        ValueNotifier<T>(widget.eitherValue?.getOrElse(() => null));
    super.initState();
  }

  @override
  Widget build(BuildContext context) => ListTile(
        leading:
            Text(widget.leading, style: Theme.of(context).textTheme.subtitle1),
        title: widget.eitherValue.safeFold(
            (l) => Text('- -'), (r) => Text(widget.enumTextMap[r]),
            onNull: () => LinearProgressIndicator()),
        trailing: widget.eitherValue == null
            ? null
            : IconButton(
                icon: Icon(Icons.chevron_right),
                onPressed: () => widget.eitherValue.fold(
                    (l) => GetIt.I<IDialog>().err(l,
                        tag: '_EnumEditableViewState.build', ctx: context),
                    (r) => showDialog<bool>(
                        context: context,
                        builder: (c) => QuickAlert(
                              title: Text(widget.dialogTitle),
                              content: _RadioTileList<T>(
                                  showingEnumNotifier: showingEnumNotifier,
                                  enumTextMap: widget.enumTextMap),
                              onCancel: () => _onCancelEdit(c),
                              onConfirm: () async {
                                if (showingEnumNotifier.value != r) {
                                  await widget
                                      .updateValue(showingEnumNotifier.value);
                                  _onConfirmEdit(c);
                                } else
                                  _onCancelEdit(c);
                              },
                            )).then((dialogReturn) =>
                        Scaffold.of(context).showSnackBar(
                          SnackBar(
                              content: Text(dialogReturn ? '正在保存...' : '取消编辑'),
                              duration: const Duration(seconds: 2)),
                        )))),
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
                              } else {
                                _onCancelEdit(ctx);
                              }
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
  // 用于判断当前是否存在已登录用户, 如果有则展示"编辑头像"按钮
  final Either<Failure, User> hasUser;
  final Future<Either<Failure, Uint8List>> avatarBytes;
  final String nickname;
  final Future<Failure> Function(String filePath) updateAvatar;

  const EditableAvatar({
    Key key,
    @required this.hasUser,
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
              FutureAvatar(
                avatarBytes: avatarBytes,
                nickname: nickname,
              ),
              if (hasUser?.isRight() ?? false)
                Positioned(
                  right: -15,
                  bottom: -15,
                  child: IconButton(
                    icon: Icon(Icons.photo_camera, color: Colors.black54),
                    // 可以将Picker放到挂载的Module中, 但没有必要
                    onPressed: () async => updateAvatar((await ImagePicker()
                                .getImage(source: ImageSource.gallery))
                            .path)
                        .asyncMapFailure((f) {
                      if (f is InvalidInputWithoutFeedbackFailure) {
                        GetIt.I<IDialog>().toast('您没有选择头像');
                        return null;
                      }
                      return f;
                    }).asyncErrDialog(context),
                  ),
                )
            ]),
      );
}
