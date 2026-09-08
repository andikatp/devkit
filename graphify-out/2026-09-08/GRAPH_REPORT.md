# Graph Report - devkit  (2026-09-08)

## Corpus Check
- 82 files · ~26,811 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 716 nodes · 1014 edges · 53 communities (50 shown, 3 thin omitted)
- Extraction: 100% EXTRACTED · 0% INFERRED · 0% AMBIGUOUS
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `ee0f5d98`
- Run `git rev-parse HEAD` and compare to check if the graph is stale.
- Run `graphify update .` after code changes (no API cost).

## Community Hubs (Navigation)
- app_theme.dart
- header_widget.dart
- devkit_console_screen.dart
- Architecting Flutter Applications
- logcat_modal.dart
- flavor_config.dart
- connect_command_card.dart
- console_state_entity.dart
- logcat_log_entity.dart
- state_toggles_card.dart
- pro_paywall_modal.dart
- package:flutter/material.dart
- tools_screen_content_widget.dart
- MainActivity
- devkit
- rules/graphify.md
- workflows/graphify.md
- tools_screen.dart
- injection_container.dart
- app_assets.dart
- state_toggles_card.dart
- device_info_service.dart
- package:devkit/core/theme/app_theme.dart
- paywall_tier_option_card.dart
- tool_switch_card.dart
- bottom_navigation.dart
- pro_suite_banner_card.dart
- StatelessWidget
- bottom_navigation.dart
- logcat_cubit.dart
- home_repository_impl.dart
- package:flutter/material.dart
- devkit_dashboard_cubit.dart
- home_local_data_source.dart
- package:devkit/core/theme/app_theme.dart
- logcat_local_data_source.dart
- permissions_state.dart
- permissions_cubit.dart
- basic_permissions_step.dart
- grant_status_card.dart
- permissions_header_bar.dart
- direct_mode_step.dart
- State
- logcat_repository_impl.dart
- logcat_local_data_source.dart
- package:flutter/material.dart
- devkit_dashboard_view.dart
- logcat_screen.dart
- direct_mode_step.dart
- VoidCallback

## God Nodes (most connected - your core abstractions)
1. `DevKitDashboardCubit` - 21 edges
2. `LogcatCubit` - 19 edges
3. `PermissionsCubit` - 17 edges
4. `ToolsCubit` - 12 edges
5. `ConsoleNavigationCubit` - 11 edges
6. `PaywallCubit` - 11 edges
7. `1. Presentation Layer Rules` - 11 edges
8. `Architecting Flutter Applications` - 7 edges
9. `Master Flutter Architecture & Refactoring Rules` - 5 edges
10. `2. Application Layer Rules (Cubits / Blocs)` - 5 edges

## Surprising Connections (you probably didn't know these)
- `ConsoleNavigationCubit` --references--> `ConsoleNavigationState`  [EXTRACTED]
  lib/features/core/application/console_navigation_cubit.dart → lib/features/core/application/console_navigation_state.dart
- `LogcatCubit` --references--> `LogcatState`  [EXTRACTED]
  lib/features/logcat/application/logcat_cubit.dart → lib/features/logcat/application/logcat_state.dart
- `PermissionsCubit` --references--> `PermissionsState`  [EXTRACTED]
  lib/features/permissions/application/permissions_cubit.dart → lib/features/permissions/application/permissions_state.dart
- `build` --references--> `PermissionsCubit`  [EXTRACTED]
  lib/features/permissions/presentation/widgets/direct_mode_step.dart → lib/features/permissions/application/permissions_cubit.dart
- `build` --references--> `ConsoleNavigationCubit`  [EXTRACTED]
  lib/features/core/presentation/screens/devkit_console_screen.dart → lib/features/core/application/console_navigation_cubit.dart

## Import Cycles
- None detected.

## Communities (53 total, 3 thin omitted)

### Community 0 - "app_theme.dart"
Cohesion: 0.09
Nodes (21): AppColors, AppTheme, cyanBright, cyberAmber, cyberBlack, cyberBorder, cyberCard, cyberCardAlt (+13 more)

### Community 1 - "header_widget.dart"
Cohesion: 0.20
Nodes (9): build, icon, index, isActive, isPro, isProUnlocked, label, new (+1 more)

### Community 2 - "devkit_console_screen.dart"
Cohesion: 0.07
Nodes (34): Cubit, FocusNode, PaywallCubit, selectTier, updateCustomAmount, copyWith, customAmount, new (+26 more)

### Community 3 - "Architecting Flutter Applications"
Cohesion: 0.12
Nodes (16): Application Layer, Architecting Flutter Applications, Architectural Layers, Contents, Domain Layer, Domain Layer: Entity, Domain Layer: Repository Interface, Examples (+8 more)

### Community 4 - "logcat_modal.dart"
Cohesion: 0.17
Nodes (11): hasSeenPermissionsSetup, markPermissionsSetupSeen, SecureStorageService, _storage, package:devkit/core/constant/app_keys.dart, package:devkit/features/core/presentation/screens/devkit_console_screen.dart, package:devkit/features/core/presentation/screens/my_app.dart, package:flutter_secure_storage/flutter_secure_storage.dart (+3 more)

### Community 5 - "flavor_config.dart"
Cohesion: 0.13
Nodes (14): flavor, FlavorConfig, FlavorType, FlavorValues, initialize, _initialized, _instance, new (+6 more)

### Community 6 - "connect_command_card.dart"
Cohesion: 0.20
Nodes (9): getDeviceInfo, HomeRepository, getDeviceInfo, HomeRepositoryImpl, localDataSource, new, package:devkit/core/services/device_info_service.dart, package:devkit/features/home/domain/repositories/home_repository.dart (+1 more)

### Community 7 - "console_state_entity.dart"
Cohesion: 0.05
Nodes (39): 1.10 Strict One Widget Class Per File, 1.1 Native `spacing:` Parameter Over `Gap` Widgets, 1.2 Extract Event Handlers Above `build()`, 1.3 Eliminate Unnecessary Middleman Wrappers (`a -> b -> c` to `a -> c`), 1.4 Stop Prop Drilling (Read State & Encapsulate Callbacks in Child), 1.5 Standardized Bottom Sheets with Static `.show()` Pattern, 1.6 Screen File Size Limit (<250 Lines) & Inlining Simple Bodies, 1.7 Declarative Toast & Dialog Handling via `BlocListener` (+31 more)

### Community 8 - "logcat_log_entity.dart"
Cohesion: 0.09
Nodes (22): BuildContext, bodyLarge, bodyMedium, bodySmall, BuildContextExtensions, displayLarge, displayMedium, displaySmall (+14 more)

### Community 9 - "state_toggles_card.dart"
Cohesion: 0.11
Nodes (24): LogcatCubit, build, LogcatHeaderBarWidget, new, _onClearLogs, build, _getLogLevelColor, LogcatLevelFilterWidget (+16 more)

### Community 10 - "pro_paywall_modal.dart"
Cohesion: 0.13
Nodes (14): 1.1 Native `spacing:` Parameter, 1.2 Handler Extraction Above `build()`, 1.3 Standardized Bottom Sheets (`*Sheet.show`), 1.4 Encapsulated Child Widgets (No Prop Drilling), 1. Presentation Layer Refactoring, 2.1 Declarative Toast & Dialog Handling via `BlocListener`, 2. Application Layer Refactoring, 3.1 Domain Entity Extensions (+6 more)

### Community 11 - "package:flutter/material.dart"
Cohesion: 0.20
Nodes (9): Color, activeColor, build, icon, isSelected, label, new, onTap (+1 more)

### Community 12 - "tools_screen_content_widget.dart"
Cohesion: 0.10
Nodes (23): ToolsCubit, animationScale, copyWith, gpuProfiling, new, showLayoutBounds, showPointerLocation, showTaps (+15 more)

### Community 13 - "MainActivity"
Cohesion: 0.40
Nodes (3): MainActivity, FlutterActivity, FlutterEngine

### Community 20 - "tools_screen.dart"
Cohesion: 0.20
Nodes (11): PermissionsCubit, build, _goToStep, build, _goToStep, BasicPermissionsStep, build, _buildLocationAccordion (+3 more)

### Community 21 - "injection_container.dart"
Cohesion: 0.20
Nodes (9): checkPermissions, homeRepository, _initDashboard, toggleAdbGrantMode, toggleDevOptions, togglePing, toggleUsbDebugging, toggleWirelessDebugging (+1 more)

### Community 22 - "app_assets.dart"
Cohesion: 0.22
Nodes (7): AppAssets, grid, AppKeys, hasSeenPermissionsSetup, _, _, static const String

### Community 23 - "state_toggles_card.dart"
Cohesion: 0.05
Nodes (52): DeviceInfoData, ConsoleNavigationCubit, selectTab, unlockPro, build, DevKitConsoleScreen, _handleTabSelect, new (+44 more)

### Community 24 - "device_info_service.dart"
Cohesion: 0.22
Nodes (8): build, child, CyberGridBackground, _neonGridMatrix, new, package:devkit/core/constant/app_assets.dart, static const ColorFilter, Widget

### Community 25 - "package:devkit/core/theme/app_theme.dart"
Cohesion: 0.05
Nodes (38): bool get, adbConnectCommand, ConsoleStateEntity, ConsoleStateEntityX, copyWith, deviceIp, deviceModel, devicePort (+30 more)

### Community 26 - "paywall_tier_option_card.dart"
Cohesion: 0.20
Nodes (9): badgeText, build, index, isPopular, isSelected, new, onTap, subtitle (+1 more)

### Community 27 - "tool_switch_card.dart"
Cohesion: 0.22
Nodes (8): IconData, build, icon, new, onChanged, subtitle, title, value

### Community 28 - "bottom_navigation.dart"
Cohesion: 0.06
Nodes (29): dart:io, brand, _deviceInfoPlugin, DeviceInfoService, fallback, getDeviceInfo, ipAddress, model (+21 more)

### Community 29 - "pro_suite_banner_card.dart"
Cohesion: 0.22
Nodes (8): build, currentStep, isDirectModeGranted, new, onContinue, onFinish, onSkip, PermissionsBottomBar

### Community 30 - "StatelessWidget"
Cohesion: 0.15
Nodes (12): createState, dispose, _handleFinish, _handleSkip, initState, new, _onBack, onCompleted (+4 more)

### Community 31 - "bottom_navigation.dart"
Cohesion: 0.22
Nodes (8): build, currentIndex, DevKitBottomNavigationBar, isPro, new, onTap, package:devkit/features/core/presentation/widgets/navbar/devkit_nav_item.dart, ValueChanged

### Community 32 - "logcat_cubit.dart"
Cohesion: 0.10
Nodes (20): dart:async, clearLogs, _loadLogs, logcatRepository, selectLogLevel, updateFilter, getInitialLogs, LogcatRepository (+12 more)

### Community 33 - "home_repository_impl.dart"
Cohesion: 0.17
Nodes (11): setAnimationScale, toggleGpuProfiling, toggleLayoutBounds, togglePointerLocation, toggleStrictMode, toggleTaps, toolsRepository, getInitialToolsState (+3 more)

### Community 34 - "package:flutter/material.dart"
Cohesion: 0.08
Nodes (28): Future, build, createState, _hasSeenFuture, initState, MyApp, _MyAppState, new (+20 more)

### Community 35 - "devkit_dashboard_cubit.dart"
Cohesion: 0.50
Nodes (4): getDeviceInfo, HomeLocalDataSource, HomeLocalDataSourceImpl, new

### Community 36 - "home_local_data_source.dart"
Cohesion: 0.22
Nodes (8): build, description, footerLabel, icon, isGranted, new, onAllow, title

### Community 37 - "package:devkit/core/theme/app_theme.dart"
Cohesion: 0.15
Nodes (12): build, new, targetHost, build, new, show, SkipConfirmationDialog, build (+4 more)

### Community 38 - "logcat_local_data_source.dart"
Cohesion: 0.15
Nodes (12): createState, dispose, _handleSkip, initState, new, _onBack, _pageController, show (+4 more)

### Community 39 - "permissions_state.dart"
Cohesion: 0.20
Nodes (9): copyWith, currentStep, isDirectModeGranted, isLocationGranted, isNearbyWifiGranted, isNotificationGranted, isVerifying, new (+1 more)

### Community 40 - "permissions_cubit.dart"
Cohesion: 0.25
Nodes (7): checkInitialPermissions, requestLocation, requestNearbyWifi, requestNotification, setStep, verifyDirectModeGrant, package:devkit/core/services/permission_service.dart

### Community 41 - "basic_permissions_step.dart"
Cohesion: 0.22
Nodes (8): GetIt, initServiceLocator, sl, package:devkit/features/core/application/console_navigation_cubit.dart, package:devkit/features/home/infrastructure/repositories/home_repository_impl.dart, package:devkit/features/logcat/infrastructure/repositories/logcat_repository_impl.dart, package:devkit/features/tools/infrastructure/repositories/tools_repository_impl.dart, package:get_it/get_it.dart

### Community 42 - "grant_status_card.dart"
Cohesion: 0.29
Nodes (6): build, GrantStatusCard, isGranted, isVerifying, new, onVerify

### Community 43 - "permissions_header_bar.dart"
Cohesion: 0.29
Nodes (6): build, currentStep, new, onBack, PermissionsHeaderBar, totalSteps

### Community 44 - "direct_mode_step.dart"
Cohesion: 0.33
Nodes (5): ConsoleNavigationState, copyWith, currentNavIndex, isPro, new

### Community 45 - "State"
Cohesion: 0.33
Nodes (6): DevKitNavItem, PingStatusCardWidget, PermissionCard, PaywallTierOptionCard, ToolSwitchCard, StatelessWidget

### Community 46 - "logcat_repository_impl.dart"
Cohesion: 0.33
Nodes (5): getInitialToolsState, localDataSource, new, package:devkit/features/tools/domain/repositories/tools_repository.dart, package:devkit/features/tools/infrastructure/datasources/tools_local_data_source.dart

### Community 47 - "logcat_local_data_source.dart"
Cohesion: 0.50
Nodes (4): getToolsState, new, ToolsLocalDataSource, ToolsLocalDataSourceImpl

### Community 48 - "package:flutter/material.dart"
Cohesion: 0.28
Nodes (7): initServiceLocator, main, initServiceLocator, main, package:devkit/core/di/injection_container.dart, package:devkit/core/flavors/flavor_config.dart, package:flutter/material.dart

### Community 49 - "devkit_dashboard_view.dart"
Cohesion: 0.25
Nodes (7): build, DevKitDashboardView, new, package:devkit/features/core/presentation/widgets/header_widget.dart, package:devkit/features/home/presentation/widgets/connect_command_card.dart, package:devkit/features/home/presentation/widgets/recent_actions_widget.dart, package:devkit/features/home/presentation/widgets/state_toggles_card.dart

### Community 50 - "logcat_screen.dart"
Cohesion: 0.25
Nodes (7): build, LogcatScreen, new, package:devkit/features/logcat/presentation/widgets/logcat_header_bar_widget.dart, package:devkit/features/logcat/presentation/widgets/logcat_level_filter_widget.dart, package:devkit/features/logcat/presentation/widgets/logcat_search_filter_widget.dart, package:devkit/features/logcat/presentation/widgets/logcat_stream_view_widget.dart

### Community 51 - "direct_mode_step.dart"
Cohesion: 0.25
Nodes (7): build, _buildBulletItem, DirectModeStep, new, package:devkit/features/permissions/application/permissions_cubit.dart, package:devkit/features/permissions/presentation/widgets/command_copy_box.dart, package:devkit/features/permissions/presentation/widgets/grant_status_card.dart

### Community 52 - "VoidCallback"
Cohesion: 0.33
Nodes (5): build, new, onOpenPaywallModal, ProSuiteBannerCard, VoidCallback

## Knowledge Gaps
- **392 isolated node(s):** `AppAssets`, `grid`, `_`, `AppKeys`, `hasSeenPermissionsSetup` (+387 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **3 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `DevKitDashboardCubit` connect `state_toggles_card.dart` to `basic_permissions_step.dart`, `package:flutter/material.dart`, `devkit_console_screen.dart`, `injection_container.dart`?**
  _High betweenness centrality (0.039) - this node is a cross-community bridge._
- **Why does `ConsoleStateEntity` connect `package:devkit/core/theme/app_theme.dart` to `state_toggles_card.dart`?**
  _High betweenness centrality (0.036) - this node is a cross-community bridge._
- **Why does `DeviceInfoData` connect `state_toggles_card.dart` to `bottom_navigation.dart`?**
  _High betweenness centrality (0.036) - this node is a cross-community bridge._
- **What connects `AppAssets`, `grid`, `_` to the rest of the system?**
  _392 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `app_theme.dart` be split into smaller, more focused modules?**
  _Cohesion score 0.09090909090909091 - nodes in this community are weakly interconnected._
- **Should `devkit_console_screen.dart` be split into smaller, more focused modules?**
  _Cohesion score 0.06543385490753911 - nodes in this community are weakly interconnected._
- **Should `Architecting Flutter Applications` be split into smaller, more focused modules?**
  _Cohesion score 0.11764705882352941 - nodes in this community are weakly interconnected._