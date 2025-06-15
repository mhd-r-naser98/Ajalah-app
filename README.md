# 📱 Ajalah

A modern Flutter application for managing and browsing articles and news, built with clean architecture, robust state management, and scalable service integration.

---

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (latest stable)
- Dart SDK
- VS Code, Android Studio, or any preferred IDE

### Installation

```bash
git clone https://github.com/your-username/new_ajalah.git
cd new_ajalah
flutter pub get
```

### Running the App

```bash
flutter run
```

---

## 🗂️ Project Structure

```
└── 📁lib
    └── 📁app
        └── app.dart
        └── 📁localization
            └── app_localizations.dart
            └── 📁locals
                └── ar_eg.dart
                └── en_us.dart
            └── 📁logic
                └── 📁cubit
                    └── locale_cubit.dart
                └── 📁state
                    └── locale_state.dart
        └── router.dart
        └── 📁theme
            └── app_shared_colors.dart
            └── app_theme.dart
            └── 📁extensions
                └── app_colors.dart
                └── app_radius.dart
                └── app_text_styles.dart
                └── theme_extensions.dart
            └── 📁groups
                └── color_group.dart
                └── text_style_group.dart
            └── 📁logic
                └── 📁cubit
                    └── theme_cubit.dart
                └── 📁state
                    └── theme_state.dart
    └── 📁core
        └── 📁config
            └── constants.dart
            └── router.dart
        └── 📁di
            └── providers.dart
            └── service_locator.dart
        └── 📁extensions
            └── pass_extension.dart
        └── 📁forms
            └── app_form_field_config.dart
            └── form_validation_messages.dart
        └── 📁network
            └── api_provider.dart
            └── 📁interceptors
                └── base_url_interceptor.dart
                └── logging_interceptor.dart
                └── token_interceptor.dart
        └── 📁services
            └── storage_service.dart
        └── 📁utils
            └── format_date.dart
            └── phone_utils.dart
            └── responsive_spacer.dart
            └── size_config.dart
    └── 📁features
        └── 📁auth
            └── 📁data
                └── auth_repo.dart
            └── 📁models
                └── address.dart
                └── dealer_model.dart
                └── geo_location.dart
                └── opening_hours.dart
                └── register_dealer_model.dart
                └── register_seller_model.dart
                └── user_model.dart
            └── 📁presentation
                └── 📁confirm
                    └── confirm_screen.dart
                    └── 📁logic
                        └── 📁cubit
                            └── confirm_cubit.dart
                        └── 📁state
                            └── confirm_state.dart
                    └── 📁widgets
                        └── step_one.dart
                        └── step_two.dart
                └── 📁forgot
                    └── forgot_screen.dart
                    └── 📁logic
                        └── 📁cubit
                            └── forgot_cubit.dart
                        └── 📁state
                            └── forgot_state.dart
                    └── 📁widgets
                        └── pass_requirements.dart
                        └── step_one.dart
                        └── step_three.dart
                        └── step_two.dart
                └── 📁login
                    └── 📁logic
                        └── 📁cubit
                            └── google_cubit.dart
                            └── login_cubit.dart
                        └── 📁state
                            └── google_state.dart
                            └── login_state.dart
                    └── login_screen.dart
                    └── 📁widgets
                        └── email_phone_buttons.dart
                        └── login_body.dart
                        └── login_buttons.dart
                        └── login_form.dart
                        └── login_method_selector.dart
                        └── phone_form.dart
                        └── remember_me.dart
                        └── social_login.dart
                └── 📁register
                    └── 📁logic
                        └── 📁cubit
                            └── register_cubit.dart
                        └── 📁state
                            └── register_state.dart
                            └── register_steps_data.dart
                    └── 📁pages
                        └── register_step_one.dart
                        └── register_step_two_otp.dart
                    └── register_screen.dart
                    └── 📁widgets
                        └── register_form_dealer.dart
                        └── register_form_seller.dart
                        └── role_radio_buttons.dart
        └── 📁global
            └── 📁privacy
                └── privacy_screen.dart
            └── 📁terms
                └── terms_screen.dart
        └── 📁home
            └── 📁logic
                └── home_cubit.dart
                └── home_state.dart
            └── 📁presentation
                └── home_screen.dart
                └── 📁profile
                    └── profile_screen.dart
                └── 📁sell
                    └── sell_screen.dart
                └── 📁settings
                    └── settings_screen.dart
                └── 📁widgets
                    └── home_body.dart
        └── 📁imported
            └── imported_screen.dart
        └── 📁more
            └── 📁presentation
                └── more_page.dart
        └── 📁splash
            └── 📁logic
                └── splash_cubit.dart
            └── 📁presentation
                └── splash_view.dart
                └── 📁widgets
                    └── splash_body.dart
        └── 📁used
            └── used_screen.dart
    └── 📁generated
        └── 📁intl
            └── messages_all.dart
            └── messages_ar.dart
            └── messages_en.dart
        └── l10n.dart
    └── 📁l10n
        └── intl_ar.arb
        └── intl_en.arb
    └── 📁shared
        └── 📁widgets
            └── app_button.dart
            └── app_card_button.dart
            └── app_custom_link.dart
            └── app_date_field.dart
            └── app_list_tile.dart
            └── app_loading.dart
            └── app_map.dart
            └── app_nav_bar.dart
            └── app_otp_field.dart
            └── app_phone_field.dart
            └── app_select_field.dart
            └── app_snack_bar.dart
            └── app_text_field.dart
            └── map_picker_screen.dart
            └── responsive_scroll_view.dart
    └── main.dart
```

- **core/**: Shared code (network, interceptors, utilities).
- **features/**: Modular feature folders.
- **providers/**: State management using Provider.
- **service_locator.dart**: Dependency injection setup.
- **assets/**: Images, translations, etc.
- **test/**: Unit and integration tests.

---

## 🧩 Key Technologies

- **Flutter**: UI development
- **Provider**: State management
- **GetIt**: Service locator for dependency injection
- **Dio**: Networking
- **JsonSerializable**: Data serialization
- _(Add any other libraries you use)_

---

## 🛠️ Dependency Injection

- All services (APIs, repositories, etc.) are registered in `service_locator.dart`.
- Services are injected into Providers via constructors.
- Avoid using the service locator directly inside widgets.

---

## 🏗️ State Management

- All Providers are registered in `main.dart` using `MultiProvider`.
- Each Provider manages a specific part of the app state (e.g., AuthProvider, ArticleProvider).

---

## 🌐 Networking

- All network requests are handled in `core/network`.
- Interceptors are used for token management and logging.

---

## 🧪 Testing

- All unit and integration tests are located in the `test/` directory.
- To run tests:

```bash
flutter test
```

---

## 📦 Building the App

```bash
flutter build apk   # For Android
flutter build ios   # For iOS
```

---

## 🤝 Contributing

1. Fork the repository.
2. Create a new branch.
3. Make your changes.
4. Open a Pull Request.

---

## 📄 License

[Specify your license here, e.g., MIT]

---

## 📬 Support

For questions or issues, please open an issue or contact [your@email.com].

---
