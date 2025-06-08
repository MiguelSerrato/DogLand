# DogLand
Technical Test for iOS Developer role on Konfio


# Arquitectura y Estructura del Proyecto: DogLand 🐶

## 🧱 Arquitectura Adoptada

DogLand sigue una arquitectura **Clean Architecture + MVVM**, dividida en capas claramente separadas:

### 1. **Presentation**
- Se encarga de mostrar la interfaz de usuario y manejar la lógica de presentación con `ViewModel`.
- Utiliza SwiftUI con `NavigationStack` y `.task` para cargar los datos.

### 2. **Domain**
- Contiene entidades de negocio (`Dog`), protocolos de repositorio y casos de uso (`FetchDogsUseCase`).
- No depende de capas externas (como red o persistencia), siguiendo los principios de Clean Architecture.

### 3. **Data**
- Proporciona implementaciones concretas de los repositorios definidos en `Domain`.
- Divide las fuentes de datos en `Remote` (APIClient) y `Local` (Core Data).
- Realiza el mapeo entre DTOs/CoreData y entidades del dominio.

### 4. **Core**
- Contiene componentes reutilizables de bajo nivel como `APIClient`, helpers, y utilidades generales.

### 5. **App**
- Contiene el entry point (`DogLandApp`) y configuración general del entorno.

### 6. **Tests**
- Incluye pruebas unitarias para:
  - `UseCases`: Verifica que se aplique correctamente la lógica de negocio.
  - `ViewModels`: Valida el comportamiento de la UI con `MockUseCases`.
  - `Repositories`: Comprueba que las implementaciones respondan como se espera.

---

## 🗂️ Estructura de Carpetas

![Screenshot 2025-06-07 at 7 10 18 p m](https://github.com/user-attachments/assets/302b3754-d9e1-41bb-8bd2-0f3cea30c06f)


---

## ✅ Buenas Prácticas Aplicadas

- `@MainActor` en `ViewModel` para garantizar seguridad de concurrencia.
- `@StateObject` para mantener el estado del `ViewModel`.
- Uso de `async/await` para peticiones limpias y claras.
- `CommandLine.arguments` solo para propósitos de test o entrada condicional (actualmente eliminados).
- Separación de responsabilidades clara: cada componente sabe solo lo que necesita saber.

---

## 💡 Posibles Mejoras Futuras

- Agregar soporte a múltiples entornos (producción/test).
- Incorporar navegación coordinada o routers.
- Implementar caching con invalidación más controlada.
- Incluir Swift Package Manager o Modularización.

