
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khlfan_shtain/viewmodel/textfield_viewmodel.dart';



final textFieldProvider = StateProvider<TextFieldViewModel>((ref) {
  return TextFieldViewModel(ref);
});
