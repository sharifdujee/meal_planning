import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meal_planning/core/global/show_custom_dialog.dart';
import 'package:meal_planning/core/utils/icon_path.dart';
import 'package:meal_planning/core/utils/image_path.dart';


import '../../../../core/utils/app_color.dart';

// ─── Models ────────────────────────────────────────────────────────────────

class UserProfile {
  final String name;
  final String subscriptionType;
  final bool isSubscriptionActive;
  final String? avatarUrl;

  const UserProfile({
    required this.name,
    required this.subscriptionType,
    required this.isSubscriptionActive,
    this.avatarUrl,
  });

  UserProfile copyWith({
    String? name,
    String? subscriptionType,
    bool? isSubscriptionActive,
    String? avatarUrl,
  }) {
    return UserProfile(
      name: name ?? this.name,
      subscriptionType: subscriptionType ?? this.subscriptionType,
      isSubscriptionActive: isSubscriptionActive ?? this.isSubscriptionActive,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }
}

class ActiveModule {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  bool isEnabled;

  ActiveModule({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.isEnabled,
  });
}

// ─── State ─────────────────────────────────────────────────────────────────

class ProfileState {
  final UserProfile profile;
  final List<ActiveModule> modules;
  final bool hasCustomPlan;
  final bool isLoading;

  const ProfileState({
    required this.profile,
    required this.modules,
    required this.hasCustomPlan,
    this.isLoading = false,
  });

  ProfileState copyWith({
    UserProfile? profile,
    List<ActiveModule>? modules,
    bool? hasCustomPlan,
    bool? isLoading,
  }) {
    return ProfileState(
      profile: profile ?? this.profile,
      modules: modules ?? this.modules,
      hasCustomPlan: hasCustomPlan ?? this.hasCustomPlan,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

// ─── Notifier ──────────────────────────────────────────────────────────────

class ProfileNotifier extends StateNotifier<ProfileState> {
  ProfileNotifier()
      : super(ProfileState(
    profile: const UserProfile(
      name: 'Roberto Adán',
      subscriptionType: 'PRO (Prueba)',
      isSubscriptionActive: true,
    ),
    modules: [
      ActiveModule(
        title: 'Entrenamiento',
        subtitle: 'Planes de entrenamiento personalizados',
        icon: Icons.fitness_center,
        iconColor: const Color(0xFF469271),
        isEnabled: true,
      ),
      ActiveModule(
        title: 'Nutrición',
        subtitle: 'Planes de comidas y lista de compras',
        icon: Icons.restaurant_menu,
        iconColor: const Color(0xFF469271),
        isEnabled: true,
      ),
      ActiveModule(
        title: 'Seguimiento de macronutrientes',
        subtitle: 'Ver calorías y macronutrientes por comida',
        icon: Icons.bar_chart,
        iconColor: const Color(0xFF469271),
        isEnabled: false,
      ),
    ],
    hasCustomPlan: false,
  ));

  void toggleModule(int index) {
    final updatedModules = [...state.modules];
    updatedModules[index] = ActiveModule(
      title: updatedModules[index].title,
      subtitle: updatedModules[index].subtitle,
      icon: updatedModules[index].icon,
      iconColor: updatedModules[index].iconColor,
      isEnabled: !updatedModules[index].isEnabled,
    );
    state = state.copyWith(modules: updatedModules);
  }

  void addCustomPlan() {
    state = state.copyWith(hasCustomPlan: true);
  }

  void updateProfile(UserProfile profile) {
    state = state.copyWith(profile: profile);
  }
}

// ─── Providers ─────────────────────────────────────────────────────────────

final profileProvider =
StateNotifierProvider<ProfileNotifier, ProfileState>((ref) {
  return ProfileNotifier();
});

// ─── Constants ─────────────────────────────────────────────────────────────



// ─── Profile Menu Items ────────────────────────────────────────────────────

class _MenuItem {
  final IconData icon;
  final String label;
  final Color? textColor;
  final VoidCallback? onTap;

  const _MenuItem({
    required this.icon,
    required this.label,
    this.textColor,
    this.onTap,
  });
}

// ─── Main Screen ───────────────────────────────────────────────────────────

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileState = ref.watch(profileProvider);
    final notifier = ref.read(profileProvider.notifier);

    final menuItems = [
      _MenuItem(icon: Icons.edit_outlined, label: 'Editar perfil'),
      _MenuItem(icon: Icons.favorite_border, label: 'Alimentos que me gustan'),
      _MenuItem(icon: Icons.warning_amber_outlined, label: 'Intolerancias'),
      _MenuItem(icon: Icons.language, label: 'Idioma'),
      _MenuItem(icon: Icons.bedtime_outlined, label: 'Tiempo de descanso'),
      _MenuItem(icon: Icons.timer_outlined, label: 'Duración del entrenamiento'),
      _MenuItem(icon: Icons.calendar_today_outlined, label: 'Días de entrenamiento'),
      _MenuItem(icon: Icons.fitness_center_outlined, label: 'Mi ejercicio favorito'),
      _MenuItem(icon: Icons.refresh, label: 'Regenerar mi plan'),
      _MenuItem(icon: Icons.description_outlined, label: 'Términos y condiciones'),
      _MenuItem(icon: Icons.lock_outline, label: 'Política de privacidad'),
      _MenuItem(icon: Icons.help_outline, label: 'Preguntas frecuentes',  ),
      _MenuItem(
        icon: Icons.delete_outline,
        label: 'Eliminar cuenta',
        textColor: AppColor.danger,
          onTap: (){
            showCustomDialog(context, imagePath: IconPath.confirmation, title: "¿Estás Seguro?", buttonText: "Sí, Eliminar", message: "¿Quieres eliminar tu cuenta de forma permanente?", onPressed: (){},
            isDoubleButton: true, secondButtonText: "Cancelar", onSecondPressed: (){});
          }
      ),
      _MenuItem(
        icon: Icons.logout,
        label: 'Cerrar sesión',
        textColor: AppColor.warning,
          onTap: (){
            showCustomDialog(context, imagePath: IconPath.confirmation, title: "¿Estás Seguro?", buttonText: "Cancelar", message: "¿Quieres cerrar sesión?", onPressed: (){},
                isDoubleButton: true, secondButtonText: "Cerrar sesión", onSecondPressed: (){});
          }
      ),
    ];

    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF469271).withValues(alpha: 0.2),
                  AppColor.background,
                ],
                stops: const [0.0, 0.08],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 60.h),

                // ── Title ──────────────────────────────────────────────
                Center(
                  child: Text(
                    'Perfil',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColor.white,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),

                // ── Avatar ─────────────────────────────────────────────
                Center(
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50.r,
                        backgroundColor: AppColor.cardBackground,
                        child: Image.asset(
                         ImagePath.user
                        ),
                      ),
                      Positioned(
                        bottom: 4,
                        right: 4,
                        child: GestureDetector(
                          onTap: () {
                            // handle avatar upload
                          },
                          child: Container(
                            padding: EdgeInsets.all(4.r),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.primary,
                            ),
                            child: Image.asset(
                              IconPath.editImage,
                              height: 20.h,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),

                // ── Name ───────────────────────────────────────────────
                Center(
                  child: Text(
                    profileState.profile.name,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColor.white,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),

                // ── Subscription card ──────────────────────────────────
                _SectionCard(
                  child: _SubscriptionTile(profile: profileState.profile),
                ),
                SizedBox(height: 16.h),

                // ── Menu items ─────────────────────────────────────────
                _SectionCard(
                  child: Column(
                    children: List.generate(menuItems.length, (i) {
                      final item = menuItems[i];
                      final isLast = i == menuItems.length - 1;
                      return _MenuTile(
                        item: item,
                        showDivider: !isLast,
                      );
                    }),
                  ),
                ),
                SizedBox(height: 24.h),

                // ── Active Modules ─────────────────────────────────────
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    'Módulos Activos',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColor.textBody,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                _SectionCard(
                  child: Column(
                    children: List.generate(
                      profileState.modules.length,
                          (i) {
                        final module = profileState.modules[i];
                        final isLast = i == profileState.modules.length - 1;
                        return _ModuleTile(
                          module: module,
                          showDivider: !isLast,
                          onToggle: () => notifier.toggleModule(i),
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    'Sus datos se conservan incluso si desactiva el módulo',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: AppColor.textBody,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),

                // ── Custom Plan ────────────────────────────────────────
                _SectionCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_month_outlined,
                            color: AppColor.textBody,
                            size: 20.r,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Plan Personalizado',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColor.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        profileState.hasCustomPlan
                            ? 'Tienes un plan personalizado activo'
                            : 'No tienes un plan personalizado',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppColor.textBody,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      GestureDetector(
                        onTap: notifier.addCustomPlan,
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColor.cardBorder,
                              width: 1.w,
                            ),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.add,
                                color: AppColor.white,
                                size: 18.r,
                              ),
                              SizedBox(width: 6.w),
                              Text(
                                'Añadir Mi Plan',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColor.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 40.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Reusable Widgets ───────────────────────────────────────────────────────

class _SectionCard extends StatelessWidget {
  final Widget child;

  const _SectionCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: AppColor.cardBackground,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          width: 1.w,
          color: AppColor.cardBorder,
        ),
      ),
      child: child,
    );
  }
}

class _SubscriptionTile extends StatelessWidget {
  final UserProfile profile;

  const _SubscriptionTile({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 40.h,
          width: 40.w,
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            color: const Color(0xFF1C3930),
          ),
          child: Icon(Icons.workspace_premium, color: AppColor.primary, size: 18.r),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profile.subscriptionType,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColor.white,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                profile.isSubscriptionActive
                    ? 'Suscripción activa'
                    : 'Sin suscripción',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColor.textBody,
                ),
              ),
            ],
          ),
        ),
        Icon(Icons.arrow_forward_ios, color: AppColor.textBody, size: 16.r),
      ],
    );
  }
}

class _MenuTile extends StatelessWidget {
  final _MenuItem item;
  final bool showDivider;

  const _MenuTile({required this.item, required this.showDivider});

  @override
  Widget build(BuildContext context) {
    final color = item.textColor ?? AppColor.white;
    return Column(
      children: [
        InkWell(
          onTap: item.onTap ?? () {},
          borderRadius: BorderRadius.circular(8.r),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Row(
              children: [
                Icon(item.icon, color: color, size: 20.r),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    item.label,
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: color,
                    ),
                  ),
                ),
                if (item.textColor == null)
                  Icon(
                    Icons.arrow_forward_ios,
                    color: AppColor.textBody,
                    size: 14.r,
                  ),
              ],
            ),
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            thickness: 1,
            color: AppColor.cardBorder,
          ),
      ],
    );
  }
}

class _ModuleTile extends StatelessWidget {
  final ActiveModule module;
  final bool showDivider;
  final VoidCallback onToggle;

  const _ModuleTile({
    required this.module,
    required this.showDivider,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Row(
            children: [
              Container(
                height: 36.h,
                width: 36.w,
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: const Color(0xFF1C3930),
                ),
                child: Icon(module.icon, color: AppColor.primary, size: 18.r),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      module.title,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColor.white,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      module.subtitle,
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: AppColor.textBody,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              Switch(
                value: module.isEnabled,
                onChanged: (_) => onToggle(),

                activeTrackColor: AppColor.primary.withValues(alpha: 0.3),
                inactiveThumbColor: AppColor.textBody,
                inactiveTrackColor: AppColor.cardBorder,
              ),
            ],
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            thickness: 1,
            color: AppColor.cardBorder,
          ),
      ],
    );
  }
}

// ─── Entry Point (for standalone testing) ──────────────────────────────────

