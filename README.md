# ga_user

GetArch User feat package,

## Getting Started

本项目出于教学目的, 内部代码都选用一些较复杂的方式来实现, 实际使用请根据具体情况采用.
(虽然某些写法较为复杂, 但由于Dart的AOT编译优化, 最后产生的代码并不会对性能造成影响)

## Depend on
* IDialog: 主项目中务必存在 IDialog实现, 否则UI部分无法正常运行.
    推荐直接使用get_arch_quick_start中的 IDialog
* get_env_info: 提供设备及app环境信息, 如app版本, 设备是否为模拟器, 等等.