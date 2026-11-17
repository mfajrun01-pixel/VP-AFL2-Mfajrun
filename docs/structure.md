---

### **`docs/structure.md`**
## 📁 Struktur Direktori Proyek (`lib/`)

```text
lib/
│
├── core/                  # Pengaturan global aplikasi (Tema, warna, utilitas)
│   └── theme/
│       └── app_theme.dart
│
├── data/                  # Lapisan Luar (Data Layer & External Services)
│   ├── models/            # Penerjemah data mentah JSON <-> Objek Model
│   ├── repositories/      # Implementasi nyata dari kontrak Domain repository
│   └── services/          # Akses penyimpanan fisik (SharedPreferences & Local Assets)
│
├── domain/                # Lapisan Inti / Paling Dalam (Domain Layer)
│   ├── entities/          # Objek data murni (Pure business models/entities)
│   └── repositories/      # Kontrak abstrak / Blueprint fungsi repository
│
├── viewmodels/            # Lapisan Presentasi Logika (ViewModel & State Management)
│   ├── todo_form_viewmodel.dart
│   └── todo_list_viewmodel.dart
│
├── views/ & widgets/      # Lapisan Antarmuka Pengguna (UI & Screen Views)
│   ├── todo_form_screen.dart
│   └── todo_list_screen.dart
│
└── main.dart              # Titik masuk utama aplikasi (Entry Point)