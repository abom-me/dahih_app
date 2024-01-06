
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../viewmodel/auth_viewmodel.dart';

final authProvider = Provider<AuthViewModel>((ref) {
  return AuthViewModel();
});
