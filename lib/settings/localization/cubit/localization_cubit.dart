import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:my_mobile_app/settings/localization/localization_helper.dart';

part 'localization_state.dart';

class LocalizationCubit extends Cubit<LocalizationState> {
  LocalizationCubit() : super(LocalizationInitial()) {
    _localizationInitialized();
  }

  Future<void> _localizationInitialized() async {
    final localeStr = await LocalizationHelper.getLocaleStr();

    _emitLocalization(localeStr);
  }

  Future<void> localizationTogglePressed(String localeStr) async {
    await LocalizationHelper.changeLanguage(localeStr);

    _emitLocalization(localeStr);
  }

//============================================================
// ** Helper Functions **
//============================================================

  void _emitLocalization(String? localeStr) {
    return switch (localeStr) {
      LocalizationHelper.enUs => emit(LocalizationEnUs()),
      _ => emit(LocalizationEnUs()),
    };
  }
}
