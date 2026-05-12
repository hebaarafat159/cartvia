import 'package:cartvia_project/viewmodels/home_view_model.dart';
import 'package:cartvia_project/theme/tokens/app_colors.dart';
import 'package:cartvia_project/theme/tokens/app_sizes.dart';
import 'package:cartvia_project/theme/tokens/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<HomeViewModel>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(viewModel.title),
      ),
      body: Container(
        // Background gradient (very subtle like design)
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.backgroundGradientTop,
              AppColors.backgroundGradientBottom,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: AppSpacing.pagePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// TOP HEADER
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "APRIL 2026",
                          style: TextStyle(
                            letterSpacing: 2,
                            color: AppColors.primaryAccent,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: AppSpacing.small),
                        Text(
                          "Saved Lists",
                          style: TextStyle(
                            fontSize: AppSizes.legacyHeroTitleFont,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      radius: AppSizes.avatarRadius,
                      backgroundColor: AppColors.avatarBackground,
                      child: const Text(
                        "S",
                        style: TextStyle(
                          fontSize: AppSizes.profileInitialFont,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    )
                  ],
                ),

                const SizedBox(height: AppSpacing.screenGap),

                /// ORANGE CARD (Gradient)
                Container(
                  padding: AppSpacing.featureCardPadding,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(AppSizes.radiusXXLarge),
                    gradient: const LinearGradient(
                      colors: [
                        AppColors.primaryAccentLight,
                        AppColors.primaryAccentSoft,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "YOUR LISTS",
                            style: TextStyle(
                              color: AppColors.surfaceMuted,
                              letterSpacing: 2,
                            ),
                          ),
                          SizedBox(height: AppSpacing.regular),
                          Text(
                            "Saved grocery lists",
                            style: TextStyle(
                              color: AppColors.surface,
                              fontSize: AppSizes.legacyCardTitleFont,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: AppSpacing.ctaPadding,
                        decoration: BoxDecoration(
                          color: AppColors.surface.withValues(alpha: 0.9),
                          borderRadius:
                              BorderRadius.circular(AppSizes.radiusLarge),
                        ),
                        child: const Text(
                          "New List",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.screenGap),

                /// COLLECTIONS
                const Text(
                  "COLLECTIONS",
                  style: TextStyle(
                    letterSpacing: 2,
                    color: AppColors.primaryAccent,
                  ),
                ),

                const SizedBox(height: AppSpacing.regular),

                const Text(
                  "Choose a saved list",
                  style: TextStyle(
                    fontSize: AppSizes.legacySectionTitleFont,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: AppSpacing.xxxLarge),

                /// LIST ITEMS
                Expanded(
                  child: ListView(
                    children: [
                      listCard(
                        title: "Home Monthly List",
                        subtitle: "MAIN HOME",
                        items: "24 items",
                        action: "Share",
                        highlight: true,
                      ),
                      listCard(
                        title: "School Week List",
                        subtitle: "KIDS SNACKS",
                        items: "8 items",
                        action: "View",
                      ),
                      listCard(
                        title: "Family Dinner List",
                        subtitle: "WEEKEND MEAL",
                        items: "12 items",
                        action: "View",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget listCard({
    required String title,
    required String subtitle,
    required String items,
    required String action,
    bool highlight = false,
  }) {
    return Container(
      margin: AppSpacing.listCardMargin,
      padding: AppSpacing.listCardPadding,
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.7),
        borderRadius: BorderRadius.circular(AppSizes.radiusXLarge),
        border:
            highlight ? Border.all(color: AppColors.cardHighlightBorder) : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              subtitle,
              style: const TextStyle(
                letterSpacing: 2,
                color: AppColors.primaryAccent,
              ),
            ),
            const SizedBox(height: AppSpacing.small),
            Text(
              title,
              style: const TextStyle(
                fontSize: AppSizes.profileInitialFont,
                fontWeight: FontWeight.bold,
              ),
            ),
          ]),
          Row(
            children: [
              Text(items, style: const TextStyle(color: AppColors.textMuted)),
              const SizedBox(width: AppSpacing.large),
              Container(
                padding: AppSpacing.pillPadding,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppSizes.radiusLarge),
                  border: Border.all(color: AppColors.borderSubtle),
                ),
                child: Text(
                  action,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
