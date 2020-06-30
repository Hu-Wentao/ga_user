// Created by Hu Wentao.
// Email : hu.wentao@outlook.com
// Date  : 2020/3/3
// Time  : 23:41
import 'package:ga_user/application/login.dart';
import 'package:ga_user/application/register.dart';
import 'package:ga_user/domain/entities/user.dart';
import 'package:ga_user/domain/model/auth_model.dart';
import 'package:ga_user/domain/value_objects.dart';
import 'package:get_arch_core/get_arch_core.dart';
import 'package:get_state/get_state.dart';

class AuthVm extends ViewModel<AuthM> {
  final IDialog dialog;
  final UserLogin userLogin;
  final UserRegister userRegister;

  AuthVm(this.userLogin, this.userRegister, this.dialog);

  bool get isLogin => m.isLogin;

  bool get isPwdObscure => m.isPwdObscure;

  bool get isAutoValidate => m.isAutoValidate;

  bool get isPwdEqual => m.isPwdEqual;

  EmailAddress get emailAddress => m.emailAddress;

  Password get password => m.password;

  Password get rePassword => m.rePassword;

  // on 开头的方法都无需check,因为不耗时
  onToggleLoginOrRegister() {
    // 复位状态
    m.isPwdObscure = true;
    //切换登录,注册
    m.isLogin = !isLogin;
    notifyListeners();
  }

  onTogglePwdObscure() {
    m.isPwdObscure = !isPwdObscure;
    notifyListeners();
  }

  onToggleAutoValidate() {
    m.isAutoValidate = true;
    notifyListeners();
  }

  onEmailChanged(String value) {
    m.emailAddress = EmailAddress(value);
  }

  onPasswordChanged(String value) {
    m.password = Password(value);
  }

  onRePwdChanged(String value) {
    m.rePassword = Password(value);
  }

  /// 登陆
  /// 可选的[isLogin] 仅用于单元测试使用
  Future<bool> loginOrRegister({bool isLogin}) async {
    if (vmCheckAndSetBusy) return null;
    // 开启自动View检查输入参数
    onToggleAutoValidate();
    // 检查待发送的参数
    bool isEmailValidate = emailAddress?.isValid() ?? false;
    bool isPwdValidate = password?.isValid() ?? false;
    if (!(isEmailValidate && isPwdValidate)) {
      vmSetIdle;
      return null;
    }

    var result;
    User param = User.authWithEmail(emailAddress, password);
    if (isLogin ?? m.isLogin) {
      (await userLogin(param)).fold((err) {
        // 网络错误,app版本过低等导致
        result = _onAuthFail('登陆失败\n详情：${err.msg}');
      }, (r) {
        result = _onAuthSuccess('登陆成功,欢迎回来!');
      });
    } else {
      (await userRegister(param)).fold((e) {
        // todo 应当从后端获得更多信息, 例如是网络问题,还是邮箱已注册,还是密码太短
        result = _onAuthFail(e.msg);
      }, (_) {
        result = _onAuthSuccess('注册成功,已为您自动登陆!');
      });
    }
    vmSetIdleAndNotify;
    return result;
  }

  bool _onAuthSuccess(String s) {
    dialog.toast('$s');
    return true;
  }

  bool _onAuthFail(String s) {
    dialog.toast('认证出错: $s\n');
    return false;
  }
}