import 'package:flutter/material.dart';
import 'package:new_ajalah/core/di/service_locator.dart';
import 'package:new_ajalah/core/services/storage_service.dart';
import 'package:new_ajalah/core/utils/responsive_spacer.dart';
import 'package:new_ajalah/features/auth/models/user_model.dart';
import 'package:new_ajalah/features/more/presentation/widgets/basics_dealer.dart';
import 'package:new_ajalah/features/more/presentation/widgets/basics_seller.dart';
import 'package:new_ajalah/features/more/presentation/widgets/head_line.dart';
import 'package:new_ajalah/features/more/presentation/widgets/profile_imgs.dart';
import 'package:new_ajalah/features/more/presentation/widgets/settings_widget.dart';
import 'package:new_ajalah/core/widgets/app_loading.dart';
import 'package:new_ajalah/core/widgets/responsive_scroll_view.dart';
// ignore: library_prefixes

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Future<void> handleRefresh() async {
    //   debugPrint("Refresh started");
    //   await Future.delayed(Duration(seconds: 2));
    //   debugPrint("Refresh ended");
    // }

    return FutureBuilder<UserModel?>(
      future: locator<StorageService>().getUser(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LoadingWidget();

        final user = snapshot.data!;
        return Scaffold(
          body: ResponsiveScrollView(
            // onRefresh: handleRefresh,
            child: Column(
              children: [
                ProfileImgs(
                  avatarUrl: user.profileImageUrl,
                  coverUrl: user.coverImageUrl,
                ),
                const ResponsiveSpacer(size: SpacerSize.xLarge),
                HeadLine(user: user),

                const ResponsiveSpacer(size: SpacerSize.medium),
                Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (user.role == 'Seller') ...[
                      const BasicsSeller(),
                    ] else
                      const BasicsDealer(),

                    const ResponsiveSpacer(size: SpacerSize.large),

                    const SettingsWidget(),
                    const ResponsiveSpacer(size: SpacerSize.large),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
