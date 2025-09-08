import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Events
abstract class LocalizationEvent {}

class ChangeLanguageEvent extends LocalizationEvent {
  final String languageCode;
  ChangeLanguageEvent(this.languageCode);
}

class LoadSavedLanguageEvent extends LocalizationEvent {}

// States
abstract class LocalizationState {
  final Locale locale;
  const LocalizationState(this.locale);
}

class LocalizationInitial extends LocalizationState {
  const LocalizationInitial() : super(const Locale('en'));
}

class LocalizationLoaded extends LocalizationState {
  const LocalizationLoaded(Locale locale) : super(locale);
}

// Bloc
class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  static const String _languageKey = 'selected_language';

  LocalizationBloc() : super(const LocalizationInitial()) {
    on<LoadSavedLanguageEvent>(_onLoadSavedLanguage);
    on<ChangeLanguageEvent>(_onChangeLanguage);
  }

  Future<void> _onLoadSavedLanguage(
    LoadSavedLanguageEvent event,
    Emitter<LocalizationState> emit,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedLanguage = prefs.getString(_languageKey) ?? 'en';
      emit(LocalizationLoaded(Locale(savedLanguage)));
    } catch (e) {
      emit(const LocalizationLoaded(Locale('en')));
    }
  }

  Future<void> _onChangeLanguage(
    ChangeLanguageEvent event,
    Emitter<LocalizationState> emit,
  ) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_languageKey, event.languageCode);
      emit(LocalizationLoaded(Locale(event.languageCode)));
    } catch (e) {
      // If saving fails, still emit the new locale
      emit(LocalizationLoaded(Locale(event.languageCode)));
    }
  }

  void toggleLanguage() {
    final currentLanguage = state.locale.languageCode;
    final newLanguage = currentLanguage == 'en' ? 'am' : 'en';
    add(ChangeLanguageEvent(newLanguage));
  }
}
