
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../viewmodel/auth_viewmodel.dart';

final authProvider = ChangeNotifierProvider<AuthViewModel>((ref) {
  return AuthViewModel();
});
