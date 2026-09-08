---
trigger: always_on
description: Architectural standards, code quality rules, and refactoring guidelines for Flutter/Dart development.
---

# Master Flutter Architecture & Refactoring Rules

These rules define the required architectural patterns, code quality rules, and refactoring guidelines for Flutter applications across Presentation, Application, Domain, and Core layers.

---

## 1. Presentation Layer Rules

### 1.1 Native `spacing:` Parameter Over `Gap` Widgets
- **Rule**: Replace manual `Gap.w*` and `Gap.h*` children inside `Row` and `Column` widgets with Flutter's native `spacing:` property.
- **Exception**: `Gap` widgets (e.g. `Gap.w12`, `Gap.h16`) remain valid when used as item separators inside `ListView.separated` or custom layout builders where `spacing:` is unavailable.
- **Benefits**: Cleaner widget trees, fewer unnecessary imports (`gap.dart`), and built-in flex spacing.

#### ❌ Before:
```dart
Row(
  children: [
    const Icon(Icons.cancel_outlined, color: Colors.red, size: 20),
    Gap.w8,
    Text('Batalkan transaksi', style: context.bodyMedium),
  ],
)
```

#### ✅ After:
```dart
Row(
  spacing: 8,
  children: [
    const Icon(Icons.cancel_outlined, color: Colors.red, size: 20),
    Text('Batalkan transaksi', style: context.bodyMedium),
  ],
)
```

---

### 1.2 Extract Event Handlers Above `build()`
- **Rule**: Declare event handlers and async callbacks at the top of the widget class (above `build()`) rather than writing multi-line anonymous functions directly inside `onTap: () async { ... }` or `onPressed: () { ... }`.
- **Benefits**: Keeps UI markup clean, readable, and focused purely on widget hierarchy.

#### ❌ Before:
```dart
FilterButton(
  onTap: () async {
    await FilterCalendarSheet.show(context, ...);
    if (!context.mounted) return;
    await context.read<OrderTicketCubit>().searchTicket();
  },
)
```

#### ✅ After:
```dart
class FilterSection extends StatelessWidget {
  const FilterSection({super.key});

  Future<void> _onSelectDate(BuildContext context, OrderTicketState state) async {
    final cubit = context.read<OrderTicketCubit>();
    final initialDate = state.filter.date;
    await FilterCalendarSheet.show(context, ...);
    if (!context.mounted) return;
    if (cubit.state.filter.date != initialDate) {
      await cubit.searchTicket();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderTicketCubit, OrderTicketState>(
      builder: (context, state) {
        return FilterButton(
          onTap: () => _onSelectDate(context, state),
        );
      },
    );
  }
}
```

---

### 1.3 Eliminate Unnecessary Middleman Wrappers (`a -> b -> c` to `a -> c`)
- **Rule**: Avoid intermediate wrapper files (e.g. `DetailOrderBody`, `ChooseSeatBody`) that only pass parameters down to children without adding significant layout or state. Either inline the body directly into the parent screen if <250 lines, or render sub-components directly (`a -> c`).
- **Benefits**: Simplifies file navigation, eliminates single-use wrapper widgets, and reduces project noise.

---

### 1.4 Stop Prop Drilling (Read State & Encapsulate Callbacks in Child)
- **Rule**: Do not pass data parameters (e.g., `OrderInfo`, `Ticket`) or callbacks (`onPressed`) down through multiple constructor layers if the child widget can easily access data directly from `context.watch<Cubit>()` or self-handle its action logic.
- **Benefits**: Decouples parent widgets from child dependencies and makes components self-contained.

#### ❌ Before (Prop Drilling):
```dart
// Parent passes onPressed & state to child:
SubmitButton(
  onPressed: () {
    if (state.errorText != null) {
      Loading.toast(state.errorText!);
      return;
    }
    context.read<OrderTicketCubit>().submitOrder();
  },
)
```

#### ✅ After (Self-Encapsulated Child):
```dart
class SubmitButton extends StatelessWidget {
  const SubmitButton({this.onPressed, super.key});
  final VoidCallback? onPressed;

  void _handleSubmit(BuildContext context) {
    if (onPressed != null) {
      onPressed!();
      return;
    }
    final cubit = context.read<OrderTicketCubit>();
    if (cubit.state.errorText != null) {
      Loading.toast(cubit.state.errorText!);
      return;
    }
    cubit.submitOrder();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _handleSubmit(context),
      child: const Text('Submit'),
    );
  }
}

// Parent call site:
const SubmitButton()
```

---

### 1.5 Standardized Bottom Sheets with Static `.show()` Pattern
- **Rule**: Standardize all bottom sheet widgets to use the `*Sheet` suffix (e.g. `PassengerDetailSheet`, `FilterCalendarSheet`) and expose a static `static Future<T?> show(BuildContext context, ...)` method.
- **Benefits**: Encapsulates `showModalBottomSheet` styling, shape, background color, and `BlocProvider` injection in one place. Call sites become a single clean line.

#### ❌ Before:
```dart
showModalBottomSheet(
  context: context,
  isScrollControlled: true,
  builder: (context) => BlocProvider.value(
    value: cubit,
    child: const PassengerDetailModal(),
  ),
);
```

#### ✅ After:
```dart
class PassengerDetailSheet extends StatelessWidget {
  const PassengerDetailSheet({super.key});

  static Future<T?> show<T>(BuildContext context, {int? index}) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: context.read<OrderTicketCubit>(),
        child: PassengerDetailSheet(index: index),
      ),
    );
  }

  @override
  Widget build(BuildContext context) { ... }
}

// Call site:
PassengerDetailSheet.show(context, index: 0);
```

---

### 1.6 Screen File Size Limit (<250 Lines) & Inlining Simple Bodies
- **Rule**: Maintain screen files under **250 lines**.
- Do NOT split simple screens into separate `*_body.dart` files if the entire screen implementation fits cleanly under 250 lines.

---

### 1.7 Declarative Toast & Dialog Handling via `BlocListener`
- **Rule**: State should explicitly contain `successMessage: String?` and `errorMessage: String?`. Never call imperative toasts (`Loading.success(...)`) directly inside UI tap handlers or Cubit async methods.
- **Pattern**: Let Cubit set `successMessage`, and handle UI notifications declaratively inside `BlocListener`.

#### ✅ Example:
```dart
BlocListener<MyTicketCubit, MyTicketState>(
  listener: (context, state) {
    if (state.status == .actionLoading) {
      Loading.show();
    } else if (state.status == .actionSuccess) {
      if (state.successMessage != null) {
        Loading.success(state.successMessage!);
      } else {
        Loading.hide();
      }
    } else if (state.status == .actionError || state.status == .error) {
      Loading.error(state.errorMessage ?? 'An error occurred');
    } else {
      Loading.hide();
    }
  },
  child: ...
)
```

---

### 1.8 Dot Shorthand Syntax (Dart 3.6+)
- **Rule**: Utilize concise dot shorthand for constructors, static members, enums, `EdgeInsets`, `BorderRadius`, `CrossAxisAlignment`, `MainAxisAlignment`, and `DateTime` methods.

#### ❌ Before:
```dart
padding: const EdgeInsets.only(horizontal: 20, vertical: 16),
borderRadius: const BorderRadius.only(topLeft: Radius.circular(16)),
crossAxisAlignment: CrossAxisAlignment.start,
date: DateTime.now().formatToDayMonthYear(),
emit(state.copyWith(stateType: StateStatus.loading));
```

#### ✅ After:
```dart
padding: const .only(horizontal: 20, vertical: 16),
borderRadius: const .only(topLeft: .circular(16)),
crossAxisAlignment: .start,
date: .now().formatToDayMonthYear(),
emit(state.copyWith(stateType: .loading));
```

---

### 1.9 Separate Sub-Component Files & Group Related Widgets in Folders
- **Rule**: Every standalone widget (e.g. tooltips, card items, sub-part components) must be defined in its own separate `.dart` file rather than placed at the bottom of another widget file. Related feature sub-components must be organized in a dedicated subfolder within `presentation/widgets/` (e.g. `presentation/widgets/graphic_part/`).
- **Benefits**: Enforces clean single-responsibility files, prevents file clutter, and standardizes widget organization across the application.

#### ❌ Before:
```text
presentation/
└── widgets/
    ├── graphic_part.dart
    └── transaction_chart_part.dart  # (contains ChartTooltip class at bottom of file)
```

#### ✅ After:
```text
presentation/
└── widgets/
    └── graphic_part/
        ├── chart_tooltip.dart             # Separate file for tooltip widget
        ├── graphic_part.dart              # Main graphic section widget
        └── transaction_chart_section.dart # Dedicated chart section widget
```

---

### 1.10 Strict One Widget Class Per File
- **Rule**: Every `StatelessWidget`, `StatefulWidget`, or `ConsumerWidget` class MUST be placed in its own dedicated `.dart` file. Never declare multiple widget classes in a single file (including private `_SubWidget` classes).
- **Benefits**: Ensures clear file boundaries, simplifies code searches, improves readability, and adheres strictly to Single Responsibility Principle.

---

## 2. Application Layer Rules (Cubits / Blocs)

### 2.1 Keep Cubits Thin & Pure (Delegate to Domain Services)
- **Rule**: Cubits should only manage state transitions and coordinate repository calls. Move state calculations, list filtering, passenger object assembly, and voucher calculations into Domain Services.

### 2.2 Optimize API Calls on Filter / Value Change Only
- **Rule**: When opening modal sheets or pickers, capture the initial state parameter value before showing the sheet. Only trigger network search calls (`searchTicket()`) if the value has actually changed when the sheet closes.

### 2.3 Explicit State Notifications (`successMessage` & `errorMessage`)
- **Rule**: Maintain explicit `successMessage: String?` and `errorMessage: String?` in state so `BlocListener` can differentiate between actions that require a toast vs actions that simply refresh state silently.

### 2.4 Prompt Dead Code Cleanup
- **Rule**: Immediately delete unused functions in Cubits, unused parameters in constructor dependency injections, obsolete route constants, and unused screen files.

---

## 3. Domain Layer Rules

### 3.1 Domain Entity Extensions (`extension EntityX on Entity`)
- **Rule**: Move entity state checks, validity rules, and status getters into extension getters on domain entity classes instead of computing them inside UI widgets or Cubits.

#### ❌ Before (In UI):
```dart
final isShowButton =
    !(ticket?.expireDate?.isBefore(now) ?? false) &&
    ticket?.statusPembayaran == '0' &&
    ticket?.isBatal == '0';
```

#### ✅ After (Domain Extension):
```dart
// domain/entities/ticket_detail.dart
extension TicketDetailX on TicketDetail {
  bool get isPaid => statusPembayaran == '1' || transactionStatus == 'settlement';
  bool get isCancelled => isBatal == '1' || transactionStatus == 'cancel';
  bool get isExpired => expireDate?.isBefore(DateTime.now()) ?? false;
  bool get canPay => !isExpired && statusPembayaran == '0' && isBatal == '0';
}

// UI:
final isShowButton = ticket?.canPay ?? false;
```

---

### 3.2 Stateless Domain Services (`const ServiceName._()`)
- **Rule**: Create stateless domain services (`const ServiceName._();`) with static pure functions to handle multi-step domain transformations (e.g., `OrderInfoService`, `SeatParserService`).

#### ✅ Example:
```dart
// domain/services/order_info_service.dart
class OrderInfoService {
  const OrderInfoService._();

  static OrderInfo buildPenumpangFromSeats({
    required OrderInfo orderInfo,
    required List<BusBody> selectedSeatObjects,
    Ticket? ticket,
  }) {
    final existingPenumpangMap = <String, Penumpang>{
      for (final p in orderInfo.penumpang ?? <Penumpang>[])
        if (p.noKursi != null) p.noKursi!: p,
    };

    final newPenumpangList = selectedSeatObjects.map((item) {
      final seat = item as Seat;
      final existing = existingPenumpangMap[seat.no];
      return (existing ?? Penumpang(noKursi: seat.no)).copyWith(
        additionalPrice: seat.additionalPrice,
      );
    }).toList();

    return orderInfo.copyWith(
      ticket: ticket ?? orderInfo.ticket,
      penumpang: newPenumpangList,
    );
  }
}
```

---

## 4. Core & Extensions Layer Rules

### 4.1 String & DateTime Extensions for Formatting & Validation
- **Rule**: Move all date formatting, currency parsing, and input validation (email, NIK, phone number) to extension getters/methods in `core/extensions/`.

#### ✅ Example:
```dart
// core/extensions/string_extensions.dart
extension StringValidationX on String {
  bool get isValidEmail => RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);
  bool get isValidPhone => RegExp(r'^[0-9]{10,13}$').hasMatch(this);
  bool get isValidNIK => RegExp(r'^[0-9]{16}$').hasMatch(this);
}

// core/extensions/date_time_extensions.dart
extension DateTimeFormatX on DateTime {
  String formatToDayMonthYear() => DateFormat('dd-MM-yyyy', 'id_ID').format(this);
  String formatDateToddMMMMYYYY() => DateFormat('EEEE, d MMMM yyyy', 'id_ID').format(this);
}
```
