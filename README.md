# Pokémon Pokédex

Esta aplicación es una Pokédex moderna desarrollada con Flutter, diseñada para ofrecer una experiencia fluida y robusta. El proyecto cumple con los más altos estándares de calidad de software, aplicando Clean Architecture, principios SOLID y las mejores prácticas del ecosistema Flutter.

## 💻 Entorno de Desarrollo y Soporte

Para garantizar la estabilidad y el rendimiento, el proyecto se ha desarrollado y probado bajo las siguientes especificaciones:

*   **Versiones de Desarrollo:**
    *   **Flutter:** 3.35.2 (Channel stable)
    *   **Dart:** 3.9.0
*   **Entornos de Prueba (Compilación y Simulación):**
    *   **iOS:** Compilado y verificado con éxito en emulador con **iOS 16.2**.
    *   **Android:** Compilado y verificado con éxito en emulador con **Android 16** (API Level 35/36 preview).
*   **Soporte Mínimo (Configurado):**
    *   **iOS:** Compatible desde **iOS 13.0** en adelante.
    *   **Android:** Compatible desde **API 21** (Android 5.0 Lollipop) en adelante.

---

## 🚀 Cómo ejecutar el proyecto

Para correr esta aplicación localmente, asegúrate de tener instalado Flutter (versión >= 3.9.0) y sigue estos pasos:

1.  **Clonar el repositorio:**
    ```bash
    git clone https://github.com/JulianRodelo11/pokemons.git
    cd pokemons
    ```

2.  **Instalar dependencias:**
    ```bash
    flutter pub get
    ```

3.  **Generar código necesario (Riverpod, Freezed):**
    ```bash
    dart run build_runner build --delete-conflicting-outputs
    ```

4.  **Generar traducciones:**
    ```bash
    flutter gen-l10n
    ```

5.  **Ejecutar la aplicación:**
    ```bash
    flutter run
    ```

6.  **Ejecutar la suite de tests completa:**
    ```bash
    flutter test
    ```

7.  **Ejecutar tests individuales por flujo:**
    *   **Splash:** `flutter test test/splash_flow_test.dart` (Valida navegación post-animación).
    *   **Onboarding:** `flutter test test/onboarding_flow_test.dart` (Valida flujo hasta el Home).
    *   **Búsqueda:** `flutter test test/pokedex_flow_test.dart` (Valida carga y filtros de nombre).
    *   **Idioma:** `flutter test test/language_flow_test.dart` (Valida cambio dinámico ES/EN).
    *   **Favoritos:** `flutter test test/favorites_flow_test.dart` (Valida persistencia y UI de favoritos).
    *   **Errores:** `flutter test test/error_flow_test.dart` (Valida pantalla de error y reintento).

---

## 🛠️ Stack Tecnológico

El proyecto utiliza las herramientas recomendadas para garantizar escalabilidad y mantenibilidad:

*   **Gestión de Estado:** `Riverpod` con anotaciones (`riverpod_generator`) para un estado reactivo, seguro y fácil de testear.
*   **Modelos de Datos:** `Freezed` para garantizar la inmutabilidad de los datos y facilitar el uso del patrón `copyWith`.
*   **Networking:** `Dio` como cliente HTTP, configurado con una arquitectura desacoplada para el consumo de la PokeAPI.
*   **I18N (Internacionalización):** Soporte completo para **Español** e **Inglés**, con un flujo dinámico de cambio de idioma desde el perfil.
*   **UI/UX:** Basado en **Material Design 3**, con animaciones personalizadas (Splash 3D, transiciones Hero y Skeletons).

---

## 🏗️ Arquitectura: Clean Architecture

Se ha implementado una separación de responsabilidades clara dividiendo el proyecto en tres capas principales:

1.  **Domain (Dominio):** La capa más interna. Contiene las **Entidades** puras del negocio y las definiciones de los **Repositorios** (interfaces). Es totalmente independiente de cualquier framework o librería externa.
2.  **Data (Datos):** Implementa las interfaces del dominio. Contiene los **Modelos** (DTOs con Freezed), **DataSources** (llamadas a la API con Dio) y la lógica de persistencia de favoritos.
3.  **Presentation (Presentación):** Contiene los **Widgets** de la UI y los **Providers** de Riverpod. Sigue el patrón *State-Notifier* para manejar el estado de forma predecible.

---

## 🧼 Buenas Prácticas y Patrones

*   **SOLID & KISS:** El código está diseñado para ser simple y seguir principios de responsabilidad única.
*   **DRY (Don't Repeat Yourself):** Centralización de constantes, rutas y widgets comunes.
*   **Inmutabilidad:** Uso riguroso de `final` y `Freezed` para evitar efectos secundarios inesperados.
*   **Inyección de Dependencias:** Gestionada de forma nativa por Riverpod, facilitando el desacoplamiento y el testing.

---

## 🧪 Estrategia de Testing

El proyecto cuenta con una suite de tests automáticos que garantizan la integridad de los flujos principales:

*   **Tests de Flujo de UI:** Cobertura de la navegación (Splash → Onboarding → Home).
*   **Tests de Lógica:** Validación de la búsqueda de Pokémon, filtros y gestión de favoritos.
*   **Test de Error:** Verificación del estado de error forzado y el flujo de reintento ("Retry").
*   **I18N Testing:** Validación de que la UI se actualiza correctamente al cambiar de idioma.

---

## 🛡️ Capas de Seguridad

Se han aplicado medidas para asegurar la robustez de la aplicación:

1.  **Validación de Datos:** El parsing manual y estructurado de la PokeAPI asegura que la aplicación no falle ante cambios inesperados en la estructura del JSON.
2.  **Manejo de Errores Global:** Implementación de estados de error visuales y funcionales para prevenir que la app quede en un estado inconsistente ante fallos de red.
3.  **Integridad de Estado:** Al usar Riverpod, el estado es inmutable y solo puede ser modificado a través de acciones controladas en los proveedores.

---

## 🤖 Uso de IA (Cursor & Gemini CLI)

Este proyecto fue desarrollado bajo un modelo de **IA-Augmented Development**, donde la colaboración hombre-máquina permitió alcanzar un nivel superior de calidad y rapidez:

*   **Cursor (IDE):** Fue la herramienta principal para el desarrollo activo de la aplicación. Se utilizó extensamente para:
    *   Diseñar y estructurar toda la **lógica de negocio y servicios** siguiendo Clean Architecture.
    *   Implementar la integración con la PokeAPI y la lógica de gestión de estado con **Riverpod**.
    *   Generar el scaffolding de las vistas y animaciones base del Design System.
*   **Gemini CLI:** Actuó como un **revisor técnico avanzado y especialista en QA/Refactoring**. Su participación fue clave para:
    *   Diseñar la arquitectura de **Testing de UI** y asegurar la cobertura de flujos críticos.
    *   Liderar refactorizaciones complejas (como la unificación de modelos a **Freezed**).
    *   Optimizar configuraciones de plataforma (Android/iOS) y depurar errores sutiles de sincronización de estado.
*   **Sinergia y Estándares:** Ambas herramientas trabajaron en conjunto bajo una configuración de reglas estrictas (`GEMINI.md`) para asegurar que el código no solo fuera funcional, sino que respetara rigurosamente los principios SOLID y la mantenibilidad a largo plazo.

---

## 🎨 Diseño (Figma)

- [Pokédex – Figma](https://www.figma.com/design/edU7Pms8bvosgSYW23yOds/Pokédex?node-id=0-1&p=f&t=fajq6ERQSCi0Q15U-0)  
  Implementación fiel del flujo de navegación y del design system propuesto.
