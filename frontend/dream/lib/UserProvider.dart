import 'package:dream/User.dart';
import 'package:flutter/material.dart';

// 사용자 정보 관리하는 inheritedWidget 클래스 
class UserProvider extends InheritedWidget {
  final User user;

  UserProvider({required this.user, required Widget child}) : super(child: child);

  // 사용자 정보에 접근하는 정적 메서드
  // return type: User
  static User of(BuildContext context) {
    final UserProvider? provider = context.dependOnInheritedWidgetOfExactType<UserProvider>();
    if(provider == null) {
      throw FlutterError('User Provider not found in context');
    }
    return provider.user;
  }

  @override
  bool updateShouldNotify(UserProvider oldWidget) {
    return user != oldWidget.user;
  }
}