# Graph Report - devkit  (2026-09-08)

## Corpus Check
- 67 files · ~23,687 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 565 nodes · 771 edges · 39 communities (35 shown, 4 thin omitted)
- Extraction: 100% EXTRACTED · 0% INFERRED · 0% AMBIGUOUS
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `b2e94b74`
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

## God Nodes (most connected - your core abstractions)
1. `LogcatCubit` - 18 edges
2. `DevKitDashboardCubit` - 17 edges
3. `ConsoleNavigationCubit` - 11 edges
4. `PaywallCubit` - 11 edges
5. `ToolsCubit` - 11 edges
6. `1. Presentation Layer Rules` - 11 edges
7. `Architecting Flutter Applications` - 7 edges
8. `Master Flutter Architecture & Refactoring Rules` - 5 edges
9. `2. Application Layer Rules (Cubits / Blocs)` - 5 edges
10. `Architectural Layers` - 5 edges

## Surprising Connections (you probably didn't know these)
- `LogcatCubit` --references--> `LogcatState`  [EXTRACTED]
  lib/features/logcat/application/logcat_cubit.dart → lib/features/logcat/application/logcat_state.dart
- `ConsoleNavigationCubit` --references--> `ConsoleNavigationState`  [EXTRACTED]
  lib/features/core/application/console_navigation_cubit.dart → lib/features/core/application/console_navigation_state.dart
- `build` --references--> `ConsoleNavigationCubit`  [EXTRACTED]
  lib/features/core/presentation/screens/devkit_console_screen.dart → lib/features/core/application/console_navigation_cubit.dart
- `DevKitConsoleScreen` --references--> `ConsoleNavigationCubit`  [EXTRACTED]
  lib/features/core/presentation/screens/devkit_console_screen.dart → lib/features/core/application/console_navigation_cubit.dart
- `_handleTabSelect` --references--> `ConsoleNavigationCubit`  [EXTRACTED]
  lib/features/core/presentation/screens/devkit_console_screen.dart → lib/features/core/application/console_navigation_cubit.dart

## Import Cycles
- None detected.

## Communities (39 total, 4 thin omitted)

### Community 0 - "app_theme.dart"
Cohesion: 0.09
Nodes (21): AppColors, AppTheme, cyanBright, cyberAmber, cyberBlack, cyberBorder, cyberCard, cyberCardAlt (+13 more)

### Community 1 - "header_widget.dart"
Cohesion: 0.20
Nodes (9): build, icon, index, isActive, isPro, isProUnlocked, label, new (+1 more)

### Community 2 - "devkit_console_screen.dart"
Cohesion: 0.07
Nodes (33): Cubit, FocusNode, PaywallCubit, selectTier, updateCustomAmount, copyWith, customAmount, new (+25 more)

### Community 3 - "Architecting Flutter Applications"
Cohesion: 0.12
Nodes (16): Application Layer, Architecting Flutter Applications, Architectural Layers, Contents, Domain Layer, Domain Layer: Entity, Domain Layer: Repository Interface, Examples (+8 more)

### Community 4 - "logcat_modal.dart"
Cohesion: 0.08
Nodes (24): build, DevKitDashboardView, new, build, LogcatScreen, new, initServiceLocator, main (+16 more)

### Community 5 - "flavor_config.dart"
Cohesion: 0.13
Nodes (14): flavor, FlavorConfig, FlavorType, FlavorValues, initialize, _initialized, _instance, new (+6 more)

### Community 6 - "connect_command_card.dart"
Cohesion: 0.10
Nodes (20): setAnimationScale, toggleGpuProfiling, toggleLayoutBounds, togglePointerLocation, toggleStrictMode, toggleTaps, toolsRepository, getInitialToolsState (+12 more)

### Community 7 - "console_state_entity.dart"
Cohesion: 0.05
Nodes (39): 1.10 Strict One Widget Class Per File, 1.1 Native `spacing:` Parameter Over `Gap` Widgets, 1.2 Extract Event Handlers Above `build()`, 1.3 Eliminate Unnecessary Middleman Wrappers (`a -> b -> c` to `a -> c`), 1.4 Stop Prop Drilling (Read State & Encapsulate Callbacks in Child), 1.5 Standardized Bottom Sheets with Static `.show()` Pattern, 1.6 Screen File Size Limit (<250 Lines) & Inlining Simple Bodies, 1.7 Declarative Toast & Dialog Handling via `BlocListener` (+31 more)

### Community 8 - "logcat_log_entity.dart"
Cohesion: 0.09
Nodes (22): BuildContext, bodyLarge, bodyMedium, bodySmall, BuildContextExtensions, displayLarge, displayMedium, displaySmall (+14 more)

### Community 9 - "state_toggles_card.dart"
Cohesion: 0.09
Nodes (28): selectTab, unlockPro, LogcatCubit, build, LogcatHeaderBarWidget, new, _onClearLogs, build (+20 more)

### Community 10 - "pro_paywall_modal.dart"
Cohesion: 0.13
Nodes (14): 1.1 Native `spacing:` Parameter, 1.2 Handler Extraction Above `build()`, 1.3 Standardized Bottom Sheets (`*Sheet.show`), 1.4 Encapsulated Child Widgets (No Prop Drilling), 1. Presentation Layer Refactoring, 2.1 Declarative Toast & Dialog Handling via `BlocListener`, 2. Application Layer Refactoring, 3.1 Domain Entity Extensions (+6 more)

### Community 11 - "package:flutter/material.dart"
Cohesion: 0.22
Nodes (8): build, child, CyberGridBackground, _neonGridMatrix, new, package:devkit/core/constant/app_assets.dart, static const ColorFilter, Widget

### Community 12 - "tools_screen_content_widget.dart"
Cohesion: 0.10
Nodes (23): ToolsCubit, animationScale, copyWith, gpuProfiling, new, showLayoutBounds, showPointerLocation, showTaps (+15 more)

### Community 20 - "tools_screen.dart"
Cohesion: 0.09
Nodes (22): bool get, copyWith, filterQuery, LogcatState, logs, new, selectedLevel, fullText (+14 more)

### Community 21 - "injection_container.dart"
Cohesion: 0.15
Nodes (12): GetIt, initServiceLocator, sl, getInitialLogs, localDataSource, new, package:devkit/features/home/infrastructure/repositories/home_repository_impl.dart, package:devkit/features/logcat/domain/repositories/logcat_repository.dart (+4 more)

### Community 22 - "app_assets.dart"
Cohesion: 0.40
Nodes (4): AppAssets, grid, _, static const String

### Community 23 - "state_toggles_card.dart"
Cohesion: 0.05
Nodes (46): ConsoleNavigationCubit, ConsoleNavigationState, copyWith, currentNavIndex, isPro, new, build, _handleTabSelect (+38 more)

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
Cohesion: 0.29
Nodes (6): build, new, onOpenPaywallModal, ProSuiteBannerCard, package:glow_container/glow_container.dart, VoidCallback

### Community 30 - "StatelessWidget"
Cohesion: 0.33
Nodes (6): DevKitConsoleScreen, DevKitNavItem, QuickActionChipWidget, PaywallTierOptionCard, ToolSwitchCard, StatelessWidget

### Community 31 - "bottom_navigation.dart"
Cohesion: 0.22
Nodes (8): build, currentIndex, DevKitBottomNavigationBar, isPro, new, onTap, package:devkit/features/core/presentation/widgets/navbar/devkit_nav_item.dart, ValueChanged

### Community 32 - "logcat_cubit.dart"
Cohesion: 0.17
Nodes (11): dart:async, clearLogs, _loadLogs, logcatRepository, selectLogLevel, updateFilter, getInitialLogs, LogcatRepository (+3 more)

### Community 33 - "home_repository_impl.dart"
Cohesion: 0.20
Nodes (9): getDeviceInfo, HomeRepository, getDeviceInfo, HomeRepositoryImpl, localDataSource, new, package:devkit/core/services/device_info_service.dart, package:devkit/features/home/domain/repositories/home_repository.dart (+1 more)

### Community 34 - "package:flutter/material.dart"
Cohesion: 0.22
Nodes (8): build, MyApp, new, build, new, ToolsHeaderBarWidget, package:devkit/core/theme/app_theme.dart, package:flutter/material.dart

### Community 35 - "devkit_dashboard_cubit.dart"
Cohesion: 0.22
Nodes (8): homeRepository, _initDeviceInfo, toggleAdbGrantMode, toggleDevOptions, togglePing, toggleUsbDebugging, toggleWirelessDebugging, package:devkit/features/home/application/devkit_dashboard_state.dart

### Community 36 - "home_local_data_source.dart"
Cohesion: 0.50
Nodes (4): getDeviceInfo, HomeLocalDataSource, HomeLocalDataSourceImpl, new

### Community 37 - "package:devkit/core/theme/app_theme.dart"
Cohesion: 0.33
Nodes (5): build, new, PingStatusCardWidget, targetHost, package:devkit/core/extensions/text_theme.dart

### Community 38 - "logcat_local_data_source.dart"
Cohesion: 0.50
Nodes (4): getLogs, LogcatLocalDataSource, LogcatLocalDataSourceImpl, new

## Knowledge Gaps
- **303 isolated node(s):** `AppAssets`, `grid`, `_`, `sl`, `initServiceLocator` (+298 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **4 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `ConsoleStateEntity` connect `package:devkit/core/theme/app_theme.dart` to `state_toggles_card.dart`?**
  _High betweenness centrality (0.043) - this node is a cross-community bridge._
- **What connects `AppAssets`, `grid`, `_` to the rest of the system?**
  _303 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `app_theme.dart` be split into smaller, more focused modules?**
  _Cohesion score 0.09090909090909091 - nodes in this community are weakly interconnected._
- **Should `devkit_console_screen.dart` be split into smaller, more focused modules?**
  _Cohesion score 0.06756756756756757 - nodes in this community are weakly interconnected._
- **Should `Architecting Flutter Applications` be split into smaller, more focused modules?**
  _Cohesion score 0.11764705882352941 - nodes in this community are weakly interconnected._
- **Should `logcat_modal.dart` be split into smaller, more focused modules?**
  _Cohesion score 0.07881773399014778 - nodes in this community are weakly interconnected._
- **Should `flavor_config.dart` be split into smaller, more focused modules?**
  _Cohesion score 0.13333333333333333 - nodes in this community are weakly interconnected._