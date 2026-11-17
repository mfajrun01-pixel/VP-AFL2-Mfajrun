# 📱 TodoVault — Modern Flutter Todo Application

**AFL Production-Ready Flutter Application**  
**Course:** Visual Programming · Module — Clean Architecture & MVVM  
**Domain Track:** Track A — Personal Task & Productivity Tracker

---

## 📦 Release APK

Kamu bisa langsung mengunduh aplikasinya melalui tautan berikut: [](#) *(atau arahkan ke link GitHub Releases kamu)*

---

## 📖 Case Study Overview

**TodoVault** is a modern, responsive Flutter application designed for users to organize, track, and manage their daily tasks efficiently. Users can catalog tasks, manage completion status (*Active, Completed, All*), filter tasks dynamically, and persist data seamlessly using local storage (*SharedPreferences* with local asset fallback).

---

## ✨ Features Implemented

1. **Multi-Screen Navigation & CRUD Workflow:**
    * **TodoListScreen:** Main dashboard featuring a search bar, status filters (*All, Active, Completed*), and responsive task cards with instant check/uncheck and delete actions.
    * **TodoFormScreen:** Interactive Form with title validation, description input, and safe data persistence.

2. **Material Design 3 & Typography:**
    * Centralized `AppTheme` with clean component styling.
    * Dynamic Light and Dark Mode support (`ThemeMode.system`).
    * Clean touch targets complying with Material 3 guidelines.

3. **Clean Architecture & MVVM Separation:**
    * **Domain Layer:** Pure `Todo` entities and abstract repository contracts ensuring independent business rules.
    * **Data Layer:** Robust `TodoStorageService` handling `SharedPreferences` & local JSON assets, coupled with `TodoRepositoryImpl`.
    * **Presentation Layer:** Reactive `TodoListViewModel` and `TodoFormViewModel` utilizing `ChangeNotifier` and `Equatable` for smooth state rendering.

4. **Responsiveness & Data Safety:**
    * Safe null-safety fallback parsing preventing runtime crashes on empty or corrupted storage states.
    * Optimized state management to prevent unnecessary widget rebuilds during *checklist* interactions.

---

## 📁 Project Architecture

Follows a strict **Clean Architecture & MVVM Pattern**:

* `lib/core/`: Shared infrastructure (Centralized Material 3 `AppTheme`).
* `lib/data/`: Data models, repository implementations, and storage services (`SharedPreferences`).
* `lib/domain/`: Pure entities and abstract repository contracts.
* `lib/viewmodels/`: Presentation state logic (`TodoListViewModel`, `TodoFormViewModel`).
* `lib/views/` & `widgets/`: UI screens and modular components.
* `docs/structure.md`: Detailed architectural breakdown of directories and layer separation.

---

## 🚀 Setup & Execution Instructions

### Prerequisites
* Flutter SDK $\ge$ 3.22$
* Dart SDK $\ge$ 3.4$
* Android Studio / VS Code

### Running the App

1. Clone this repository:
   ```bash
   git clone [https://github.com/username/todolist.git](https://github.com/username/todolist.git)
   cd todolist