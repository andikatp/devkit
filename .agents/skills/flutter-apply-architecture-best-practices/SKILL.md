---
name: flutter-apply-architecture-best-practices
description: Architects a Flutter application using a Feature-First Domain-Driven Design (DDD) approach. Use when structuring a new feature or refactoring for scalability.
metadata:
  model: models/gemini-3.1-pro-preview
  last_modified: Wed, 24 Jun 2026 04:50:00 GMT
---
# Architecting Flutter Applications

## Contents
- [Architectural Layers](#architectural-layers)
- [Project Structure](#project-structure)
- [Workflow: Implementing a New Feature](#workflow-implementing-a-new-feature)
- [Examples](#examples)

## Architectural Layers

Enforce strict Separation of Concerns by dividing each feature into four distinct layers: Domain, Infrastructure, Application, and Presentation.

### Domain Layer
The innermost layer. It contains the core business logic and models. It must not depend on any other layers or external frameworks.
*   **Entities:** Core data objects. Use `@freezed` with `sealed class` and include JSON serialization (`fromJson`).
*   **Repositories (Interfaces):** Abstract definitions of data access. Methods should return a tuple of `(Failure?, Data?)`, typically aliased as `ResultFuture<T>`.
*   **Services / Params:** Complex business rules, parameter wrappers, or domain-specific services.

### Infrastructure Layer
Responsible for data access and communicating with external systems (APIs, local databases). It depends on the Domain layer.
*   **Datasources:** Define an abstract interface and an implementation class (e.g., `RemoteDataSource` and `RemoteDataSourceImpl`). Use `Dio` for API calls.
*   **Repositories (Implementations):** Implement the repository interfaces defined in the Domain layer. Wrap datasource calls using `safeApiCall` and `safeCall` to handle exceptions gracefully and return the `(Failure?, Data?)` tuple.

### Application Layer
Manages state and orchestrates the flow of data between the Presentation and Domain layers.
*   **State Management (e.g., Cubit/Bloc):** Holds the UI state, listens to user events, interacts with Domain Repositories/Services, and emits new states.

### Presentation Layer
Responsible for rendering the UI and handling user input. Depends on the Application layer for state.
*   **Screens:** Full-page UI widgets.
*   **Widgets:** Reusable UI components specific to the feature.

## Project Structure

Organize the codebase using a Feature-First Domain-Driven Design approach.

```text
lib/
├── core/                   # Shared utilities, widgets, and base classes
└── features/
    └── [feature_name]/     # Isolated feature module
        ├── application/    # State management (Cubits/Blocs, States)
        ├── domain/
        │   ├── entities/   # Business models (freezed sealed classes)
        │   ├── repositories/ # Repository interfaces (ResultFuture)
        │   └── services/   # Business logic / Params
        ├── infrastructure/
        │   ├── datasources/ # API clients (Abstract + Impl), local storage wrappers
        │   └── repositories/ # Repository implementations (safeApiCall / safeCall)
        └── presentation/
            ├── screens/    # Full pages
            └── widgets/    # Reusable feature-specific components
```

## Workflow: Implementing a New Feature

Follow this sequential workflow when adding a new feature to the application. Copy the checklist to track progress.

### Task Progress
- [ ] **Step 1: Define Domain Entities.** Create `entities` using `@freezed` and `sealed class` inside `domain/entities/`.
- [ ] **Step 2: Define Domain Repositories.** Create `repositories` (interfaces returning `ResultFuture`) inside `domain/repositories/`.
- [ ] **Step 3: Implement Infrastructure Datasources.** Create `datasources` (Abstract class and Impl) to handle external API communication inside `infrastructure/datasources/`.
- [ ] **Step 4: Implement Infrastructure Repositories.** Create repository implementations inside `infrastructure/repositories/` that consume datasources. Use `safeApiCall` and `safeCall` for error handling.
- [ ] **Step 5: Implement Application Layer.** Create state management (e.g., Cubit) inside `application/`. Inject required Domain Repositories. Expose state and handle user interactions.
- [ ] **Step 6: Implement Presentation Layer.** Create `screens` and `widgets` inside `presentation/`. Use `BlocBuilder` or similar to listen to state changes from the Application layer.
- [ ] **Step 7: Inject Dependencies.** Register the new datasources, repositories, and Cubits in the dependency injection container (e.g., `get_it`).
- [ ] **Step 8: Run Validator.** Execute unit tests for the Application and Infrastructure layers.

## Examples

### Domain Layer: Entity

```dart
// domain/entities/user_entity.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';
part 'user_entity.g.dart';

@freezed
sealed class UserEntity with _$UserEntity {
  const factory UserEntity({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'name') String? name,
  }) = _UserEntity;

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);
}
```

### Infrastructure Layer: Datasource (Abstract & Impl)

```dart
// infrastructure/datasources/user_remote_data_source.dart
import 'package:dio/dio.dart';
// import domain entities...

abstract class UserRemoteDataSource {
  const UserRemoteDataSource();
  Future<UserEntity> getUser(String id);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  const UserRemoteDataSourceImpl({
    required Dio dio,
  }) : _dio = dio;
  
  final Dio _dio;

  @override
  Future<UserEntity> getUser(String id) async {
    final response = await _dio.get<Map<String, dynamic>>('/users/$id');
    return UserEntity.fromJson(response.data!['data'] as Map<String, dynamic>);
  }
}
```

### Domain Layer: Repository Interface

```dart
// domain/repositories/user_repository.dart
// import core typedefs e.g., ResultFuture
// import entities...

abstract class UserRepository {
  ResultFuture<UserEntity> getUser(String id);
}
```

### Infrastructure Layer: Repository Implementation (with safeApiCall)

```dart
// infrastructure/repositories/user_repository_impl.dart
// import core utils...
// import domain interfaces and infrastructure datasources...

class UserRepositoryImpl implements UserRepository {
  const UserRepositoryImpl({
    required UserRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  final UserRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<UserEntity> getUser(String id) async {
    final result = await safeApiCall(
      () async => _remoteDataSource.getUser(id),
    );
    
    if (result.isFailure) {
      return (result.failure, null);
    }
    
    return (null, result.data);
  }
}
```
