# Graph Report - devkit  (2026-09-07)

## Corpus Check
- 65 files · ~22,827 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 535 nodes · 729 edges · 40 communities (36 shown, 4 thin omitted)
- Extraction: 100% EXTRACTED · 0% INFERRED · 0% AMBIGUOUS
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `020a386e`
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
- Master Flutter Architecture & Refactoring Guide
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
- logcat_repository_impl.dart
- injection_container.dart
- devkit_dashboard_cubit.dart
- package:devkit/core/theme/app_theme.dart
- home_local_data_source.dart
- package:devkit/core/extensions/text_theme.dart

## God Nodes (most connected - your core abstractions)
1. `DevKitDashboardCubit` - 17 edges
2. `LogcatCubit` - 17 edges
3. `ConsoleNavigationCubit` - 11 edges
4. `1. Presentation Layer Rules` - 11 edges
5. `ToolsCubit` - 10 edges
6. `PaywallCubit` - 8 edges
7. `Architecting Flutter Applications` - 6 edges
8. `Master Flutter Architecture & Refactoring Guide` - 6 edges
9. `Architectural Layers` - 5 edges
10. `Examples` - 5 edges

## Surprising Connections (you probably didn't know these)
- `LogcatCubit` --references--> `LogcatState`  [EXTRACTED]
  lib/features/logcat/application/logcat_cubit.dart → lib/features/logcat/application/logcat_state.dart
- `ConsoleNavigationCubit` --references--> `ConsoleNavigationState`  [EXTRACTED]
  lib/features/core/application/console_navigation_cubit.dart → lib/features/core/application/console_navigation_state.dart
- `build` --references--> `ConsoleNavigationCubit`  [EXTRACTED]
  lib/features/core/presentation/screens/devkit_console_screen.dart → lib/features/core/application/console_navigation_cubit.dart
- `_handleTabSelect` --references--> `ConsoleNavigationCubit`  [EXTRACTED]
  lib/features/core/presentation/screens/devkit_console_screen.dart → lib/features/core/application/console_navigation_cubit.dart
- `_onOpenLogcat` --references--> `ConsoleNavigationCubit`  [EXTRACTED]
  lib/features/home/presentation/widgets/recent_actions_widget.dart → lib/features/core/application/console_navigation_cubit.dart

## Import Cycles
- None detected.

## Communities (40 total, 4 thin omitted)

### Community 0 - "app_theme.dart"
Cohesion: 0.09
Nodes (21): AppColors, AppTheme, cyanBright, cyberAmber, cyberBlack, cyberBorder, cyberCard, cyberCardAlt (+13 more)

### Community 1 - "header_widget.dart"
Cohesion: 0.20
Nodes (9): build, icon, index, isActive, isPro, isProUnlocked, label, new (+1 more)

### Community 2 - "devkit_console_screen.dart"
Cohesion: 0.08
Nodes (26): Cubit, FocusNode, PaywallCubit, selectTier, updateCustomAmount, copyWith, customAmount, new (+18 more)

### Community 3 - "Architecting Flutter Applications"
Cohesion: 0.12
Nodes (15): Application Layer, Architecting Flutter Applications, Architectural Layers, Contents, Domain Layer, Domain Layer: Entity, Domain Layer: Repository Interface, Examples (+7 more)

### Community 4 - "logcat_modal.dart"
Cohesion: 0.19
Nodes (10): initServiceLocator, main, initServiceLocator, main, package:devkit/core/di/injection_container.dart, package:devkit/core/flavors/flavor_config.dart, package:devkit/features/core/presentation/screens/devkit_console_screen.dart, package:devkit/features/core/presentation/screens/my_app.dart (+2 more)

### Community 5 - "flavor_config.dart"
Cohesion: 0.13
Nodes (14): flavor, FlavorConfig, FlavorType, FlavorValues, initialize, _initialized, _instance, new (+6 more)

### Community 6 - "connect_command_card.dart"
Cohesion: 0.17
Nodes (11): setAnimationScale, toggleGpuProfiling, toggleLayoutBounds, togglePointerLocation, toggleStrictMode, toggleTaps, toolsRepository, getInitialToolsState (+3 more)

### Community 7 - "console_state_entity.dart"
Cohesion: 0.10
Nodes (18): copyWith, filterQuery, LogcatState, logs, new, selectedLevel, fullText, level (+10 more)

### Community 8 - "logcat_log_entity.dart"
Cohesion: 0.09
Nodes (22): BuildContext, bodyLarge, bodyMedium, bodySmall, BuildContextExtensions, displayLarge, displayMedium, displaySmall (+14 more)

### Community 9 - "state_toggles_card.dart"
Cohesion: 0.07
Nodes (34): selectTab, unlockPro, LogcatCubit, build, LogcatScreen, new, build, LogcatHeaderBarWidget (+26 more)

### Community 10 - "pro_paywall_modal.dart"
Cohesion: 0.08
Nodes (24): 1.10 Strict One Widget Class Per File, 1.1 Native `spacing:` Parameter Over `Gap` Widgets, 1.2 Extract Event Handlers Above `build()`, 1.3 Eliminate Unnecessary Middleman Wrappers (`a -> b -> c` to `a -> c`), 1.4 Stop Prop Drilling (Read State & Encapsulate Callbacks in Child), 1.5 Standardized Bottom Sheets with Static `.show()` Pattern, 1.6 Screen File Size Limit (<250 Lines) & Inlining Simple Bodies, 1.7 Declarative Toast & Dialog Handling via `BlocListener` (+16 more)

### Community 11 - "package:flutter/material.dart"
Cohesion: 0.22
Nodes (8): build, child, CyberGridBackground, _neonGridMatrix, new, package:devkit/core/constant/app_assets.dart, static const ColorFilter, Widget

### Community 12 - "tools_screen_content_widget.dart"
Cohesion: 0.10
Nodes (22): ToolsCubit, animationScale, copyWith, gpuProfiling, new, showLayoutBounds, showPointerLocation, showTaps (+14 more)

### Community 20 - "tools_screen.dart"
Cohesion: 0.11
Nodes (19): ConsoleNavigationCubit, ConsoleNavigationState, copyWith, currentNavIndex, isPro, new, build, DevKitConsoleScreen (+11 more)

### Community 21 - "Master Flutter Architecture & Refactoring Guide"
Cohesion: 0.12
Nodes (16): 2.1 Keep Cubits Thin & Pure (Delegate to Domain Services), 2.2 Optimize API Calls on Filter / Value Change Only, 2.3 Explicit State Notifications (`successMessage` & `errorMessage`), 2.4 Prompt Dead Code Cleanup, 2. Application Layer Rules (Cubits / Blocs), 3.1 Domain Entity Extensions (`extension EntityX on Entity`), 3.2 Stateless Domain Services (`const ServiceName._()`), 3. Domain Layer Rules (+8 more)

### Community 22 - "app_assets.dart"
Cohesion: 0.40
Nodes (4): AppAssets, grid, _, static const String

### Community 23 - "state_toggles_card.dart"
Cohesion: 0.07
Nodes (35): DevKitDashboardCubit, consoleState, copyWith, DevKitDashboardState, new, build, DevKitDashboardView, new (+27 more)

### Community 24 - "device_info_service.dart"
Cohesion: 0.07
Nodes (29): dart:io, Future, brand, DeviceInfoData, _deviceInfoPlugin, DeviceInfoService, fallback, getDeviceInfo (+21 more)

### Community 25 - "package:devkit/core/theme/app_theme.dart"
Cohesion: 0.12
Nodes (16): adbConnectCommand, ConsoleStateEntity, ConsoleStateEntityX, copyWith, deviceIp, deviceModel, devicePort, footnoteText (+8 more)

### Community 26 - "paywall_tier_option_card.dart"
Cohesion: 0.20
Nodes (9): badgeText, build, index, isPopular, isSelected, new, onTap, subtitle (+1 more)

### Community 27 - "tool_switch_card.dart"
Cohesion: 0.22
Nodes (8): IconData, build, icon, new, onChanged, subtitle, title, value

### Community 28 - "bottom_navigation.dart"
Cohesion: 0.22
Nodes (8): Color, activeColor, build, icon, isSelected, label, new, onTap

### Community 29 - "pro_suite_banner_card.dart"
Cohesion: 0.33
Nodes (5): build, new, onOpenPaywallModal, ProSuiteBannerCard, VoidCallback

### Community 30 - "StatelessWidget"
Cohesion: 0.33
Nodes (6): DevKitNavItem, PingStatusCardWidget, QuickActionChipWidget, PaywallTierOptionCard, ToolSwitchCard, StatelessWidget

### Community 31 - "bottom_navigation.dart"
Cohesion: 0.22
Nodes (8): build, currentIndex, DevKitBottomNavigationBar, isPro, new, onTap, package:devkit/features/core/presentation/widgets/navbar/devkit_nav_item.dart, ValueChanged

### Community 32 - "logcat_cubit.dart"
Cohesion: 0.10
Nodes (20): dart:async, clearLogs, _loadLogs, logcatRepository, selectLogLevel, updateFilter, getInitialLogs, LogcatRepository (+12 more)

### Community 33 - "home_repository_impl.dart"
Cohesion: 0.20
Nodes (9): getDeviceInfo, HomeRepository, getDeviceInfo, HomeRepositoryImpl, localDataSource, new, package:devkit/core/services/device_info_service.dart, package:devkit/features/home/domain/repositories/home_repository.dart (+1 more)

### Community 34 - "logcat_repository_impl.dart"
Cohesion: 0.33
Nodes (5): getInitialToolsState, localDataSource, new, package:devkit/features/tools/domain/repositories/tools_repository.dart, package:devkit/features/tools/infrastructure/datasources/tools_local_data_source.dart

### Community 35 - "injection_container.dart"
Cohesion: 0.25
Nodes (7): GetIt, initServiceLocator, sl, package:devkit/features/home/infrastructure/repositories/home_repository_impl.dart, package:devkit/features/logcat/infrastructure/repositories/logcat_repository_impl.dart, package:devkit/features/tools/infrastructure/repositories/tools_repository_impl.dart, package:get_it/get_it.dart

### Community 36 - "devkit_dashboard_cubit.dart"
Cohesion: 0.22
Nodes (8): homeRepository, _initDeviceInfo, toggleAdbGrantMode, toggleDevOptions, togglePing, toggleUsbDebugging, toggleWirelessDebugging, package:devkit/features/home/application/devkit_dashboard_state.dart

### Community 37 - "package:devkit/core/theme/app_theme.dart"
Cohesion: 0.16
Nodes (12): build, MyApp, new, build, new, targetHost, build, new (+4 more)

### Community 38 - "home_local_data_source.dart"
Cohesion: 0.50
Nodes (4): getDeviceInfo, HomeLocalDataSource, HomeLocalDataSourceImpl, new

### Community 39 - "package:devkit/core/extensions/text_theme.dart"
Cohesion: 0.50
Nodes (4): getToolsState, new, ToolsLocalDataSource, ToolsLocalDataSourceImpl

## Knowledge Gaps
- **288 isolated node(s):** `AppAssets`, `grid`, `_`, `sl`, `initServiceLocator` (+283 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **4 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `ConsoleStateEntity` connect `package:devkit/core/theme/app_theme.dart` to `state_toggles_card.dart`?**
  _High betweenness centrality (0.047) - this node is a cross-community bridge._
- **Why does `ToolsCubit` connect `tools_screen_content_widget.dart` to `devkit_console_screen.dart`, `injection_container.dart`, `connect_command_card.dart`?**
  _High betweenness centrality (0.043) - this node is a cross-community bridge._
- **What connects `AppAssets`, `grid`, `_` to the rest of the system?**
  _288 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `app_theme.dart` be split into smaller, more focused modules?**
  _Cohesion score 0.09090909090909091 - nodes in this community are weakly interconnected._
- **Should `devkit_console_screen.dart` be split into smaller, more focused modules?**
  _Cohesion score 0.07881773399014778 - nodes in this community are weakly interconnected._
- **Should `Architecting Flutter Applications` be split into smaller, more focused modules?**
  _Cohesion score 0.125 - nodes in this community are weakly interconnected._
- **Should `flavor_config.dart` be split into smaller, more focused modules?**
  _Cohesion score 0.13333333333333333 - nodes in this community are weakly interconnected._