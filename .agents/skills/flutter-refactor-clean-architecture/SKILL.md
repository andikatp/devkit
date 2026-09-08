---
name: flutter-refactor-clean-architecture
description: Refactors Flutter codebases according to Clean Architecture, Cubit state management, Domain Services, Entity Extensions, and Presentation Layer guidelines. Use when reviewing code, refactoring existing widgets/cubits/entities, or enforcing project coding standards.
---

# Refactoring Flutter Applications to Clean Architecture

Use this skill when refactoring an existing Flutter codebase or feature to comply with Clean Architecture guidelines, code quality rules, and component modularity standards.

---

## Refactoring Workflow Checklist

Copy and use this checklist when performing refactoring passes:

- [ ] **Phase 1: Presentation Layer Refactoring**
  - [ ] **Native Spacing**: Replace `Gap.w*` and `Gap.h*` inside `Row` and `Column` with `spacing: double`.
  - [ ] **Event Handler Extraction**: Move multi-line anonymous functions out of `onTap`/`onPressed` to top of class (above `build()`).
  - [ ] **Middleman Removal**: Eliminate wrapper classes (`DetailOrderBody`, etc.) that only forward parameters. Inline or connect directly (`a -> c`).
  - [ ] **Eliminate Prop Drilling**: Replace passed callbacks/entities in child constructors by reading state directly (`context.watch<Cubit>()`) or encapsulating logic inside child.
  - [ ] **Standardize Bottom Sheets**: Suffix sheets with `*Sheet` and expose `static Future<T?> show(BuildContext context, ...)`.
  - [ ] **Screen File Limits**: Enforce screen size < 250 lines. Inline simple bodies directly into the screen file.
  - [ ] **Declarative Notifications**: Handle toasts/dialogs via `BlocListener` listening to `successMessage` and `errorMessage` states.
  - [ ] **Dot Shorthand Syntax**: Adopt concise `.only(...)`, `.circular(...)`, `.start`, `.now()` dot shorthand (Dart 3.6+).
  - [ ] **One Widget Class Per File**: Extract all private sub-widgets (`_SubWidget`) and inline classes to separate files in dedicated folders (`presentation/widgets/[feature_part]/`).

- [ ] **Phase 2: Application Layer (Cubit/Bloc) Refactoring**
  - [ ] **Thin Cubits**: Extract complex data transformation, filtering, or list mapping into Domain Services.
  - [ ] **Conditional API Triggers**: Check if state parameter values actually changed before firing search/network calls after modal close.
  - [ ] **Explicit State Messages**: Include `successMessage: String?` and `errorMessage: String?` fields in the state object.
  - [ ] **Dead Code Cleanup**: Remove unused functions, DI parameters, obsolete routes, and unreferenced screen files.

- [ ] **Phase 3: Domain Layer Refactoring**
  - [ ] **Entity Extension Getters**: Move business checks (`isPaid`, `isExpired`, `canPay`) into `extension EntityX on Entity`.
  - [ ] **Stateless Domain Services**: Group multi-step entity/model transformation logic into static methods inside `const ServiceName._()`.

- [ ] **Phase 4: Core & Extensions Layer Refactoring**
  - [ ] **Utility Extensions**: Move date formatting, currency parsing, and String validation (email, NIK, phone) to `core/extensions/`.

---

## Layer-by-Layer Refactoring Guidelines & Examples

### 1. Presentation Layer Refactoring

#### 1.1 Native `spacing:` Parameter
```dart
// ❌ Before
Column(
  children: [
    HeaderWidget(),
    Gap.h16,
    ContentWidget(),
  ],
)

// ✅ After
Column(
  spacing: 16,
  children: [
    HeaderWidget(),
    ContentWidget(),
  ],
)
```

#### 1.2 Handler Extraction Above `build()`
```dart
// ✅ Extract handlers to methods above build()
class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  Future<void> _handleFilterTap(BuildContext context) async {
    final cubit = context.read<OrderCubit>();
    final date = await DatePickerSheet.show(context);
    if (date != null && context.mounted) {
      await cubit.updateDate(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FilterButton(onTap: () => _handleFilterTap(context));
  }
}
```

#### 1.3 Standardized Bottom Sheets (`*Sheet.show`)
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
  Widget build(BuildContext context) {
    return Container(/* UI implementation */);
  }
}
```

#### 1.4 Encapsulated Child Widgets (No Prop Drilling)
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
```

---

### 2. Application Layer Refactoring

#### 2.1 Declarative Toast & Dialog Handling via `BlocListener`
```dart
BlocListener<OrderCubit, OrderState>(
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
  child: const OrderView(),
)
```

---

### 3. Domain Layer Refactoring

#### 3.1 Domain Entity Extensions
```dart
// domain/entities/ticket_detail.dart
extension TicketDetailX on TicketDetail {
  bool get isPaid => statusPembayaran == '1' || transactionStatus == 'settlement';
  bool get isCancelled => isBatal == '1' || transactionStatus == 'cancel';
  bool get isExpired => expireDate?.isBefore(DateTime.now()) ?? false;
  bool get canPay => !isExpired && statusPembayaran == '0' && isBatal == '0';
}
```

#### 3.2 Stateless Domain Services
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

### 4. Core Extensions Layer Refactoring

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
