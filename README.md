
# DogLand
Technical Test for iOS Developer role on Konfio

---

# 🧠 Arquitectura y Estructura del Proyecto

El proyecto **DogLand** ha sido diseñado siguiendo los principios de **Clean Architecture** junto con el patrón **MVVM (Model-View-ViewModel)**, promoviendo una separación clara de responsabilidades, facilidad de testeo, y mantenimiento a largo plazo.

---

## 🧱 Arquitectura General

### 1. Presentation Layer (`Presentation/`)
Contiene toda la lógica relacionada con la interfaz de usuario usando **SwiftUI**:
- `DogListView` representa la lista principal de perros.
- `DogRowView` es la celda visual personalizada.
- `DogListViewModel` maneja la lógica de presentación, encapsulando la interacción con el dominio.
- Se usa `@MainActor`, `@StateObject`, y `async/await` para manejar concurrencia y estado.

### 2. Domain Layer (`Domain/`)
Esta capa contiene la lógica de negocio **pura**:
- `Dog`: entidad principal del dominio.
- `DogRepository`: protocolo que define las operaciones esperadas.
- `FetchDogsUseCase`: caso de uso que abstrae la obtención de perros.
- Esta capa **no tiene dependencias** con el resto del sistema.

### 3. Data Layer (`Data/`)
Contiene las implementaciones concretas de los repositorios y fuentes de datos:
- `DogRepositoryImpl`: implementación concreta del repositorio.
- **Local Data Source**: utiliza CoreData para persistencia (`CoreDataDogDataSource`).
- **Remote Data Source**: usa `APIClient` con `URLSession`.
- Incluye mapeos desde/para DTOs (`DogDTO`, `DogEntity+Mapping`).

### 4. Core Layer (`Core/`)
Componentes comunes y utilitarios:
- `Networking/`: Definición del protocolo `APIClient` y su implementación.
- `Persistence/`: Infraestructura base de CoreData (`CoreDataStack`).
- `Extensions/`: Ayudas generales y funciones utilitarias.

### 5. App Layer (`App/`)
- Punto de entrada con `@main` (`DogLandApp`).
- Controla el `WindowGroup`, y configuración general como apariencia de navegación.

### 6. Resources Layer (`Resources/`)
- `Assets.xcassets`: Imágenes, colores, etc.
- `Localizable.strings`: Soporte para internacionalización.

### 7. Tests Layer (`Tests/`)
Estructura de pruebas unitarias:
- `Mocks/`: Mocks para `APIClient`, `Repository`, `UseCase`.
- `UseCaseTests/`, `ViewModelTests/`, `RepositoryTests/`: Pruebas enfocadas en cada componente.

---

## 🧪 Testing

- Se utilizaron pruebas **unitarias puras**, con mocks para aislar dependencias.
- `@MainActor` permite testear fácilmente sin afectar la UI.
- No se incluye `UITest`, pero la arquitectura está lista para soportarlos.

---

## ✅ Buenas Prácticas

- Clean Architecture estricta: el dominio no depende de capas externas.
- Swift Concurrency: `async/await` + `MainActor`.
- Inyección de dependencias usando protocolos.
- Separación clara entre lógica de presentación, dominio y datos.
- Navegación encapsulada y desacoplada con `NavigationStack`.

---

## 📈 Posibles Mejoras

- Modularizar el proyecto con Swift Package Manager.
- Implementar Coordinators o un Router para la navegación.
- Soporte a múltiples entornos con `Environment` injection.
- Incorporar UI Tests con inyección de mocks.

---

## 📁 Estructura Visual de Carpetas

![Screenshot 2025-06-07 at 7 10 18 p m](https://github.com/user-attachments/assets/302b3754-d9e1-41bb-8bd2-0f3cea30c06f)

---

## 🚀 Conclusión

Este proyecto muestra una implementación robusta de una app iOS moderna, preparada para escalar, testear y mantener en el tiempo, aplicando lo mejor de SwiftUI, Swift Concurrency y Clean Architecture.
