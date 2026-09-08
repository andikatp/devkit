# Graph Report - devkit  (2026-09-08)

## Corpus Check
- 84 files · ~27,349 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 728 nodes · 1037 edges · 45 communities (42 shown, 3 thin omitted)
- Extraction: 100% EXTRACTED · 0% INFERRED · 0% AMBIGUOUS
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `60408df1`
- Run `git rev-parse HEAD` and compare to check if the graph is stale.
- Run `graphify update .` after code changes (no API cost).

## Community Hubs (Navigation)
- _
- devkit_nav_item.dart
- pro_paywall_sheet.dart
- Architecting Flutter Applications
- my_app.dart
- flavor_config.dart
- home_repository_impl.dart
- 1. Presentation Layer Rules
- text_theme.dart
- package:flutter_bloc/flutter_bloc.dart
- 1. Presentation Layer Refactoring
- quick_action_chip_widget.dart
- tools_screen.dart
- MainActivity
- devkit
- rules/graphify.md
- workflows/graphify.md
- devkit_dashboard_cubit.dart
- _
- devkit_console_screen.dart
- console_state_entity.dart
- paywall_tier_option_card.dart
- tool_switch_card.dart
- device_info_service.dart
- permissions_bottom_bar.dart
- permissions_setup_page.dart
- bottom_navigation.dart
- permissions_cubit.dart
- tools_cubit.dart
- home_local_data_source.dart
- permission_card.dart
- package:devkit/core/theme/app_theme.dart
- permissions_state.dart
- injection_container.dart
- grant_status_card.dart
- permissions_header_bar.dart
- console_navigation_state.dart
- StatelessWidget
- tools_repository_impl.dart
- tools_local_data_source.dart
- package:flutter/material.dart
- VoidCallback

## God Nodes (most connected - your core abstractions)
1. `_` - 23 edges
2. `DevKitDashboardCubit` - 21 edges
3. `LogcatCubit` - 19 edges
4. `PermissionsCubit` - 17 edges
5. `ToolsCubit` - 12 edges
6. `ConsoleNavigationCubit` - 11 edges
7. `PaywallCubit` - 11 edges
8. `1. Presentation Layer Rules` - 11 edges
9. `Architecting Flutter Applications` - 7 edges
10. `_` - 5 edges

## Surprising Connections (you probably didn't know these)
- `ConsoleNavigationCubit` --references--> `ConsoleNavigationState`  [EXTRACTED]
  lib/features/core/application/console_navigation_cubit.dart → lib/features/core/application/console_navigation_state.dart
- `LogcatCubit` --references--> `LogcatState`  [EXTRACTED]
  lib/features/logcat/application/logcat_cubit.dart → lib/features/logcat/application/logcat_state.dart
- `PermissionsCubit` --references--> `PermissionsState`  [EXTRACTED]
  lib/features/permissions/application/permissions_cubit.dart → lib/features/permissions/application/permissions_state.dart
- `build` --references--> `ConsoleNavigationCubit`  [EXTRACTED]
  lib/features/core/presentation/screens/devkit_console_screen.dart → lib/features/core/application/console_navigation_cubit.dart
- `_handleTabSelect` --references--> `ConsoleNavigationCubit`  [EXTRACTED]
  lib/features/core/presentation/screens/devkit_console_screen.dart → lib/features/core/application/console_navigation_cubit.dart

## Import Cycles
- None detected.

## Communities (45 total, 3 thin omitted)

### Community 0 - "_"
Cohesion: 0.10
Nodes (21): _, AppColors, AppTheme, cyanBright, cyberAmber, cyberBlack, cyberBorder, cyberCard (+13 more)

### Community 1 - "devkit_nav_item.dart"
Cohesion: 0.20
Nodes (9): build, icon, index, isActive, isPro, isProUnlocked, label, new (+1 more)

### Community 2 - "pro_paywall_sheet.dart"
Cohesion: 0.07
Nodes (34): Cubit, FocusNode, PaywallCubit, selectTier, updateCustomAmount, copyWith, customAmount, new (+26 more)

### Community 3 - "Architecting Flutter Applications"
Cohesion: 0.12
Nodes (16): Application Layer, Architecting Flutter Applications, Architectural Layers, Contents, Domain Layer, Domain Layer: Entity, Domain Layer: Repository Interface, Examples (+8 more)

### Community 4 - "my_app.dart"
Cohesion: 0.07
Nodes (26): Future, hasSeenPermissionsSetup, markPermissionsSetupSeen, SecureStorageService, _storage, build, createState, _hasSeenFuture (+18 more)

### Community 5 - "flavor_config.dart"
Cohesion: 0.13
Nodes (14): flavor, FlavorConfig, FlavorType, FlavorValues, initialize, _initialized, _instance, new (+6 more)

### Community 6 - "home_repository_impl.dart"
Cohesion: 0.20
Nodes (9): getDeviceInfo, HomeRepository, getDeviceInfo, HomeRepositoryImpl, localDataSource, new, package:devkit/core/services/device_info_service.dart, package:devkit/features/home/domain/repositories/home_repository.dart (+1 more)

### Community 7 - "1. Presentation Layer Rules"
Cohesion: 0.05
Nodes (39): 1.10 Strict One Widget Class Per File, 1.1 Native `spacing:` Parameter Over `Gap` Widgets, 1.2 Extract Event Handlers Above `build()`, 1.3 Eliminate Unnecessary Middleman Wrappers (`a -> b -> c` to `a -> c`), 1.4 Stop Prop Drilling (Read State & Encapsulate Callbacks in Child), 1.5 Standardized Bottom Sheets with Static `.show()` Pattern, 1.6 Screen File Size Limit (<250 Lines) & Inlining Simple Bodies, 1.7 Declarative Toast & Dialog Handling via `BlocListener` (+31 more)

### Community 8 - "text_theme.dart"
Cohesion: 0.09
Nodes (22): BuildContext, bodyLarge, bodyMedium, bodySmall, BuildContextExtensions, displayLarge, displayMedium, displaySmall (+14 more)

### Community 9 - "package:flutter_bloc/flutter_bloc.dart"
Cohesion: 0.07
Nodes (35): selectTab, unlockPro, LogcatCubit, build, LogcatScreen, new, build, LogcatHeaderBarWidget (+27 more)

### Community 10 - "1. Presentation Layer Refactoring"
Cohesion: 0.13
Nodes (14): 1.1 Native `spacing:` Parameter, 1.2 Handler Extraction Above `build()`, 1.3 Standardized Bottom Sheets (`*Sheet.show`), 1.4 Encapsulated Child Widgets (No Prop Drilling), 1. Presentation Layer Refactoring, 2.1 Declarative Toast & Dialog Handling via `BlocListener`, 2. Application Layer Refactoring, 3.1 Domain Entity Extensions (+6 more)

### Community 11 - "quick_action_chip_widget.dart"
Cohesion: 0.11
Nodes (17): Color, build, child, CyberGridBackground, _neonGridMatrix, new, activeColor, build (+9 more)

### Community 12 - "tools_screen.dart"
Cohesion: 0.07
Nodes (30): build, DevKitDashboardView, new, ToolsCubit, animationScale, copyWith, gpuProfiling, new (+22 more)

### Community 13 - "MainActivity"
Cohesion: 0.40
Nodes (3): MainActivity, FlutterActivity, FlutterEngine

### Community 21 - "devkit_dashboard_cubit.dart"
Cohesion: 0.20
Nodes (9): checkPermissions, homeRepository, _initDashboard, toggleAdbGrantMode, toggleDevOptions, togglePing, toggleUsbDebugging, toggleWirelessDebugging (+1 more)

### Community 22 - "_"
Cohesion: 0.38
Nodes (7): _, AppAssets, grid, _, AppKeys, hasSeenPermissionsSetup, static const String

### Community 23 - "devkit_console_screen.dart"
Cohesion: 0.05
Nodes (51): DeviceInfoData, ConsoleNavigationCubit, build, DevKitConsoleScreen, _handleTabSelect, new, _onOpenPaywallSheet, build (+43 more)

### Community 25 - "console_state_entity.dart"
Cohesion: 0.05
Nodes (38): bool get, adbConnectCommand, ConsoleStateEntity, ConsoleStateEntityX, copyWith, deviceIp, deviceModel, devicePort (+30 more)

### Community 26 - "paywall_tier_option_card.dart"
Cohesion: 0.20
Nodes (9): badgeText, build, index, isPopular, isSelected, new, onTap, subtitle (+1 more)

### Community 27 - "tool_switch_card.dart"
Cohesion: 0.22
Nodes (8): IconData, build, icon, new, onChanged, subtitle, title, value

### Community 28 - "device_info_service.dart"
Cohesion: 0.05
Nodes (36): dart:io, brand, _deviceInfoPlugin, DeviceInfoService, fallback, getDeviceInfo, ipAddress, model (+28 more)

### Community 29 - "permissions_bottom_bar.dart"
Cohesion: 0.22
Nodes (8): build, currentStep, isDirectModeGranted, new, onContinue, onFinish, onSkip, PermissionsBottomBar

### Community 30 - "permissions_setup_page.dart"
Cohesion: 0.05
Nodes (51): PermissionsCubit, build, createState, dispose, _goToStep, _handleFinish, _handleSkip, initState (+43 more)

### Community 31 - "bottom_navigation.dart"
Cohesion: 0.22
Nodes (8): build, currentIndex, DevKitBottomNavigationBar, isPro, new, onTap, package:devkit/features/core/presentation/widgets/navbar/devkit_nav_item.dart, ValueChanged

### Community 32 - "permissions_cubit.dart"
Cohesion: 0.06
Nodes (31): dart:async, clearLogs, _loadLogs, logcatRepository, selectLogLevel, updateFilter, getInitialLogs, LogcatRepository (+23 more)

### Community 33 - "tools_cubit.dart"
Cohesion: 0.17
Nodes (11): setAnimationScale, toggleGpuProfiling, toggleLayoutBounds, togglePointerLocation, toggleStrictMode, toggleTaps, toolsRepository, getInitialToolsState (+3 more)

### Community 35 - "home_local_data_source.dart"
Cohesion: 0.50
Nodes (4): getDeviceInfo, HomeLocalDataSource, HomeLocalDataSourceImpl, new

### Community 36 - "permission_card.dart"
Cohesion: 0.20
Nodes (9): build, description, footerLabel, icon, isGranted, new, onAllow, PermissionCard (+1 more)

### Community 37 - "package:devkit/core/theme/app_theme.dart"
Cohesion: 0.15
Nodes (12): build, new, build, _buildChecklistItem, new, PrerequisiteChecklistCard, build, new (+4 more)

### Community 39 - "permissions_state.dart"
Cohesion: 0.20
Nodes (9): copyWith, currentStep, isDirectModeGranted, isLocationGranted, isNearbyWifiGranted, isNotificationGranted, isVerifying, new (+1 more)

### Community 41 - "injection_container.dart"
Cohesion: 0.25
Nodes (7): GetIt, initServiceLocator, sl, package:devkit/features/home/infrastructure/repositories/home_repository_impl.dart, package:devkit/features/logcat/infrastructure/repositories/logcat_repository_impl.dart, package:devkit/features/tools/infrastructure/repositories/tools_repository_impl.dart, package:get_it/get_it.dart

### Community 42 - "grant_status_card.dart"
Cohesion: 0.29
Nodes (6): build, GrantStatusCard, isGranted, isVerifying, new, onVerify

### Community 43 - "permissions_header_bar.dart"
Cohesion: 0.29
Nodes (6): build, currentStep, new, onBack, PermissionsHeaderBar, totalSteps

### Community 44 - "console_navigation_state.dart"
Cohesion: 0.33
Nodes (5): ConsoleNavigationState, copyWith, currentNavIndex, isPro, new

### Community 45 - "StatelessWidget"
Cohesion: 0.20
Nodes (9): DevKitNavItem, build, new, PingStatusCardWidget, targetHost, MultiDeviceHelperCard, PaywallTierOptionCard, ToolSwitchCard (+1 more)

### Community 46 - "tools_repository_impl.dart"
Cohesion: 0.33
Nodes (5): getInitialToolsState, localDataSource, new, package:devkit/features/tools/domain/repositories/tools_repository.dart, package:devkit/features/tools/infrastructure/datasources/tools_local_data_source.dart

### Community 47 - "tools_local_data_source.dart"
Cohesion: 0.50
Nodes (4): getToolsState, new, ToolsLocalDataSource, ToolsLocalDataSourceImpl

### Community 48 - "package:flutter/material.dart"
Cohesion: 0.22
Nodes (7): build, new, show, SkipConfirmationDialog, initServiceLocator, main, package:flutter/material.dart

### Community 52 - "VoidCallback"
Cohesion: 0.33
Nodes (5): build, new, onOpenPaywallModal, ProSuiteBannerCard, VoidCallback

## Knowledge Gaps
- **397 isolated node(s):** `AppAssets`, `grid`, `AppKeys`, `hasSeenPermissionsSetup`, `sl` (+392 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **3 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `_` connect `_` to `package:flutter/material.dart`?**
  _High betweenness centrality (0.046) - this node is a cross-community bridge._
- **Why does `DevKitDashboardCubit` connect `devkit_console_screen.dart` to `injection_container.dart`, `pro_paywall_sheet.dart`, `devkit_dashboard_cubit.dart`?**
  _High betweenness centrality (0.038) - this node is a cross-community bridge._
- **Why does `ConsoleStateEntity` connect `console_state_entity.dart` to `devkit_console_screen.dart`?**
  _High betweenness centrality (0.036) - this node is a cross-community bridge._
- **What connects `AppAssets`, `grid`, `AppKeys` to the rest of the system?**
  _397 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `_` be split into smaller, more focused modules?**
  _Cohesion score 0.1 - nodes in this community are weakly interconnected._
- **Should `pro_paywall_sheet.dart` be split into smaller, more focused modules?**
  _Cohesion score 0.06543385490753911 - nodes in this community are weakly interconnected._
- **Should `Architecting Flutter Applications` be split into smaller, more focused modules?**
  _Cohesion score 0.11764705882352941 - nodes in this community are weakly interconnected._