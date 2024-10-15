# 🐾 Mi Mejor Ser

[![Ver Demo](https://img.shields.io/badge/Ver-Demo-blue?style=for-the-badge&logo=youtube)](https://youtu.be/zqXbgj1oE7w) 

**Mi Mejor Ser** es una aplicación móvil desarrollada en **Flutter** que tiene como objetivo fomentar la adopción de hábitos saludables mediante el uso de gamificación. Los usuarios pueden realizar un seguimiento de sus prácticas diarias, completar objetivos, ganar monedas y cuidar a una mascota virtual mientras progresan hacia su mejor versión.

---

## 🎯 Objetivo del Proyecto

El objetivo principal de **"Mi Mejor Ser"** es fomentar la adopción de hábitos saludables en los usuarios a través de elementos de gamificación. La aplicación se centra en el seguimiento de prácticas diarias, ya sean:

- **Booleanas:** Como desayunar, caminar o meditar.
- **Cuantificables:** Como beber agua o hacer ejercicio, donde se definen cuántas veces se debe realizar la práctica en el día.

---

## 📱 Características Clave

- **Panel de progreso:**  
  Visualización clara del avance diario y seguimiento de la racha de hábitos completados.

- **Registro de prácticas:**  
  Flexibilidad para agregar nuevas prácticas o seleccionar de una lista predefinida. Cada práctica incluye la definición del número de veces que debe realizarse durante el día.

- **Completado de prácticas:**  
  Mecanismo sencillo e intuitivo para marcar una práctica como realizada.

- **Gamificación:**  
  Cuida a una mascota virtual que refleja tu progreso y recibe recompensas en forma de monedas para comprar accesorios.

- **Simulación del avance de días:**  
  Opción para avanzar manualmente los días y verificar el progreso mediante pruebas.

- **Notificaciones:**  
  Recordatorios para mantener el enfoque en los hábitos diarios y no perder la racha.

---

## 🚀 Instalación y Ejecución

### **Prerrequisitos**

- Tener **Flutter** instalado. Si no lo tienes, sigue la guía oficial: [Instalación de Flutter](https://flutter.dev/docs/get-started/install).
- Un emulador Android/iOS o un dispositivo físico conectado.

### **Pasos para ejecutar el proyecto**

1. Clona este repositorio:
   ```bash
   git clone https://github.com/JaymedDLC/project1_movil_g7.git
   cd project1_movil_g7
2. Instala las dependencias:
   ```bash
   flutter pub get
3. Conecta un dispositivo o emulador:
   ```bash
   flutter pub get
4. Ejecuta la aplicación:
   ```bash
   flutter run


### 📦 Dependencias
Flutter: SDK principal para el desarrollo.
Provider: Manejo del estado de la aplicación.
Intl: Manipulación de fechas y horas.
Shared Preferences: Almacenamiento local de los hábitos y el progreso.
### ⚙️ Configuración adicional
Notificaciones: Configura el archivo notification_service.dart para activar las notificaciones en Android/iOS.
Persistencia de Datos: La aplicación utiliza SharedPreferences para almacenar los hábitos y el progreso localmente.
